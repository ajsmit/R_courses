---
date: "2021-01-01"
draft: false
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: Biodiversity Slides (2)
    url: /pdf/BCB743/BCB743_02_biodiversity_2.pdf
  - icon: file-pdf
    icon_pack: far
    name: Shade et al. (2018)
    url: /pdf/BCB743/Shade_et_al_2018.pdf
subtitle: ""
title: "2b. Quantifying Structure and Pattern"
weight: 4
---

In this Chapter we will explore how diversity is structured. Again refer to David Zelený's writing on his [Analysis of community data in R](https://www.davidzeleny.net/anadat-r/doku.php/en:diversity_analysis) website.

## Coenoclines, coenoplanes and coenospaces

A **coenocline** is a graphical display of *all species* response curves (see definition, below) *simultaneously* along one environmental gradient. It aids our understanding of the species response curve if we imagine the gradient operating in only one geographical direction. The **coenoplane** concept extends the coenocline to cover two gradients. Again, our visual representation can be facilitated if the two gradients are visualised orthogonal (in this case, at right angles) to each other (e.g. east--west and north--south) and they do not interact. A **coenospace** complicates the model substantially, as it can allow for an unspecified number of gradients to operate simultaneously on multiple species at once, and it will probably also capture interactions of environmental drivers on the species.

### Species response curves

Plotting the abundance of a species as a function of position along a gradient is called a **species response curve**. If a long enough gradient is sampled, a species typically has a *unimodal* response (one peak *resembling* a Gaussian distribution) to the gradient. Although the idealised Gaussian response is desired (for statistical purposes, largely), in nature the curve might deviate quite noticeably from what's considered ideal. It is probable that a perfect normal species distribution along a gradient can only be expected when the gradient is perfectly linear in magnitude (seldom true in nature), operates along only one geographical direction (unlikely), and that all other potentially additive environmental influences are constant across the ecological (coeno-) space (also not a realistic expectation).

### Unimodal species response

The **unimodal** model is an idealised species response curve (visualised as a coenocline) where a species has only one mode of abundance. The unimodal model offers a convenient heuristic tool for understanding how species can become structured along environmental gradients. In this type of species response curve the species has one optimal environmental condition where it is most abundant (fewest ecophysiological and ecological stressors). If any aspect of the environment is suboptimal (greater or lesser than the optimum), the species will perform more poorly and it will have a lower abundance.

The R package **coenocliner** implements the unimodal (and also a beta response model, not covered in the module). Please see the implementation of [**coenocliner** by Gavin Simpson](https://fromthebottomoftheheap.net/2014/07/31/simulating-species-abundance-data-with-the-coenocliner-package/), the author of the package. Download and install the package, and play around with its functionality in order to gain deeper insight into how gradients can structure communities (i.e., sort species).

## Macroecological patterns

We have seen the distribution of one or several species along gradients, but lets extend the view to ecological patterns and the ecological processes that structure the communities---sometimes we will see reference to 'community assembly processes' to describe how species are structured into communities. Let's develop views that are based on all the information contained in the species tables, i.e. abundance, the number of sites, and the diversity of the biota. This deeper view is not necessarily captured if we limit our toolkit to species response curves (but they are certainly also counted, below).

Some of you will be familiar with the paper by Shade et al. (2018). Several kinds of ecological patterns are mentioned in the paper, and they can be derived from a species table with abundance data (but *not* presence-absence data!) such as this mites dataset used extensively in the Numerical Ecology with R book:


```
##    Brachy PHTH HPAV RARD SSTR Protopl MEGR
## 1      17    5    5    3    2       1    4
## 2       2    7   16    0    6       0    4
## 3       4    3    1    1    2       0    3
## 4      23    7   10    2    2       0    4
## 5       5    8   13    9    0      13    0
## 6      19    7    5    9    3       2    3
## 7      17    3    8    2    3       0    3
## 64      3    0   16    0    0       0    0
## 65      4    0   10    0    0       0    0
## 66      8    0   18    0    0       0    0
## 67      4    0    3    0    0       0    0
## 68      6    0   22    0    0       0    0
## 69     20    2    4    0    0       0    0
## 70      5    0   11    0    0       0    0
```

Note that Figure 1 in Shade et al. (2018) starts with a species table where the species are arranged down the rows and the sites along the variables (columns). I, and also the **vegan** package, require that the **species are along the variables and the sites down the rows**. This is the convention that will be used throughout this module.

Univariate diversity measures such as Simpson and Shannon diversity can be prepared from species tables, but we can also use it to calculate measures of β-diversity that looks at pairwise comparisons (see below).

The patterns that can be derived from such a table include:

* species-abundance distribution;
* occupancy-abundance curves;
* species-area curves;
* distance-decay curves;
* rarefaction curves;
* elevation gradients.

We will calculate each for the Barro Colorado Island Tree Counts data that come with **vegan**.

### Species-abundance distribution

The species abundance distribution (SAD) is a fundamental pattern in ecology. Typical communities have a few species that are very abundant, whereas most of them are quite rare; indeed---this is perhaps a universal law in ecology. SAD represents this relationship graphically by plotting the abundance rank on the `\(x\)`-axis and the number of species (or some other taxonomic level) along `\(y\)`, as was first done by R.A. Fisher and colleagues (1943). He then fitted the data by log series that ideally capture situations where most of the species are quite rare with only a few very abundant ones---called **Fisher's log series distribution**---and is implemented in **vegan** by the `fisherfit()` function:


```r
library(vegan)

# ?BCI # see the help file for a description of the data

data(BCI)

# take one random sample of a row (site):
k <- sample(nrow(BCI), 1)
fish <- fisherfit(BCI[k,])
fish
```

```
## 
## Fisher log series model
## No. of species: 77 
## Fisher alpha:   27.62298
```

```r
plot(fish)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-2-1.png" width="480" />

F.W. Preston (1948) showed that when data from a thoroughly sampled population are transformed into octaves along the `\(x\)`-axis (number of species binned into inntervals of 1, 2, 4, 8, 16, 32 etc.), the SAD that results is approximated by a symmetric Gaussian distribution. This is because more thorough sampling makes species that occur with a high frequency more common and those that occur only once or are very rare become either less common will remain completely absent. This SAD is called **Preston's log-normal distribution**. In the **vegan** package there is an updated version of Preston's approach with a mathematical improvement to better handle ties. It is called `prestondistr()`:


```r
pres <- prestondistr(BCI[k,])
pres
```

```
## 
## Preston lognormal model
## Method: maximized likelihood to log2 abundances 
## No. of species: 77 
## 
##      mode     width        S0 
##  1.159698  1.812746 19.185790 
## 
## Frequencies by Octave
##                 0        1        2        3        4        5         6
## Observed 13.00000 19.50000 17.00000 13.50000 7.000000 6.000000 1.0000000
## Fitted   15.63531 19.11148 17.23134 11.45989 5.621847 2.034297 0.5429834
```

```r
plot(pres)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-3-1.png" width="480" />

R. H. Whittaker (1965) introduced **rank abundance distribution curves** (sometimes called a dominance-diversity curves or Whittaker plots). Here the `\(x\)`-axis has species ranked according to their relative abundance, with the most abundant species at the left and rarest at the right. The `\(y\)`-axis represents relative species abundances (sometimes log-transformed). The shape of the profile as---influenced by the steepness and the length of the tail---indicates the relative proportion of abundant and scarce species in the community. In **vegan** we can accomplish fitting this type of SAD with the `radfit()` function. The default plot is somewhat more complicated as it shows broken-stick, preemption, log-Normal, Zipf and Zipf-Mandelbrot models fitted to the ranked species abundance data:


```r
rad <- radfit(BCI[k,])
rad
```

```
## 
## RAD models, family poisson 
## No. of species 77, total abundance 421
## 
##            par1      par2     par3    Deviance AIC      BIC     
## Null                                   58.0173 289.3316 289.3316
## Preemption  0.057526                   36.3342 269.6484 271.9922
## Lognormal   1.0827    1.1321           27.2199 262.5342 267.2218
## Zipf        0.14503  -0.83716          54.0606 289.3748 294.0625
## Mandelbrot  13.63    -1.9881   11.711   5.7227 243.0369 250.0683
```

```r
plot(rad)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-4-1.png" width="480" />

We can also fit the rank abundance distribution curves to several sites at once (previously we have done so on only one site):


```r
m <- sample(nrow(BCI), 6)
rad2 <- radfit(BCI[m, ])
rad2
```

```
## 
## Deviance for RAD models:
## 
##                  30       12       45        2       47      14
## Null       109.9125  97.0832 114.1829  46.7795 105.2750 56.5086
## Preemption 108.6913  90.2032  82.1220  29.5066  81.6840 51.9274
## Lognormal   21.5828  27.1559  24.4013  18.8511  43.1745 20.5253
## Zipf        17.4005  17.1743  32.6148  48.4277  48.6464 35.4959
## Mandelbrot   7.7313   6.0875   7.7853   4.7586   9.4122  8.0679
```

```r
plot(rad2)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-5-1.png" width="480" />

Above, we see that the model selected for capturing the shape of the SAD is the Mandelbrot, and it is plotted individually for each of the randomly selected sites. Model selection works through Akaike’s or Schwartz’s Bayesian information criteria (AIC or BIC; AIC is the default---select the model with the lowest AIC).

[**BiodiversityR**](https://github.com/cran/BiodiversityR) (and [here](http://apps.worldagroforestry.org/downloads/Publications/PDFS/b13695.pdf) and [here](https://rpubs.com/Roeland-KINDT)) also offers options for rank abundance distribution curves; see `rankabundance()`:


```r
library(BiodiversityR)
rankabund <- rankabundance(BCI)
rankabunplot(rankabund, cex = 0.8, pch = 0.8, col = "salmon")
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-6-1.png" width="480" />

Refer to the help files for the respective functions to see their differences.

### Occupancy-abundance curves

Occupancy-abundance relationships are used to infer niche specialisation patterns in the sampling region. The hypothesis (almost a theory) is that species that tend to have high local abundance within one site also tend to occupy many sites.


```r
library(ggpubr)
BCI_OA <- data.frame(occ = colSums(BCI),
                     ab = apply(BCI, MARGIN = 2, mean))

plt1 <- ggplot(BCI_OA, aes(x = ab, y = occ)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  labs(title = "Barro Colorado Island Tree Counts",
     x = "Log (abundance)", y = "Log (occupancy)") +
  theme_linedraw()

plt2 <- ggplot(BCI_OA, aes(x = log(ab))) +
  geom_histogram(col = "black", fill = "turquoise", bins = 15) +
  labs(title = "Barro Colorado Island Tree Counts",
     x = "Log (abundance)") +
  theme_linedraw()

plt3 <- ggplot(BCI_OA, aes(x = log(occ))) +
  geom_histogram(col = "black", fill = "salmon", bins = 15) +
  labs(title = "Barro Colorado Island Tree Counts",
     x = "Log (occupancy)") +
  theme_linedraw()

ggarrange(plt1, plt2, plt3, nrow = 3)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-7-1.png" width="480" />

### Species-area (accumulation) and rarefaction curves

Species accumulation curves and rarefaction curves both serve the same purpose, that is, to try and estimate the number of unseen species. Within an ecosystem type, one would expect that more and more species would be added (accumulates) as the number of sampled sites increases. This continues to a point where no more new species are added as the number of sampled sites continues to increase (i.e. the curve plateaus). Species accumulation curves, as the name suggests, accomplishes this by adding (accumulation or collecting) more and more sites and counting the average number of species along `\(y\)` each time a new site is added. See Roeland Kindt's description of [how species accumulation curves work](http://apps.worldagroforestry.org/downloads/Publications/PDFS/b13695.pdf) (on p. 41). In the community matrix (the sites × species table), we can do this by successively adding more rows to the curve (seen along the `\(x\)`-axis). The `specaccum()` function has many different ways of adding the new sites to the curve, but the default 'exact' seems to be a sensible choice. **BiodiversityR** has the `accumresult()` function that does nearly the same. Let's demonstrate using **vegan**'s function:


```r
sp1 <- specaccum(BCI)
```

```
## Warning in cor(x > 0): the standard deviation is zero
```

```r
sp2 <- specaccum(BCI, "random")

# par(mfrow = c(2,2), mar = c(4,2,2,1))
# par(mfrow = c(1,2))
plot(sp1, ci.type = "polygon", col = "blue", lwd = 2, ci.lty = 0,
     ci.col = "lightblue", main = "Default: exact",
     ylab = "No. of species")
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-8-1.png" width="480" />

```r
## Fit Arrhenius models to all random accumulations
mods <- fitspecaccum(sp2, "arrh")
plot(mods, col = "hotpink", ylab = "No. of species")
boxplot(sp2, col = "yellow", border = "blue", lty = 1, cex = 0.3, add = TRUE)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-8-2.png" width="480" />

```r
sapply(mods$models, AIC)
```

```
##   [1] 322.7071 308.0307 326.1059 345.1316 311.2403 350.9010 331.8758 353.6134
##   [9] 343.6867 300.4062 277.3350 326.8261 353.7400 333.5661 345.1964 307.1611
##  [17] 337.7994 315.0815 344.3542 349.2597 337.0767 361.8861 350.9876 306.4465
##  [25] 344.7917 327.5933 330.8688 325.6508 348.5961 328.0685 341.8859 335.9847
##  [33] 354.8380 354.7685 322.7127 331.6956 331.3510 349.4619 345.1428 340.3122
##  [41] 294.7701 370.6056 305.5314 329.2304 340.6074 289.8180 328.7100 352.3945
##  [49] 319.1702 298.2687 335.1122 275.8272 314.9710 294.3424 343.0762 355.5532
##  [57] 324.5369 322.1104 357.0261 347.1883 305.5711 333.2753 321.5978 332.8631
##  [65] 324.7571 340.2275 343.5097 310.9758 357.0215 354.1713 363.2884 329.3238
##  [73] 326.9312 362.3362 318.6507 326.8958 288.0712 333.4761 306.6337 286.3334
##  [81] 344.6820 365.5858 316.8893 316.9515 349.4585 319.5920 343.3735 340.4702
##  [89] 349.6063 323.7812 325.5328 341.8555 329.5725 358.8580 335.0133 353.9419
##  [97] 327.1301 352.9177 344.8019 320.4868
```


```r
accum <- accumresult(BCI, method = "exact", permutations = 100)
accumplot(accum)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-9-1.png" width="480" />

Rarefaction is a statistical technique used by ecologists to assess species richness (represented as *S*, or diversity indices such as Shannon diversity, `\(H'\)`, or Simpson's diversity, `\(\lambda\)`) from data on species samples, such as that which we may find in site × species tables. Rarefaction can be used to determine whether a habitat, community, or ecosystem has been sufficiently sampled to fully capture the full complement of species present.

Rarefaction curves may seem similar to species accumulation curves, but there is a difference as I will note below. Species richness, *S*, accumulates with sample size *or* with the number of individuals sampled (across all species). The first way that rarefaction curves are presented is to show species richness as a function of number of individuals sampled. Here the principle demonstrated is that when only a few individuals are sampled, those individuals may belong to only a few species; however, when more individuals are present more species will be represented. The second approach to rarefaction is to plot the number of samples along `\(x\)` and the species richness along the `\(y\)`-axis (as in SADs too). So, rarefaction shows how richness accumulates with the number of individuals counted or with the number of samples taken. 

But what really distinguishes rarefaction curves from SADs is that rarefaction randomly re-samples the pool of `\(n\)` samples (that is equal or less than the total community size) a number of times and plots the average number of species found in each resample (1,2, ..., `\(n\)`) as a function of individuals or samples. The `rarecurve()` function draws a rarefaction curve for each row of the species data table. All these plots are made with base R graphics, but it will be a trivial exercise to reproduce them with **ggplot2**.

We can also use the [**iNEXT**](https://github.com/JohnsonHsieh/iNEXT) package for rarefaction curves. From the package's [Introduction Vignette](https://cran.r-project.org/web/packages/iNEXT/vignettes/Introduction.html):
 
> iNEXT focuses on three measures of Hill numbers of order q: species richness (q = 0), Shannon diversity (q = 1, the exponential of Shannon entropy) and Simpson diversity (q = 2, the inverse of Simpson concentration). For each diversity measure, iNEXT uses the observed sample of abundance or incidence data (called the “reference sample”) to compute diversity estimates and the associated 95% confidence intervals for the following two types of rarefaction and extrapolation (R/E):
> 
> 1. Sample‐size‐based R/E sampling curves: iNEXT computes diversity estimates for rarefied and extrapolated samples up to an appropriate size. This type of sampling curve plots the diversity estimates with respect to sample size.
> 2. Coverage‐based R/E sampling curves: iNEXT computes diversity estimates for rarefied and extrapolated samples with sample completeness (as measured by sample coverage) up to an appropriate coverage. This type of sampling curve plots the diversity estimates with respect to sample coverage.
>
>iNEXT also plots the above two types of sampling curves and a sample completeness curve. The sample completeness curve provides a bridge between these two types of curves.

For information about Hill numbers see David Zelený's [Analysis of community data in R](https://www.davidzeleny.net/anadat-r/doku.php/en:diversity_analysis) and Jari Oksanen's coverage of [diversity measures in **vegan**](https://cran.r-project.org/web/packages/vegan/vignettes/diversity-vegan.pdf).

There are four datasets distributed with iNEXT and numerous examples are provided in the [Introduction Vignette](https://cran.r-project.org/web/packages/iNEXT/vignettes/Introduction.html). iNEXT has an 'odd' data format that might seem foreign to **vegan** users. To use iNEXT with dataset suitable for analysis in vegan, we first need to convert BCI data to a species × site matrix:


```r
library(iNEXT)

# transpose the BCI data: 
BCI_t <- list(BCI = t(BCI))
str(BCI_t)
```

```
## List of 1
##  $ BCI: int [1:225, 1:50] 0 0 0 0 0 0 2 0 0 0 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:225] "Abarema.macradenia" "Vachellia.melanoceras" "Acalypha.diversifolia" "Acalypha.macrostachya" ...
##   .. ..$ : chr [1:50] "1" "2" "3" "4" ...
```

```r
BCI_out <- iNEXT(BCI_t, q = c(0, 1, 2), datatype = "incidence_raw")
```

```
## Warning in FUN(X[[i]], ...): Invalid data type, the element of species by sites
## presence-absence matrix should be 0 or 1. Set nonzero elements as 1.
```

```r
ggiNEXT(BCI_out, type = 1, color.var = "order")
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-10-1.png" width="480" />

The warning is produced because the function expects incidence data (presence-absence), but I'm feeding it abundance (count) data. Nothing serious, as the function converts the abundance data to incidences.

### Distance-decay curves

The principles of distance decay relationships are clearly captured in analyses of  [β-diversity](http://localhost:4321/quantecol/chapters/02a-biodiversity/#%ce%b2-diversity)---see specifically **turnover**, `\(\beta_\text{sim}\)`. Distance decay is the primary explanation for the spatial pattern of β-diversity along the South African coast in [Smit et al. (2017)](/pdf/BCB743/Smit_et_al_2017.pdf). We dive deeper into distance decay calculation in the next Chapter, [Deep Dive into Gradients](/quantecol/chapters/03-deep_dive/).

### Eelevation and other gradients

Elevation gradients and other gradients such as change in species composition with depth in the ocean are specific cases of distance decay and the same principles apply in these cases.
