---
date: "2021-01-01"
draft: false
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: Biodiversity Slides (1)
    url: /pdf/BCB743/BCB743_02_biodiversity_1.pdf
  - icon: file-pdf
    icon_pack: far
    name: Smit et al. (2017)
    url: /pdf/BCB743/Smit_et_al_2017.pdf
  - icon: file-pdf
    icon_pack: far
    name: Smit et al. (2013)
    url: /pdf/BCB743/Smit_et_al_2013.pdf
  - icon: file-pdf
    icon_pack: far
    name: The Seaweed Data
    url: /pdf/BCB743/Smit_the_seaweed_data.pdf
  - icon: file-csv
    icon_pack: fa
    name: SeaweedsSpp.csv
    url: /BCB743/seaweed/SeaweedsSpp.csv
  - icon: file-csv
    icon_pack: fa
    name: light_levels.csv
    url: /BCB743/seaweed/light_levels.csv
  - icon: images
    icon_pack: fas
    name: Biodiversity Exercises
    url: /slides/BCB743/02-biodiversity.html
subtitle: ""
title: "2a. Quantifying Diversity"
weight: 3
---

> ***Biodiversity** The variability among living organisms from all sources including, *inter alia*, terrestrial, marine and other aquatic ecosystems and the ecological complexes of which they are part; this includes diversity within species, between species and of ecosystems.*
>
> --- Convention on Biological Diversity

Species diversity is a measure of diversity in a specific habitat, ecological community, or ecosystem. It considers three important concepts about how species are distributed in space: **richness**, **abundance**, and **evenness**.

Note that when ecologists talk about 'biodiversity' they might not necessarily be interested in ALL the plants and animals and things that are neither plant nor animal that occur at a particular place. Some ecologists are interested in ants and moths. Others might find fishes more insightful. Some even like marine mammals! I prefer seaweeds for my own personal reasons. So, the analysis of biodiversity data might often be constrained to some higher-level taxon, such as all angiosperms in a landscape, or reptiles, etc. (but all species are sampled in the higher-level taxon). Some ecological questions benefit from comparisons of diversity assessments among selected taxa (avifauna vs. small mammals, for example), as this focus might address some particular ecological hypothesis---the bird vs. small mammal comparison might reveal something about how barriers such as streams and rivers structure biodiversity patterns. In our examples we will use such focused datasets. 

In this Chapter we start by looking at the various measures of biodiversity, viz. ??-, ??- and ??-diversity. Deeper analysis is and compulsory reading is provided by David Zelen?? on his [Analysis of community data in R](https://www.davidzeleny.net/anadat-r/doku.php/en:diversity_analysis) website.

<!--- # Topic 2: Measures of biodiversity --->

## Three measures of biodiversity

Three measures of biodiversity were coined by [Whittaker in 1972](/pdf/BCB743/Whittaker_1972.pdf), and the concepts were 'modernised' by [Jurasinski et al in 2009](/pdf/BCB743/Jurasinski_et_al_2009.pdf). They represent the measurement of biodiversity *across different spatial scales*. ??- and ??-diversity simply express the total number of species in an area. The first, ??-diversity, is a representation of the number of species at the small (local) scale, such as within a quadrat, transect, plot, or trawl. Multiples of these are nested within a larger region (or ecosystem etc.) and serve as replicates, and it is the complete number of species across all of these replicates that indicates the diversity at a larger scale---this is called ??-diversity. ??-diversity refers to the change in species composition among samples (sites).

We will start by using data on the seaweeds of South Africa to demonstrate some ideas around diversity measures. The **vegan** package offers [various functions](/pdf/BCB743/Oksanen_diversity-vegan.pdf) to calculate diversity indices, as demonstrated below.

## The South African seaweed data

For this example we will use the seaweed data of Smit et al. (2017); please make sure that you read it! An additional file describing the background to the data is available at the link above (see **The_seaweed_data.pdf**).

I use two data sets. The first, `\(Y\)` (in the file `SeaweedsSpp.csv`), comprises distribution records of 847 macroalgal species within each of 58 ?? 50 km-long sections of the South African coast (updated from Bolton and Stegenga 2002). This represents *ca*. 90% of the known seaweed flora of South Africa, but excludes some very small and/or very rare species for which data are insufficient. The data are from verifiable literature sources and John Bolton and Rob Anderson's own collections, assembled from information collected by teams of phycologists over three decades (Bolton 1986; Stegenga et al. 1997; Bolton and Stegenga 2002; De Clerck et al. 2005). The second, `\(E\)` (in `env.csv`), is a dataset of *in situ* coastal seawater temperatures (Smit et al. 2013) derived from daily measurements over up to 40 years.

### Setting up the analysis environment

This is **R**, so first I need to find, install and load various packages. Some of the packages will be available on CRAN and can be accessed and installed in the usual way, but others will have to be downloaded from [R Forge](https://r-forge.r-project.org/R/?group_id=195).


```r
library(tidyverse)
library(betapart)
library(vegan)
library(BiodiversityR)
library(gridExtra)
library(grid)
library(gridBase)
```

### A look at the data

Let's load the data and see how it is structured:


```r
spp <- read.csv('../../../static/BCB743/seaweed/SeaweedsSpp.csv')
spp <- dplyr::select(spp, -1)

# Lets look at the data:
dim(spp)
```

```
## [1]  58 847
```

We see that our dataset has 58 rows and 847 columns. What is in the columns and rows? Start with the first 5 rows and 5 columns:


```r
spp[1:5, 1:5]
```

```
##   ACECAL ACEMOE ACRVIR AROSP1 ANAWRI
## 1      0      0      0      0      0
## 2      0      0      0      0      0
## 3      0      0      0      0      0
## 4      0      0      0      0      0
## 5      0      0      0      0      0
```

Now the last 5 rows and 5 columns:


```r
spp[(nrow(spp) - 5):nrow(spp), (ncol(spp) - 5):ncol(spp)]
```

```
##    WOMKWA WOMPAC WRAARG WRAPUR WURMIN ZONSEM
## 53      0      0      1      0      0      0
## 54      0      0      1      0      0      0
## 55      0      0      1      0      0      0
## 56      0      1      1      0      1      0
## 57      1      0      1      0      1      0
## 58      0      0      1      0      1      0
```

So, each of the rows corresponds to a site (i.e. each of the coastal sections), and the columns each contain a species. The species are arranged alphabetically, and they are indicated by a six-letter code.

### Alpha diversity

We can represent ??-diversity in three ways:

1.  as species richness, `\(S\)`;

2.  as a univariate diversity index, such as the ?? parameter of [Fisher???s log-series](/quantecol/chapters/02b-biodiversity/#species-abundance-distribution), Shannon diversity, `\(H'\)`, or Simpson's diversity, `\(\lambda\)`; or

3.  as a dissimilarity index, e.g. Bray-Curtis, Jaccard, or S??rensen dissimilarities---see [Koleff (2003)](/pdf/BCB743/Koleff_et_al_2003.pdf) for many more; also see `?vegdist`

We will work through each in turn.

#### Species richness

First, species richness, `\(S\)`. In the seaweed biodiversity data---because we view each coastal section as the local scale (the smallest unit of sampling)---I simply count the number of species within each of the sections. 

If the **BiodiversityR** package does not work for you, there is also the `specnumber()` function in **vegan**:


```r
# Use 'MARGIN = 1' to calculate the number of species within each row (site)
spp_richness <- data.frame(richness = specnumber(spp, MARGIN = 1))
```

The `diversityresult()` function in the **BiodiversityR** package can do the same:


```r
spp_richness <- diversityresult(spp, index = 'richness', method = 'each site')
# spp_richness
```

Now we make a plot:


```r
ggplot(data = spp_richness, (aes(x = 1:58, y = richness))) +
  geom_line() + xlab("Coastal section, west to east") + ylab("Species richness") +
  theme_linedraw()
```

<div class="figure">
<img src="/quantecol/chapters/02a-biodiversity_files/figure-html/unnamed-chunk-7-1.png" alt="The species richness, S, of each of the coastal sections along the shore of South Africa." width="480" />
<p class="caption">Figure 1: The species richness, S, of each of the coastal sections along the shore of South Africa.</p>
</div>

In other instances, it makes more sense to calculate the mean species richness of all the sampling units (e.g. quadrats) taken inside the ecosystem of interest. You will have to decide based on your own data.

#### Univariate diversity indices

The second way in which we can express ??-diversity is to use one of the univariate diversity indices such as Fisher's `\(\alpha\)`, Shannon's `\(H'\)` or Simpson's `\(\lambda\)`.

The choice of which of the indices to use should be informed by the extent to which one wants to emphasise richness or evenness. Species richness, `\(S\)`, does not consider evenness at all as it is all about richness (obviously). Simpson's `\(\lambda\)` emphasises evenness a lot. Shannon's `\(H'\)` is somewhere in the middle.

**Shannon's `\(H'\)`** is sometimes called Shannon's diversity, the Shannon-Wiener index, the Shannon-Weaver index, or the Shannon entropy. It is calculated as:

`$$H' = -\sum_{i=1}^{S} p_{i} \ln p_{i}$$`
where `\(p_{i}\)` is the proportion of individuals belonging to the `\(i\)`th species, and `\(S\)` is the species richness.

**Simpson's `\(\lambda\)`**, or simply the Simpson index, is calculated as:

`$$\displaystyle \lambda = \sum_{i=1}^{S} p_{i}^{2}$$`
where `\(S\)` is the species richness and `\(p_{i}\)` is the relative abundance of the `\(i\)`th species.

**Fisher's `\(\alpha\)`** estimates the `\(\alpha\)` parameter of [Fisher's logarithmic series](/quantecol/chapters/02b-biodiversity/#species-abundance-distribution) (see `fisherfit()`). The estimation is possible only for actual counts (i.e. integers) of individuals, so it will not work for percent cover, biomass, and other meausres that can be expresses by real numbers.

We cannot calculate any of these for the seaweed data because in order to do so we require abundance data---the seaweed data are presence-absence only. Let's load a fictitious dataset of the diversity of three different communities of plants, with each community corresponding to a different light environment (dim, mid, and high light):


```r
light <- read.csv("../../../static/BCB743/seaweed/light_levels.csv")
light
```

```
##         Site    A    B    C    D    E    F
## 1  low_light 0.75 0.62 0.24 0.33 0.21 0.14
## 2  mid_light 0.38 0.15 0.52 0.57 0.28 0.29
## 3 high_light 0.08 0.15 0.18 0.52 0.54 0.56
```

We can see above that in stead of having data with 1s and 0s for presence-absence, here we have some values that indicate the relative amounts of each of the species in the three light environments. We calculate species richness (as before), and also the Shannon and Simpson indices using **vegan**'s `diversity()` function:


```r
light_div <- data.frame(
  site = c("low_light", "mid_light", "high_light"),
  richness = specnumber(light[, 2:7], MARGIN = 1),
  shannon = round(diversity(light[, 2:7], MARGIN = 1, index = "shannon"), 2),
  simpson = round(diversity(light[, 2:7], MARGIN = 1, index = "simpson"), 2)
)
light_div
```

```
##         site richness shannon simpson
## 1  low_light        6    1.62    0.78
## 2  mid_light        6    1.71    0.81
## 3 high_light        6    1.59    0.77
```

<!-- Hill numbers, `\(q\)`, (Hill, 1973) summarise `\(S\)`, Shannon's `\(H'\)` and Simpson's `\(\lambda\)`. Higher `\(q\)` puts less weight on rare species and weighs abundant ones more. Hill numbers can be used to draw diversity profiles, which allow for an elegant comparison of diversity among communities considering both richness and evenness. -->

<!-- ```{r fig.height=3, fig.width=5} -->
<!-- data(BCI) -->
<!-- i <- sample(nrow(BCI), 12) -->
<!-- mod <- renyi(BCI[i,]) -->
<!-- plot(mod) -->
<!-- mod <- renyiaccum(BCI[i,]) -->
<!-- plot(mod, as.table=TRUE, col = c(1, 2, 2)) -->
<!-- persp(mod) -->
<!-- ``` -->


#### Species evenness

Evenness refers to the shape of a [species abundance distribution](/quantecol/chapters/02b-biodiversity/#species-abundance-distribution).

One index for evenness is Pielou???s evenness, `\(J\)`: 

`$$J = \frac{H^{\prime}} {log(S)}$$`

where `\(H'\)` is Shannon's diversity index, and `\(S\)` the number of species (i.e. `\(S\)`).

To calculate Pielou's evenness index for the `light` data, we can do this:


```r
H <- diversity(light[, 2:7], MARGIN = 1, index = "shannon")

J <- H/log(specnumber(light[, 2:7]))
round(J, 2)
```

```
## [1] 0.91 0.95 0.89
```

#### Dissimilarity indices

In this section we will cover the dissimilarity indices, which are special cases of diversity indices that use pairwise comparisons between sampling units, habitats, or ecosystems. Both ??- and ??-diversity can be expressed as dissimilarity indices, but let deal with ??-diversity first.

These dissimilarity indices are multivariate and compare between sites, sections, plots, etc., and must therefore not be confused with the univariate diversity indices.

Recall from the lecture slides the Bray-Curtis and Jaccard dissimilarity indices for abundance data, and the S??rensen dissimilarity index for presence-absence data. The seaweed dataset is a presence-absence dataset, so we will use the S??rensen index. The interpretation of the resulting square (number of rows = number of columns) dissimilarity matrices is the same regardless of whether it is calculated for an abundance dataset or a presence-absence dataset. The values range from 0 to 1, with 0 meaning that the pair of sites being compared is identical (i.e. 0 dissimilarity) and 1 means the pair of sites is completely different (no species in common, hence 1 dissimilarity). In the square dissimilarity matrix the diagonal is 0, which essentially (and obviously) means that any site is identical to itself. Elsewhere the values will range from 0 to 1. Since this is a pairwise calculation (each site compared to every other site), our seaweed dataset will contain (58 ?? (58 - 1))/2 = 1653 values, each one ranging from 0 to 1.

The first step involves the species table, `\(Y\)`. First we compute the S??rensen dissimilarity index, `\(\beta_{\text{s??r}}\)`, to compare the dissimilarity of all pairs of coastal sections using on presence-absence data. The dissimilarity in species composition between two sections is calculated from three parameters, *viz*., *b* and *c*, which represent the number of species unique to each of two sites, and *a*, the number of species in common between them. It is given by:

`$$\beta_\text{s??r}=\frac{b+c}{2a+b+c}$$`

The **vegan** function `vegdist()` provides access to the dissimilarity indices. We calculate the S??rensen dissimilarity index:


```r
sor <- vegdist(spp, binary = TRUE) # binary = TRUE sets to presence/absence data
sor_df <- round(as.matrix(sor), 4)
dim(sor_df)
```

```
## [1] 58 58
```

```r
sor_df[1:10, 1:10] # the first 20 rows and columns
```

```
##         1      2      3      4      5      6      7      8      9     10
## 1  0.0000 0.0036 0.0036 0.0072 0.0249 0.0391 0.0391 0.0459 0.0592 0.0629
## 2  0.0036 0.0000 0.0000 0.0036 0.0213 0.0355 0.0355 0.0423 0.0556 0.0592
## 3  0.0036 0.0000 0.0000 0.0036 0.0213 0.0355 0.0355 0.0423 0.0556 0.0592
## 4  0.0072 0.0036 0.0036 0.0000 0.0177 0.0318 0.0318 0.0386 0.0519 0.0556
## 5  0.0249 0.0213 0.0213 0.0177 0.0000 0.0140 0.0140 0.0208 0.0342 0.0378
## 6  0.0391 0.0355 0.0355 0.0318 0.0140 0.0000 0.0000 0.0069 0.0205 0.0241
## 7  0.0391 0.0355 0.0355 0.0318 0.0140 0.0000 0.0000 0.0069 0.0205 0.0241
## 8  0.0459 0.0423 0.0423 0.0386 0.0208 0.0069 0.0069 0.0000 0.0136 0.0171
## 9  0.0592 0.0556 0.0556 0.0519 0.0342 0.0205 0.0205 0.0136 0.0000 0.0034
## 10 0.0629 0.0592 0.0592 0.0556 0.0378 0.0241 0.0241 0.0171 0.0034 0.0000
```

What we see above is a square dissimilarity matrix. The two most important characteristics of the matrix are:

i.  whereas the raw species data, `\(Y\)`, is rectangular (number rows ??? number columns), the dissimilarity matrix is square (number rows = number columns);

ii. the diagonal is filled with 0;

iii. the matrix is symmetrical---it is comprised of symetrical upper and lower triangles.

### Assignment 1 Questions

> **Question 1:** Why is the matrix square, and what determines the number of rows/columns?
>
> **Question 2:** What is the meaning of the diagonal?
>
> **Question 3:** What is the meaning of the non-diagonal elements?
>
> **Question 4:** Take the data in row 1 and create a line graph that shows these values as a function of section number.
>
> **Question 5:** Provide a mechanistic (ecological) explanation for why this figure takes the shape that it does.

### Gamma diversity

Staying with the seaweed data, `\(Y\)`, lets now look at `\(\lambda\)`-diversity---this would simply be the total number of species along the South African coastline in all 58 coastal sections. Since each column represents one species, and the dataset contains data collected at each of the 58 sites (the number of rows), we can simply do:


```r
# the number of columns gives the total number of species in this example:
ncol(spp)
```

```
## [1] 847
```

We can also use:


```r
diversityresult(spp, index = 'richness', method = 'pooled')
```

```
##        richness
## pooled      846
```

<!-- ```{r} -->
<!-- specpool() -->
<!-- ``` -->

### Assignment 1 Questions

> **Question 6:** Why is there a difference between the two?
>
> **Question 7:** Which is correct?

Think before you calculate ??-diversity for your own data as it might not be as simple as here!

### ??-diversity

#### Whittaker's concept of ??-diversity

The first measure of ??-diversity comes from [Whittaker (1960)](/pdf/BCB743/Whittaker_1960.pdf) and is called *true ??-diversity*. This is simply dividing the ??-diversity for the region by the ??-diversity for a specific coastal section. We can calculate it all at once for the whole dataset and make a graph:


```r
true_beta <- data.frame(
  beta = specnumber(spp, MARGIN = 1) / ncol(spp),
  section_no = c(1:58)
)
# true_beta
ggplot(data = true_beta, (aes(x = section_no, y = beta))) +
  geom_line() + xlab("Coastal section, west to east") +
  ylab("True beta-diversity") +
  theme_linedraw()
```

<img src="/quantecol/chapters/02a-biodiversity_files/figure-html/unnamed-chunk-14-1.png" width="480" />

The second measure of ??-diversity is *absolute species turnover*, and to calculate this we simply substract ??-diversity for each section from the region's ??-diversity:


```r
abs_beta <- data.frame(
  beta = ncol(spp) - specnumber(spp, MARGIN = 1),
  section_no = c(1:58)
)
# abs_beta
ggplot(data = abs_beta, (aes(x = section_no, y = beta))) +
  geom_line() + xlab("Coastal section, west to east") +
  ylab("Absolute beta-diversity") +
  theme_linedraw()
```

<img src="/quantecol/chapters/02a-biodiversity_files/figure-html/unnamed-chunk-15-1.png" width="480" />

#### Contemporary definitions ??-diversity

Contemporary views of ??-diversity are available by [Baselga et al. (2010)](/pdf/BCB743/Baselga_2010.pdf) and [Anderson et al. (2011)](/pdf/BCB743/Anderson_et_al_2011.pdf). Nowadays we see ??-diversity is a concept that describes how species assemblages (communities) measured within the ecosystem of interest vary from place to place, e.g. between the various transects or quadrats used to sample the ecosystem. ??-diversity results from habitat heterogeneity (along gradients, or randomly). We have already seen two concepts of ??-diversity, viz. true ??-diversity and absolute species turnover---both of these rely on knowledge of species richness at local (a measure of ??-diversity) and regional (??-diversity) scales. Much more insight into *species assembly processes* can be extracted, however, when we view ??-diversity as a dissimilarity index. In this view, we will see that there are two processes by which ??-diversity might be affected (i.e. in which the patterning of communities over landscapes might arise). These offer glimpses into mechanistic influences about how ecosystems are structured.

**Process 1:** If a region is comprised of the species A, B, C, ..., M (i.e. ??-diversity is 13), a subset of the regional flora as captured by one quadrat might be species **A**, **D**, E, whereas in another quadrat it might be species **A**, **D**, F. In this instance, the ??-diversity is 3 in both instances, and heterogeneity (and hence ??-diversity) results from the fact that the first quadrat has species E but the other has species F. In other words, here we have the same number of species in both quadrats, but only two of the species are the same. The process responsible for this form of ??-diversity is species **turnover**, `\(\beta_\text{sim}\)`. Turnover refers to processes that cause communities to differ due to species being lost and/or gained from section to section, i.e. the species composition changes between sections without corresponding changes in ??-diversity.

**Process 2:** Consider again species A, B, C, ..., M. Now we have the first quadrat with species **A**, **B**, C, D, **G**, H (??-diversity is 6) and the second quadrat has a subset of this, e.g. only species **A**, **B**, **G** (??-diversity 3). Here, ??-diversity comes from the fact that even if the two places share the same species, the number of species can still differ among the quadrats (i.e. from place to place) due to one quadrat capturing only a subset of species present in the other. This form of ??-diversity is called **nestedness-resultant** ??-diversity, `\(\beta_\text{sne}\)`, and it refers to processes that cause species to be gained or lost, and the community with the lowest ??-diversity is a subset of the richer community.

The above two examples show that ??-diversity is coupled not only with the identity of the species in the quadrats, but also ??-diversity---with species richness in particular.

We express ??-diversity as nestedness-resultant, `\(\beta_\text{sne}\)`, and turnover, `\(\beta_\text{sim}\)`, components so as to be able to distinguish between these two processes. It allows us to make inferences about the two possible drivers of ??-diversity. Turnover refers to processes that cause communities to differ due to species being lost and/or gained from section to section, i.e. the species composition changes between sections without corresponding changes in ??-diversity. The nestedness-resultant component implies processes that cause species to be gained or lost without replacement, and the community with the lowest ??-diversity is a subset of the richer community.

How do we calculate the turnover and nestedness-resultant components of ??-diversity? The **betapart** package (Baselga et al. 2017) comes to the rescue. We decompose the dissimilarity into the `\(\beta_\text{sim}\)` and `\(\beta_\text{sne}\)` components (Baselga 2010) using the `betapart.core()` and `betapart.pair()` functions. The outcomes of this partitioning calculation are placed into the matrices `\(Y1\)` and `\(Y2\)`. These data can then be analysed further---e.g. we can apply a principal components analysis (PCA) or another multivariate analysis on `\(Y\)` to find the major patterns in the community data---we will do this in a later section.


```r
# Decompose total S??rensen dissimilarity into turnover and nestedness-resultant
# components:
Y.core <- betapart.core(spp)
Y.pair <- beta.pair(Y.core, index.family = "sor")

# Let Y1 be the turnover component (beta-sim):
Y1 <- as.matrix(Y.pair$beta.sim)

# Let Y2 be the nestedness-resultant component (beta-sne):
Y2 <- as.matrix(Y.pair$beta.sne)
```


```r
round(Y1[1:10, 1:10], 4)
```

```
##         1      2      3      4      5      6      7      8      9     10
## 1  0.0000 0.0000 0.0000 0.0000 0.0072 0.0217 0.0217 0.0217 0.0217 0.0290
## 2  0.0000 0.0000 0.0000 0.0000 0.0072 0.0216 0.0216 0.0216 0.0216 0.0288
## 3  0.0000 0.0000 0.0000 0.0000 0.0072 0.0216 0.0216 0.0216 0.0216 0.0288
## 4  0.0000 0.0000 0.0000 0.0000 0.0071 0.0214 0.0214 0.0214 0.0214 0.0286
## 5  0.0072 0.0072 0.0072 0.0071 0.0000 0.0140 0.0140 0.0140 0.0140 0.0210
## 6  0.0217 0.0216 0.0216 0.0214 0.0140 0.0000 0.0000 0.0000 0.0000 0.0070
## 7  0.0217 0.0216 0.0216 0.0214 0.0140 0.0000 0.0000 0.0000 0.0000 0.0070
## 8  0.0217 0.0216 0.0216 0.0214 0.0140 0.0000 0.0000 0.0000 0.0000 0.0069
## 9  0.0217 0.0216 0.0216 0.0214 0.0140 0.0000 0.0000 0.0000 0.0000 0.0000
## 10 0.0290 0.0288 0.0288 0.0286 0.0210 0.0070 0.0070 0.0069 0.0000 0.0000
```


```r
round(Y2[1:10, 1:10], 4)
```

```
##         1      2      3      4      5      6      7      8      9     10
## 1  0.0000 0.0036 0.0036 0.0072 0.0177 0.0174 0.0174 0.0242 0.0375 0.0340
## 2  0.0036 0.0000 0.0000 0.0036 0.0141 0.0139 0.0139 0.0207 0.0340 0.0305
## 3  0.0036 0.0000 0.0000 0.0036 0.0141 0.0139 0.0139 0.0207 0.0340 0.0305
## 4  0.0072 0.0036 0.0036 0.0000 0.0105 0.0104 0.0104 0.0172 0.0305 0.0270
## 5  0.0177 0.0141 0.0141 0.0105 0.0000 0.0000 0.0000 0.0068 0.0203 0.0168
## 6  0.0174 0.0139 0.0139 0.0104 0.0000 0.0000 0.0000 0.0069 0.0205 0.0171
## 7  0.0174 0.0139 0.0139 0.0104 0.0000 0.0000 0.0000 0.0069 0.0205 0.0171
## 8  0.0242 0.0207 0.0207 0.0172 0.0068 0.0069 0.0069 0.0000 0.0136 0.0102
## 9  0.0375 0.0340 0.0340 0.0305 0.0203 0.0205 0.0205 0.0136 0.0000 0.0034
## 10 0.0340 0.0305 0.0305 0.0270 0.0168 0.0171 0.0171 0.0102 0.0034 0.0000
```

### Assignment 1 Questions

> **Question 8:** Plot species turnover as a function of Section number, and provide a mechanistic explanation for the pattern observed.
>
> **Question 9:** Based on an assessment of literature on the topic, provide a discussion of nestedness-resultant ??-diversity. Use either a marine or terrestrial example to explain this mode of structuring biodiversity.

Submit a R script wherein you provide answers to Questions 1--9 by no later than 8:00 tomorrow. Label the script as follows: **`BCB743_<Name>_<Surname>_Assignment_1.R`**, e.g. **`BCB743_AJ_Smit_Assignment_1.R`**.

## References

Baselga, A. (2010). Partitioning the turnover and nestedness components of beta diversity. Global Ecology and Biogeography 19, 134--143.

Baselga, A., Orme, D., Villeger, S., De Bortoli, J., and Leprieur, F. (2017). betapart: Partitioning Beta Diversity into Turnover and Nestedness Components. R package version 1.4-1.

Bolton, J. J. (1986). Marine phytogeography of the Benguela upwelling region on the west coast of southern Africa: A temperature dependent approach. Botanica Marina 29, 251--256.

Bolton, J. J., and Stegenga, H. (2002). Seaweed species diversity in South Africa. South African Journal of Marine Science 24, 9--18.

De Clerck, O., Bolton, J. J., Anderson, R. J., and Coppejans, E. (2005). Guide to the seaweeds of KwaZulu- Natal. Scripta Botanica Belgica 33, 294 pp.

Koleff, P., Gaston, K. J., & Lennon, J. J. (2003). Measuring beta diversity for presence--absence data. Journal of Animal Ecology, 72(3), 367-382.

Smit, A. J., Bolton, J. J., & Anderson, R. J. (2017). Seaweeds in two oceans: beta-diversity. Frontiers in Marine Science, 4, 404.

Smit, A. J., Roberts, M., Anderson, R. J., Dufois, F., Dudley, S. F. J., Bornman, T. G., et al. (2013). A coastal seawater temperature dataset for biogeographical studies: large biases between in situ and remotely-sensed data sets around the coast of South Africa. PLOS ONE 8, e81944.

Stegenga, H., Bolton, J. J., and Anderson, R. J. (1997). Seaweeds of the South African west coast. Contribu- tions of the Bolus Herbarium 18, 3--637.

Whittaker, R. H. (1960). Vegetation of the Siskiyou Mountains, Oregon and California. Ecological Monographs. 30 (3): 279--338.
