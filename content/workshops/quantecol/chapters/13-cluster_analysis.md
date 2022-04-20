---
date: "2021-01-01"
draft: false
excerpt: What you need to know upfront.
subtitle: ""
title: "13. Cluster analysis"
weight: 17
---

<!-- # Topic 13: Cluster analysis -->

> "There are two types of people in the world: 1) those who extrapolate from incomplete data." -- Anon.

We have seen that the WHO/SDG data seem to form neat groupings of countries within their respective parent locations. In this exercise we will apply a cluster analysis called 'Partitioning Around Medoids' to these data. Whereas ordination attempts to display the presence and influence of gradients, clustering tries to place our samples into a certain number of discrete units or clusters. The goal of the clustering algorithms is to produce groups (clusters) such that dissimilarites between objects within these groups are smaller than those between them.

My reading of the ecological literature suggests that cluster analysis is far less common than ordination, unless you're an ecologist with conservationist tendencies. If this is a true observation, why would it be? This is also the reason why I spend less time in this module on cluster analysis, but it is nevertheless a tool that you should be familiar with. Sometimes clustering techniques are combined with ordinations (particularly PCA), in which case they can be quite powerful and insightful.

Broadly speaking, clustering algorithms can be devided into ['hierarchical agglomerative classification'](https://www.davidzeleny.net/anadat-r/doku.php/en:hier-agglom_r) and [non-hierarchical classification (e.g. K-means)](https://www.davidzeleny.net/anadat-r/doku.php/en:non-hier_r). Numerical Ecology in R provides more information about the various kinds of classifications and makes the following distinctions of classification methods: 'sequential or simultaneous,' 'agglomerative or divisive,' 'monothetic versus polythetic,' 'hierarchical versus non-hierarchical methods,' 'probabilistic versus non-probabilistic,' and 'fuzzy' methods. Regardless of how one classifies the classification alogrithms, they are well-represented in R. The workhorse cluster analysis package in R is, strangely, called **cluster**. The function we will use in this example is called `pam()` but several other functions are also available, most notably 'Agglomerative Nesting (Hierarchical Clustering)' called by `agnes()`, 'DIvisive ANAlysis Clustering' by `diana()`, and 'Fuzzy Analysis Clustering' by `fanny()`. The `kmeans()` and `hclust()` functions in base R are also available and frequently used by ecologists. Of course, there is also the old faithful [TWINSPAN](https://github.com/jarioksa/twinspan) which has been ported to R that might be of interest still, and [IndVal](https://doi.org/10.1016/B978-0-12-384719-5.00430-5), which is a modern replacement for TWINSPAN. All of the cluster analyses functions come with their own plotting methods, and you should become familiar with them.

The package **factoextra** provides useful helper functions for cluster analysis, and also provides clustering functions that can be used *in lieu* of the ones mentioned above.

For examples of clustering, please refer to:

1.  Numerical Ecology in R, pp. 53-62. Later pages in the Cluster Analysis chapter go deeper into clustering and you should read over it for a broad overview. For the purpose of this module, we will focus on 4.3 Hierarchical Clustering and 4.4 Agglomerative Clustering.
2.  A [Kaggle challenge](https://www.kaggle.com/davimattar/help-international-clustering-using-r) with examples of both Hierarchical Clustering and K-means Clustering.
3.  The `iris` dataset is an excellent dataset to practice cluster analysis on; in fact, cluster analysis examples of this dataset are common on the internet.

Let's explore the WHO/SDG dataset usig the `pam()` function.

## Set-up the analysis environment


```r
library(tidyverse) 
library(cluster)
library(ggcorrplot)
library(factoextra)
library(vegan)
library(ggpubr)
```

## Load the SDG data

I load the combined dataset that already had their missing values imputed (as per the [PCA](https://github.com/ajsmit/Quantitative_Ecology/blob/main/jupyter_lab/Topic_8-PCA-SDG-example.ipynb) example).


```r
SDGs <- read_csv("/Users/ajsmit/Dropbox/R/workshops/Quantitative_Ecology/exercises/WHO/SDG_complete.csv")
```

```
## Rows: 176 Columns: 40
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (2): ParentLocation, Location
## dbl (38): other_1, other_2, SDG1.a, SDG16.1, SDG3.1_1, SDG3.2_1, SDG3.2_2, S...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
SDGs[1:5, 1:8]
```

```
## # A tibble: 5 × 8
##   ParentLocation       Location other_1 other_2 SDG1.a SDG16.1 SDG3.1_1 SDG3.2_1
##   <chr>                <chr>      <dbl>   <dbl>  <dbl>   <dbl>    <dbl>    <dbl>
## 1 Eastern Mediterrane… Afghani…    61.6    15.6   2.14    9.02      673   135.  
## 2 Europe               Albania     77.8    21.1   9.62    3.78       16     7.55
## 3 Africa               Algeria     76.5    21.8  10.7     1.66      113    38.0 
## 4 Africa               Angola      61.7    16.7   5.43    9.82      246   125.  
## 5 Americas             Antigua…    76.1    20.4  11.6     2.42       43     5.94
```

The parent locations:


```r
unique(SDGs$ParentLocation)
```

```
## [1] "Eastern Mediterranean" "Europe"                "Africa"               
## [4] "Americas"              "Western Pacific"       "South-East Asia"
```

The number of countries:


```r
length(SDGs$Location)
```

```
## [1] 176
```

As is often the case with measured variables, we can start our exploration with a correlation analysis to see the extent to which correlation between variable pairs is present:


```r
# a correalation matrix
corr <- round(cor(SDGs[3:ncol(SDGs)]), 1)
ggcorrplot(corr, type = 'upper', outline.col = "white", 
          colors = c("navy", "white", "#FC4E07"), 
          lab = TRUE)
```

<img src="/workshops/quantecol/chapters/13-cluster_analysis_files/figure-html/unnamed-chunk-5-1.png" width="672" />

We might decide to remove collinear variables. A useful approach to use here might be to look at the strongest loadings along the significant reduced axes in a PCA and exclude the others, or find the ones most strongly correlated as seen in the biplots---how you do this can be rationalised on a case-by-case basis. I proceed with the full dataset, but this is not ideal.

We need to standardise first to account for the different measurement scales of the variables. We can calculate Euclidian distances before running `pam()`, but it can also be specified within the function call. We do the latter:


```r
SDGs_std <- decostand(SDGs[3:ncol(SDGs)], method = "standardize")
# SDGs_euc <- vegdist(SDGs_std, method = "euclidian")
rownames(SDGs_std) <- SDGs$Location # carry location names into output
```

The frustrating thing with cluster analysis, which often confuses novice users, is that there is often an expectation that the clustering alorithm decides for the user how many clusters to use. However, this is a misconception that must be overcome. Although some numerical guidance can be obtained through 'silhouette,' 'within cluster sum of squares' or 'elbow' analysis, and 'gap statistic', in my experience they are no substitute for the power of human reasoning. Let us see what the **factoextra** package function `fviz_nbclust()` tell us about how many group to use:


```r
# using silhouette analysis
plt1 <- fviz_nbclust(SDGs_std, cluster::pam, method = "silhouette") + theme_grey()

# total within cluster sum of square / elbow analysis
plt2 <- fviz_nbclust(SDGs_std, cluster::pam, method = "wss") + theme_grey()

# gap statistics
plt3 <- fviz_nbclust(SDGs_std, cluster::pam, method = "gap_stat") + theme_grey()

ggarrange(plt1, plt2, plt3, nrow = 3)
```

<img src="/workshops/quantecol/chapters/13-cluster_analysis_files/figure-html/unnamed-chunk-7-1.png" width="672" />

Even with the supposedly objective assessment of what the optimal number of clusters should be, we see that each method still provides a different result. Much better to proceed with expert knowledge about the nature of the data and the intent of the study. Let us proceed with three clusters as I think two clusters are insufficient for our purpose.


```r
SDGs_pam <- pam(SDGs_std, metric = "euclidean", k = 3)

fviz_cluster(SDGs_pam, geom = "point", ellipse.type = "convex", palette = c("#FC4E07", "violetred3", "deepskyblue3"), ellipse.alpha = 0.05) +
  geom_text(aes(label = SDGs$Location), size = 2.5)
```

<img src="/workshops/quantecol/chapters/13-cluster_analysis_files/figure-html/unnamed-chunk-8-1.png" width="672" />

We cannot clearly see where SA is, so let's create a clearer plot:


```r
# scale SA bigger for plotting
SDGs <- SDGs |> 
  mutate(col_vec = ifelse(Location == "South Africa", "black", "grey50"),
         scale_vec = ifelse(Location == "South Africa", 3.5, 2.5))

fviz_cluster(SDGs_pam, geom = "point", ellipse.type = "convex",
             palette = c("#FC4E07", "violetred3", "deepskyblue3"),
             ellipse.alpha = 0.05, pointsize = 2.0) +
  geom_text(aes(label = SDGs$Location), size = SDGs$scale_vec, col = SDGs$col_vec)
```

<img src="/workshops/quantecol/chapters/13-cluster_analysis_files/figure-html/unnamed-chunk-9-1.png" width="672" />

Note that `pam()`, unlike hierarchical or agglomerative clustering, does not produce a dendrogram and the usual way to graphically present the cluster arrangement is to create a scatter plot similar to an ordination diagramme (but it is NOT an ordination diagram).

Same as above, but showing a star plot and numbers indicating the countries (their row numbers in `SDGs`):


```r
fviz_cluster(SDGs_pam, palette = c("#FC4E07", "violetred3", "deepskyblue3"), ellipse.type = "euclid", 
             star.plot = TRUE, repel = TRUE, pointsize = SDGs$scale_vec * 0.8) + # SA, no 147, plotted slightly bigger
  theme_grey()
```

```
## Warning: ggrepel: 153 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

<img src="/workshops/quantecol/chapters/13-cluster_analysis_files/figure-html/unnamed-chunk-10-1.png" width="672" />

Do a silhouette analysis to check cluster fidelity:


```r
fviz_silhouette(SDGs_pam, palette = c("#FC4E07", "violetred3", "deepskyblue3"), ggtheme = theme_grey())
```

```
##   cluster size ave.sil.width
## 1       1   46          0.27
## 2       2   78          0.09
## 3       3   52          0.27
```

<img src="/workshops/quantecol/chapters/13-cluster_analysis_files/figure-html/unnamed-chunk-11-1.png" width="672" />

Once happy with the number of clusters, find the median value for each cluster:


```r
SDGs_centroids <- SDGs |> 
  mutate(cluster = SDGs_pam$clustering) |> 
  group_by(cluster) |> 
  summarise_at(vars(other_1:SDG3.b_5), median, na.rm = TRUE)
SDGs_centroids
```

```
## # A tibble: 3 × 39
##   cluster other_1 other_2 SDG1.a SDG16.1 SDG3.1_1 SDG3.2_1 SDG3.2_2 SDG3.2_3
##     <int>   <dbl>   <dbl>  <dbl>   <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
## 1       1    62.4    16.7   5.43    8.88      396    90.0    214.     152.  
## 2       2    73.2    19.6   9.64    4.4        60    19.8     33.9     28.1 
## 3       3    80.4    23.2  13.3     1.28        7     2.78     4.73     4.00
## # … with 30 more variables: SDG3.3_1 <dbl>, SDG3.3_2 <dbl>, SDG3.3_3 <dbl>,
## #   SDG3.3_4 <dbl>, SDG3.3_5 <dbl>, SDG3.4_1 <dbl>, SDG3.4_2 <dbl>,
## #   SDG3.4_3 <dbl>, SDG3.4_4 <dbl>, SDG3.4_5 <dbl>, SDG3.4_6 <dbl>,
## #   SDG3.5 <dbl>, SDG3.6 <dbl>, SDG3.8_1 <dbl>, SDG3.8_2 <dbl>, SDG3.9_1 <dbl>,
## #   SDG3.9_3 <dbl>, SDG3.b_1 <dbl>, SDG3.b_2 <dbl>, SDG3.b_3 <dbl>,
## #   SDG3.b_4 <dbl>, SDG3.c_1 <dbl>, SDG3.c_2 <dbl>, SDG3.c_3 <dbl>,
## #   SDG3.c_4 <dbl>, SDG3.d_1 <dbl>, SDG3.7 <dbl>, SDG3.a <dbl>, …
```

`pam()` can also provide the most representative example countries of each cluster. Note that the values inside are very different from that produced when we calculated the medians because `medoids` report the standardised data:


```r
SDGs_pam$medoids
```

```
##              other_1     other_2     SDG1.a     SDG16.1   SDG3.1_1   SDG3.2_1
## Togo      -1.3082283 -1.04437853 -1.1903643  0.06808945  1.1324894  1.3017843
## Nicaragua  0.3737688  0.08872107  1.3796506  0.08533933 -0.2323864 -0.2586716
## Czechia    0.8823411  0.61551298  0.8833042 -0.64737012 -0.6765494 -0.8435034
##             SDG3.2_2   SDG3.2_3   SDG3.3_1   SDG3.3_2   SDG3.3_3   SDG3.3_4
## Togo       1.4102734  1.3592849  0.1576964 -0.4579343  2.4882232  1.2835322
## Nicaragua -0.3767895 -0.3446689 -0.3154270 -0.4579343 -0.1580909 -0.6637395
## Czechia   -0.7133630 -0.7745694 -0.1376945 -0.7136379 -0.9480541 -0.5125539
##              SDG3.3_5   SDG3.4_1   SDG3.4_2   SDG3.4_3   SDG3.4_4    SDG3.4_5
## Togo      -0.06030043  1.2520369 -0.4762540 -0.6960758 -0.6952419 -0.07418662
## Nicaragua -0.16897721 -0.1601567  0.4796550 -0.5087310 -0.2996050 -0.62139368
## Czechia   -0.18762124 -0.9262184  0.1254489  1.1464418  0.3787484  0.33180571
##             SDG3.4_6     SDG3.5      SDG3.6   SDG3.8_1   SDG3.8_2   SDG3.9_1
## Togo      -0.2449637 -0.8481419  1.32097641 -0.2415269 -1.4304958  0.7715301
## Nicaragua -0.2418110 -0.2133414 -0.08575199 -0.2415269  0.5462165 -0.6816096
## Czechia   -0.1503081  2.0328759 -1.14835854  0.2417061  0.7438877 -0.2935552
##             SDG3.9_3    SDG3.b_1   SDG3.b_2   SDG3.b_3    SDG3.b_4   SDG3.c_1
## Togo       1.5236560  0.17567787 -1.0409470 -0.5061518 -0.02793898 -1.1831072
## Nicaragua -0.4682756 -0.03942639  0.2371043  0.7038002  0.94197637 -0.6102974
## Czechia   -0.5724488 -0.30874491  0.7352539  0.5525562  0.25560867  1.1612648
##             SDG3.c_2   SDG3.c_3   SDG3.c_4   SDG3.d_1     SDG3.7      SDG3.a
## Togo      -0.9983214 -1.1842216 -1.0940540 -1.0278904  0.8082986 -1.53587553
## Nicaragua -0.6958462  0.3067516  0.3246320  0.7660773 -0.2790219 -0.05503528
## Czechia    0.7385150  1.2426058  0.5534738  0.7415003 -0.9713149  1.07144665
##             SDG3.1_2   SDG3.b_5
## Togo      -1.3841046  0.7500056
## Nicaragua  0.5008573  0.1814304
## Czechia    0.9941603 -0.5157917
```

We can do a coloured pairwise scatterplot to check data details. I limit it here to the pairs of the first 7 columns because of the large number of possible combinations:


```r
pairs(SDGs[, 3:10], col = c("#FC4E07", "violetred3", "deepskyblue3")[SDGs_pam$clustering])
```

<img src="/workshops/quantecol/chapters/13-cluster_analysis_files/figure-html/unnamed-chunk-14-1.png" width="672" />

### Questions

This is the fnal set of questions for Quantitative Ecology.

1.  What happens if we use `pam()` to create four, five, or even six clusters?
2.  In your reasoned opinion, what would be the optimal number of clusters to use?
3.  Repeat the analysis using either `kmeans()` or `hclust()`, and feel free to use the **factoextra** helper functions and visualisations. Are the results markedly different? Which clustering approach do you wish to proceed with---i.e., `pam()`, `hclust()` or `kmeans()`?
4.  Build upon the narrative that you have already developed in the [previous assignment](https://github.com/ajsmit/Quantitative_Ecology/blob/main/jupyter_lab/Topic_8-PCA-SDG-example.ipynb) and describe the patterns that you observe at the end of your final cluster selection (i.e. based on the optimal number of clusters and whichever cluster technique you deem most appropriate), and explain these patterns in terms of the global socio-political/socio-economic landscape.
5.  Regardless of how many clusters you choose, South Africa often seems to teeter at the edge between the group of African countries and some other parent location. Why?

[You are welcome to submit the entire asignment (the [previous assignment](https://github.com/ajsmit/Quantitative_Ecology/blob/main/jupyter_lab/Topic_8-PCA-SDG-example.ipynb) and this one) in an R script wherein you provide answers to these questions by no later than 17:00 on Monday 2 August 2021.]{style="color:red"}
