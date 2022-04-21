---
date: "2021-01-01"
draft: false
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: Constrained Ordination Slides
    url: /pdf/BCB743/BCB743_12_constrained_ordination.pdf
  - icon: file-pdf
    icon_pack: far
    name: Smit et al. (2017)
    url: /pdf/BCB743/Smit_et_al_2017.pdf
  - icon: file-pdf
    icon_pack: far
    name: The Seaweed Data
    url: /pdf/BCB743/The_seaweed_data.pdf
  - icon: file-csv
    icon_pack: fa
    name: SeaweedsSpp.csv
    url: /data/BCB743/seaweed/SeaweedsSpp.csv
  - icon: file
    icon_pack: far
    name: SeaweedsEnv.RData
    url: /data/BCB743/seaweed/SeaweedEnv.RData
  - icon: file-csv
    icon_pack: fa
    name: bioregions.csv
    url: /data/BCB743/seaweed/bioregions.csv
  - icon: file-csv
    icon_pack: fa
    name: sites.csv
    url: /data/BCB743/seaweed/sites.csv    
subtitle: ""
title: "12. Constrained Ordination"
weight: 16
---

<!--- # Topic 12: Constrained ordination --->

Up to now we have applied indirect gradient analyses. The lecture slides mention several constrained ordinations and provide some theory for three of them, viz. **Redundancy Analysis (RDA)**, **Canonical Correspondence Analysis (CCA)**, and **distance-based Reducndancy Analysis (db-RDA)**. Constrained ordination is sometimes called 'direct gradient analysis'.

Constrained ordination is used to extract and summarise the variation in a set of response variables (species data in the case of ecology) that can be explained by some explanatory variables ('constraints'), such as measurements of environmental properties at the places where the species data were collected from.

**RDA** is a direct gradient analysis that highlights linear relationships between components of response variables, i.e. variables that are 'redundant' with (i.e. 'explained' by) a set of predictors. RDA is an extension of a PCA with a multiple linear regression. The same constraints inherent in a PCA present themselves in an RDA. Use **vegan**'s `rda()` to perform an RDA.

**CCA** is the extension of a CA with multiple regression, and is therefore also based on 𝝌2-metric (dissimilarities). We do not have a choice of spcifying which dissimilarity meric to use. CCA performs best when species distribution follows a unimodal model. Use **vegan**'s `cca()` to perform an RDA.

**db-RDA** can be viewed as the extension of a PCoA with multiple regressions. As with a PCoA, we also benefit from being able to specify any dissimilarity matrix as input, and hence this approach is more versatile compared to RDA or CCA. I prefer the db-RDA implemented in **vegan**'s `capscale()`. The help file states: "Distance-based redundancy analysis (dbRDA) is an ordination method similar to Redundancy Analysis (rda), but it allows non-Euclidean dissimilarity indices, such as Manhattan or Bray--Curtis distance."

## The seaweed dataset

For this example we will use the seaweed data of Smit et al. (2017); please make sure that you read it! An additional file describing the background to the data is available at the link above (see **The_seaweed_data.pdf**).

I use two data sets. The first, `\(Y\)` (in the file `seaweeds.csv`), comprises distribution records of 847 macroalgal species within each of 58 × 50 km-long sections of the South African coast (updated from Bolton and Stegenga 2002). This represents *ca*. 90% of the known seaweed flora of South Africa, but excludes some very small and/or very rare species for which data are insufficient. The data are from verifiable literature sources and John Bolton and Rob Anderson's own collections, assembled from information collected by teams of phycologists over three decades (Bolton 1986; Stegenga et al. 1997; Bolton and Stegenga 2002; De Clerck et al. 2005).

The second, `\(E\)` (in `env.csv`), is a dataset of *in situ* coastal seawater temperatures (Smit et al. 2013) derived from daily measurements over up to 40 years.

## Set-up the analysis environment


```r
library(tidyverse)
library(betapart)
library(vegan)
library(gridExtra)
library(grid)
library(gridBase)

# setting up a 'root' file path so I don't have to keep doing it later...
root <- "../../../../static/data/BCB743/"
```

Load the seaweed data:


```r
spp <- read.csv(paste0(root, 'seaweed/SeaweedsSpp.csv'))
spp <- dplyr::select(spp, -1)
dim(spp)
```

```
## [1]  58 847
```

## Set-up the data

The first step involves the species table ($Y$). First I compute the Sørensen dissimilarity, which I then decompose into 'nestedness-resultant' ($\beta_\text{sne}$) and 'turnover' ($\beta_\text{sim}$) components using the `betapart.core()` and `betapart.pair()` functions of the **betapart** package (Baselga et al., 2017). These are placed into the matrices `\(Y1\)` and `\(Y2\)`. It is not necessary to decompose into `\(Y1\)` and `\(Y2\)`, but I do so here because I want to focus on the turnover component without a nestedness-resultant influence. Optionally, I can apply a CA, PCoA, or nMDS on `\(Y\)` to find the major patterns in the community data. The formal analysis will use the species data in a distance-based redundancy analyses (db-RDA as per **vegan**'s `capscale()` function) by coupling it with `\(E\)`.


```r
Y.core <- betapart.core(spp) 
Y.pair <- beta.pair(Y.core, index.family = "sor")

# Let Y1 be the turnover component (beta-sim):
Y1 <- as.matrix(Y.pair$beta.sim)
```

It is now necessary to load the environmental data and some setup files that partition the 58 coastal sections (and the species and environmental data that fall within these sections) into bioregions.

The thermal (environmental) data contain various variables, but in the analysis I use only some of them. These data were obtained from many sites along the South African coast, but using interpolation (not included here) I calculated the thermal properties for each of the coastal sections for which seaweed data are available. Consequently we have a data frame with 58 rows and a column for each of the thermal metrics.


```r
load(paste0(root, "seaweed/SeaweedEnv.RData"))
dim(env)
```

```
## [1] 58 18
```

Note that they have the same number of rows as the seaweed data.

I select only some of the thermal vars; the rest are collinear with some of the ones I import:


```r
E1 <- dplyr::select(env, febMean, febRange, febSD, augMean,
                    augRange, augSD, annMean, annRange, annSD)
```

Next I calculate *z*-scores:


```r
E1 <- decostand(E1, method = "standardize")
```

Four bioregions are recognised for South Africa by Bolton and Anderson (2004) (the variable called `bolton`), namely the Benguela Marine Province (BMP; coastal sections **1**--**17**), the Benguela-Agulhas Transition Zone (B-ATZ; **18**--**22**), the Agulhas Marine Province (AMP; **19**--**43**/**44**) and the East Coast Transition Zone (ECTZ; **44**/**45**--**58**). My plotting functions partition the data into the bioregions and colour code the figures accordingly so I can see regional patterns in `\(\beta\)`-diversity emerging.


```r
bioreg <- read.csv(paste0(root, 'seaweed/bioregions.csv'), header = TRUE)
head(bioreg)
```

```
##   spal.prov spal.ecoreg lombard bolton
## 1       BMP          NE   NamBR    BMP
## 2       BMP          NE   NamBR    BMP
## 3       BMP          NE   NamBR    BMP
## 4       BMP          NE   NamBR    BMP
## 5       BMP          NE   NamBR    BMP
## 6       BMP          NE   NamBR    BMP
```

Load the geographic coordinates for the coastal sections:


```r
sites <- read.csv(paste0(root, "seaweed/sites.csv"))
sites <- sites[, c(2, 1)]
head(sites)
```

```
##   Longitude  Latitude
## 1  16.72429 -28.98450
## 2  16.94238 -29.38053
## 3  17.08194 -29.83253
## 4  17.25928 -30.26426
## 5  17.47638 -30.67874
## 6  17.72167 -31.08580
```

```r
dim(sites)
```

```
## [1] 58  2
```

Again, we have 58 rows of data for both the coastal section coordinates and the bioregions. You may omit the dataset with spatial coordinates as it is not actually used further below. Can you think of ways in which to use this dataset to graphically represent the spatial distribution of some environmental or biodiversity data?

## Start the db-RDA

I test the niche difference mechanism as the primary species compositional assembly process operating along South African shores. I suggest that the thermal gradient along the coast provides a suite of abiotic (thermal) conditions from which species can select based on their physiological tolerances, and hence this will structure `\(\beta\)`-diversity. For this mechanism to function one would assume that all species have equal access to all sections along this stretch of coast, thus following 'Beijerinck's Law' that everything is everywhere but the environment selects (Sauer, 1988).

I do a RDA involving all the thermal variables in `\(E1\)` (the 'global analysis' resulting in the full model, `rda_full`). Analysis shown for `\(Y1\)`:


```r
# fit the full model:
rda_full <- capscale(Y1 ~., E1)
rda_full
```

```
## Call: capscale(formula = Y1 ~ febMean + febRange + febSD + augMean +
## augRange + augSD + annMean + annRange + annSD, data = E1)
## 
##                Inertia Proportion Rank
## Total          7.52344    1.00000     
## Constrained    6.86398    0.91235    8
## Unconstrained  1.02840    0.13669   28
## Imaginary     -0.36895   -0.04904   24
## Inertia is squared Unknown distance 
## Some constraints or conditions were aliased because they were redundant
## 
## Eigenvalues for constrained axes:
##  CAP1  CAP2  CAP3  CAP4  CAP5  CAP6  CAP7  CAP8 
## 5.620 1.155 0.074 0.006 0.004 0.003 0.001 0.001 
## 
## Eigenvalues for unconstrained axes:
##   MDS1   MDS2   MDS3   MDS4   MDS5   MDS6   MDS7   MDS8 
## 0.5768 0.1687 0.1096 0.0413 0.0322 0.0243 0.0179 0.0103 
## (Showing 8 of 28 unconstrained eigenvalues)
```


```r
# summary(rda_full)
# notice that the species scores are missing
# refer to PCoA for why
```

Species information is lost during the calculation of the dissimilarity matrix, but if the original matrix of species composition is available, the species scores can be added back into the ordination diagram as weighted means of site scores in which case they occur or as vectors fitted onto the ordination space.

Is the fit significant? I run a permutation test to check:


```r
anova(rda_full, parallel = 4) # ... yes!
```

```
## Permutation test for capscale under reduced model
## Permutation: free
## Number of permutations: 999
## 
## Model: capscale(formula = Y1 ~ febMean + febRange + febSD + augMean + augRange + augSD + annMean + annRange + annSD, data = E1)
##          Df SumOfSqs      F Pr(>F)    
## Model     8   6.8640 40.881  0.001 ***
## Residual 49   1.0284                  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Since the fit is significant (the environmental variables capture the variation seen in the species data), I compute the adjusted `\(R^{2}\)`:


```r
rda_full_R2 <- RsquareAdj(rda_full)$adj.r.squared
round(rda_full_R2, 2)
```

```
## [1] 0.9
```

The inertia accounted for by constraints:


```r
round(sum(rda_full$CCA$eig), 2)
```

```
## [1] 6.86
```

The remaining (unconstrained) inertia:


```r
round(sum(rda_full$CA$eig), 2)
```

```
## [1] 1.03
```

The total inertia:


```r
round(rda_full$tot.chi, 2)
```

```
## [1] 7.52
```

What is the proportion of variation explained by the full set environmental variables?


```r
round(sum(rda_full$CCA$eig) / rda_full$tot.chi * 100, 2) # in %
```

```
## [1] 91.23
```

I check for collinearity using variance inflation factors (VIF), and retain a subset of non-collinear variables to include in the 'reduced' or 'final' model. A common rule is that values over 10 indicate redundant constraints. I run the VIF procedure iteratively, each time removing the highest VIF and examining the remaining ones until these are mostly below 10.

First on the full model:


```r
vif.cca(rda_full)
```

```
##    febMean   febRange      febSD    augMean   augRange      augSD    annMean 
##  91.129700   6.775959   7.734436  73.090382   8.486631  12.118914 233.400746 
##   annRange      annSD 
##         NA   5.396343
```

Drop annMean:


```r
E2 <- dplyr::select(E1, -annMean)
rda_sel1 <- capscale(Y1 ~., E2)
vif.cca(rda_sel1)
```

```
##   febMean  febRange     febSD   augMean  augRange     augSD  annRange     annSD 
## 24.996152  6.149245  7.160637 17.717936  8.066340 10.726117        NA  5.396275
```

Drop febMean:


```r
E3 <- dplyr::select(E2, -febMean)
rda_sel2 <- capscale(Y1 ~., E3)
vif.cca(rda_sel2)
```

```
##  febRange     febSD   augMean  augRange     augSD  annRange     annSD 
##  6.149245  7.160637  1.619233  8.066340 10.726117  5.529971  5.396275
```

We select E3 as the variables to construct the final model (`rda_final`) from.

**Note:** you can switch to the formula interface within `capscale()` and specify the variables to use on the right-hand side of the formula (as shown but not executed). You will (obviously) no longer analyse only the turnover component of `\(\beta\)`-diversity as you'll be using the raw `spp` data that encapsulate both nestedness-resultant and turnover processes, but the upshot of this is that you'll now have species scores. Run this bit of code by yourself and see what the outcome is (the ordiplot is affected, as well as the `\(R^{2}\)`, number of significant reduced axes, etc.).


```r
rda_final <- rda_sel2
# rda_final <- capscale(spp ~ febRange + febSD + augMean + augRange + augSD + annRange + annSD, data = E3, distance = "jaccard")
```

We calculate the significance of the model, the variance explained by all the constraints (in `\(E3\)`) in the final model, as well as the `\(R^{2}\)`:


```r
# is the fit significant?
anova(rda_final, parallel = 4) # ... yes!
```

```
## Permutation test for capscale under reduced model
## Permutation: free
## Number of permutations: 999
## 
## Model: capscale(formula = Y1 ~ febRange + febSD + augMean + augRange + augSD + annRange + annSD, data = E3)
##          Df SumOfSqs      F Pr(>F)    
## Model     7   6.8251 45.675  0.001 ***
## Residual 50   1.0673                  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Which axes are significant?


```r
anova(rda_final, by = "axis", parallel = 4) # ... yes!
```

```
## Permutation test for capscale under reduced model
## Forward tests for axes
## Permutation: free
## Number of permutations: 999
## 
## Model: capscale(formula = Y1 ~ febRange + febSD + augMean + augRange + augSD + annRange + annSD, data = E3)
##          Df SumOfSqs        F Pr(>F)    
## CAP1      1   5.6179 263.1786  0.001 ***
## CAP2      1   1.1242  52.6665  0.001 ***
## CAP3      1   0.0725   3.3978  0.389    
## CAP4      1   0.0050   0.2320  1.000    
## CAP5      1   0.0027   0.1274  1.000    
## CAP6      1   0.0013   0.0632  1.000    
## CAP7      1   0.0013   0.0622  1.000    
## Residual 50   1.0673                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Extract the significant variables in `\(E3\)` that are influential in the final model as influencers of seaweed community differences amongsth coastal sections:


```r
(rda_final_axis_test <- anova(rda_final, by = "terms", parallel = 4))
```

```
## Permutation test for capscale under reduced model
## Terms added sequentially (first to last)
## Permutation: free
## Number of permutations: 999
## 
## Model: capscale(formula = Y1 ~ febRange + febSD + augMean + augRange + augSD + annRange + annSD, data = E3)
##          Df SumOfSqs        F Pr(>F)    
## febRange  1   1.0962  51.3541  0.001 ***
## febSD     1   0.1850   8.6653  0.001 ***
## augMean   1   5.3815 252.1023  0.001 ***
## augRange  1   0.0903   4.2286  0.018 *  
## augSD     1   0.0212   0.9918  0.372    
## annRange  1   0.0196   0.9191  0.358    
## annSD     1   0.0313   1.4666  0.226    
## Residual 50   1.0673                    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

The significant variables are:


```r
rda_final_ax <- which(rda_final_axis_test[, 4] < 0.05)
rda_final_sign_ax <- colnames(E3[,rda_final_ax])
rda_final_sign_ax
```

```
## [1] "febRange" "febSD"    "augMean"  "augRange"
```

The adjusted `\(R^{2}\)` for the constraints:


```r
round(rda_final_R2 <- RsquareAdj(rda_final)$adj.r.squared, 2) # %
```

```
## [1] 0.89
```

The variance explained by reduced (final) model:


```r
round(sum(rda_final$CCA$eig) / rda_final$tot.chi * 100, 2)
```

```
## [1] 90.72
```

The biplot scores for constraining variables:


```r
scores(rda_final, display = "bp", choices = c(1:2))
```

```
##                 CAP1        CAP2
## febRange -0.17951109 -0.90202271
## febSD    -0.08259676 -0.50969451
## augMean   0.98516406  0.15657181
## augRange  0.03499429 -0.14728687
## augSD    -0.01944793 -0.07441746
## annRange  0.41313533 -0.18050396
## annSD     0.20412535 -0.56833391
## attr(,"const")
## [1] 4.550643
```

These biplot scores will mark the position of the termini of the arrows that indicate the direction and strength of the constraining variables.

## Ordination diagrams

This code recreates Figure 2a in Smit et al. (2017):


```r
# use scaling = 1 or scaling = 2 for site and species scaling, respectively
rda_final_scrs <- scores(rda_final, display = c("sp", "wa", "lc", "bp"))
# see ?plot.cca for insight into the use of lc vs wa scores
# below I splot the wa (site) scores rather than lc (constraints) scores
site_scores <- data.frame(rda_final_scrs$site) # the wa scores
site_scores$bioreg <- bioreg$bolton
site_scores$section <- seq(1:58)

biplot_scores <- data.frame(rda_final_scrs$biplot)
biplot_scores$labels <- rownames(biplot_scores)
biplot_scores_sign <- biplot_scores[biplot_scores$labels %in% rda_final_sign_ax,]

ggplot(data = site_scores, aes(x = CAP1, y = CAP2, colour = bioreg)) +
  geom_point(size = 5.0, shape = 24, fill = "white") +
  geom_text(aes(label = section), size = 3.0, col = "black") +
  geom_label(data = biplot_scores_sign,
             aes(CAP1, CAP2, label = rownames(biplot_scores_sign)),
             color = "black") +
  geom_segment(data = biplot_scores_sign,
               aes(x = 0, y = 0, xend = CAP1, yend = CAP2),
               arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
               color = "lightseagreen", alpha = 1, size = 0.7) +
  xlab("CAP1") + ylab("CAP2") +
  ggtitle(expression(paste("Significant thermal variables and ", beta[sim]))) +
  theme_grey() +
  theme(panel.grid.minor = element_blank(),
        legend.position = "none",
        aspect.ratio = 0.8)
```

<img src="/workshops/quantecol/chapters/12-constrained_ordination_files/figure-html/unnamed-chunk-28-1.png" width="672" />

Note that in Smit et al. (2017, Fig. 2a) I plot the linear constraints (lc scores) rather than the site scores (wa scores). The fact that the positioning of the site scores in ordination space in the figure, above, represents a crude map of South Africa corresponding with geographical coordinates (N-E-S-W) is coincidental (yet it can be logically explained). The coenoclines and gradients are clearly discernible, and the west to east numbering of sites and transitioning of one bioregon into the next are obvious. This map-like arrangement of sites disappears when lc scores are used, but the interpretation of how the thermal drivers structure seaweed biodiversity remains the same.

## Dealing with factor variables


```r
E4 <- E3
# append the bioregs after the thermal vars
E4$bioreg <- bioreg$bolton
head(E4)
```

```
##      febRange      febSD   augMean    augRange        augSD   annRange
## 1 -0.04433865 -0.2713395 -1.376511 -0.47349787 -0.409770805 -1.0460150
## 2 -0.14318268 -0.1083868 -1.433925 -0.06998551 -0.096490845 -0.7657214
## 3 -0.39321619 -0.1719978 -1.526950  0.02484832  0.009053095 -0.6311568
## 4 -0.60199306 -0.3120605 -1.579735 -0.05076148  0.005487982 -0.5861267
## 5 -0.64081940 -0.4095900 -1.546420 -0.09833845  0.041336545 -0.8799034
## 6 -0.55083241 -0.4294142 -1.458642 -0.11132528  0.095589389 -1.2225182
##       annSD bioreg
## 1 -1.636461    BMP
## 2 -1.307622    BMP
## 3 -1.143445    BMP
## 4 -1.074994    BMP
## 5 -1.200028    BMP
## 6 -1.343088    BMP
```

```r
rda_cat <- capscale(Y1 ~., E4)
plot(rda_cat)
```

<img src="/workshops/quantecol/chapters/12-constrained_ordination_files/figure-html/unnamed-chunk-29-1.png" width="672" />

The default plot works okay and shows all necessary info, but the various pieces (site, species, and centroid scores) are not clearly discernable. Plot the class (factor) centroids in `ggplot()`:


```r
# also extractthe factor centroids for the bioregions
rda_cat_scrs <- scores(rda_cat, display = c("sp", "wa", "lc", "bp", "cn"))
site_scores <- data.frame(rda_cat_scrs$site) # the wa scores
site_scores$bioreg <- bioreg$bolton
site_scores$section <- seq(1:58)

biplot_scores <- data.frame(rda_cat_scrs$biplot)
biplot_scores$labels <- rownames(biplot_scores)
biplot_scores_sign <- biplot_scores[biplot_scores$labels %in% rda_final_sign_ax,]

bioreg_centroids <- data.frame(rda_cat_scrs$centroids)
bioreg_centroids$labels <- rownames(bioreg_centroids)
  
ggplot(data = site_scores, aes(CAP1, CAP2, colour = bioreg)) +
  geom_point(size = 5.0, shape = 24, fill = "white") +
  geom_text(aes(label = section), size = 3.0, col = "black") +
  geom_label(data = biplot_scores_sign,
             aes(CAP1, CAP2, label = rownames(biplot_scores_sign)),
             color = "black") +
  geom_segment(data = biplot_scores_sign,
               aes(x = 0, y = 0, xend = CAP1, yend = CAP2),
               arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
               color = "lightseagreen", alpha = 1, size = 0.7) +
  geom_label(data = bioreg_centroids,
             aes(x = CAP1, y = CAP2,
                 label = labels), size = 4.0,
             col = "black", fill = "yellow") +
  xlab("CAP1") + ylab("CAP2") +
  ggtitle(expression(paste("Significant thermal variables and ", beta[sim]))) +
  theme_grey() +
  theme(panel.grid.minor = element_blank(),
        legend.position = "none",
        aspect.ratio = 0.8)
```

<img src="/workshops/quantecol/chapters/12-constrained_ordination_files/figure-html/unnamed-chunk-30-1.png" width="672" />

## References

Baselga, A., Orme, D., Villeger, S., De Bortoli, J., and Leprieur, F. (2017). betapart: Partitioning Beta Diversity into Turnover and Nestedness Components. R package version 1.4-1. Available online at: <https://CRAN.R-project.org/package=betapart>

Bolton, J. J. (1986). Marine phytogeography of the Benguela upwelling region on the west coast of southern Africa: A temperature dependent approach. Botanica Marina 29, 251--256.

Bolton, J. J., and Anderson, R. J. (2004). "Marine vegetation," in Vegetation of Southern Africa, eds R. M. Cowling, D. M. Richardson, and S. M. Pierce, (Cambridge, UK: Cambridge University Press), 348--370.

Bolton, J. J., and Stegenga, H. (2002). Seaweed species diversity in South Africa. South African Journal of Marine Science 24, 9--18.

De Clerck, O., Bolton, J. J., Anderson, R. J., and Coppejans, E. (2005). Guide to the seaweeds of KwaZulu- Natal. Scripta Botanica Belgica 33, 294 pp.

Sauer, J. D. (1988). Plant migration: The dynamics of geographic patterning in seed plant species. University of California Press.

Smit, A. J., Bolton, J. J., and Anderson, R. J. (2017). Seaweeds in two oceans: beta-diversity. Frontiers in Marine Science, 4, 404.

Stegenga, H., Bolton, J. J., and Anderson, R. J. (1997). Seaweeds of the South African west coast. Contributions of the Bolus Herbarium 18, 3--637.
