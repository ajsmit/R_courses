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
## No. of species: 95 
## Fisher alpha:   39.87658
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
## No. of species: 95 
## 
##       mode      width         S0 
##  0.9234918  1.6267630 26.4300640 
## 
## Frequencies by Octave
##                 0        1        2        3        4        5         6
## Observed 19.00000 27.00000 21.50000 17.00000 7.000000 2.500000 1.0000000
## Fitted   22.49669 26.40085 21.23279 11.70269 4.420327 1.144228 0.2029835
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
## No. of species 95, total abundance 392
## 
##            par1      par2     par3    Deviance AIC      BIC     
## Null                                   56.3132 324.6477 324.6477
## Preemption  0.042685                   55.8621 326.1966 328.7504
## Lognormal   0.84069   1.0912           16.1740 288.5085 293.6162
## Zipf        0.12791  -0.80986          21.0817 293.4161 298.5239
## Mandelbrot  0.66461  -1.2374   4.1886   6.6132 280.9476 288.6093
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
##                   4        1        7       19       35      48
## Null        49.8111  39.5261  44.1321 107.2256 885.2242 59.1791
## Preemption  39.7817  21.8939  35.5813 116.0772 706.2663 55.8066
## Lognormal   16.6588  25.1528  15.0446  33.4229 159.4459 16.2187
## Zipf        47.9108  61.0465  37.1297  17.5444  36.4052 25.3544
## Mandelbrot   5.5665   4.2271   6.8295  10.4748  36.4052  5.0745
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
rankabunplot(rankabund, cex = 0.8, pch = 0.8, col = "red")
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-6-1.png" width="480" />

Refer to the help files for the respective functions to see their differences.

### Occupancy-abundance curves

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

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-7-1.png" width="480" />

```r
## Fit Arrhenius models to all random accumulations
mods <- fitspecaccum(sp2, "arrh")
plot(mods, col = "hotpink", ylab = "No. of species")
boxplot(sp2, col = "yellow", border = "blue", lty = 1, cex = 0.3, add = TRUE)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-7-2.png" width="480" />

```r
sapply(mods$models, AIC)
```

```
##   [1] 341.2981 335.2787 320.4301 308.5353 291.1365 340.1930 357.9873 332.1840
##   [9] 318.5659 366.6193 351.3844 335.7607 348.3426 302.3093 288.1323 308.8948
##  [17] 352.8090 317.8931 336.3964 373.8125 329.3544 334.0731 344.2925 375.7244
##  [25] 348.7604 345.0628 338.4549 268.5416 303.7123 325.3938 331.1292 293.7738
##  [33] 327.5455 355.0379 349.7843 339.5713 326.3298 351.1487 300.3795 345.1110
##  [41] 330.8714 358.3487 319.0466 340.2197 344.3764 346.4743 320.1542 302.3948
##  [49] 309.7505 336.4755 363.6841 306.9264 336.0695 345.3502 329.3734 319.2883
##  [57] 337.5438 331.3938 326.2044 331.5958 368.0740 313.5700 255.2104 334.2672
##  [65] 314.4999 324.6643 335.8524 348.6149 346.5143 320.1167 336.9254 293.2337
##  [73] 336.4260 334.1159 333.8296 341.4761 336.1687 339.0917 371.6713 327.4544
##  [81] 353.6557 305.7991 330.0735 365.7789 344.3809 343.0189 326.2084 336.1685
##  [89] 343.7478 308.8636 321.0863 337.2869 337.2085 347.5741 351.1661 335.0564
##  [97] 346.2892 340.6306 358.8237 357.3155
```


```r
accum <- accumresult(BCI, method = "exact", permutations = 100)
accumplot(accum)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-8-1.png" width="480" />

Rarefaction is a statistical technique used by ecologists to assess species richness (represented as *S*, or diversity indices such as Shannon diversity, `\(H'\)`, or Simpson's diversity, `\(\lambda\)`) from data on species samples, such as that which we may find in site × species tables. Rarefaction can be used to determine whether a habitat, community, or ecosystem has been sufficiently sampled to fully capture the full complement of species present.

Rarefaction curves may seem similar to species accumulation curves, but there is a difference as I will note below. Species richness, *S*, accumulates with sample size *or* with the number of individuals sampled (across all species). The first way that rarefaction curves are presented is to show species richness as a function of number of individuals sampled. Here the principle demonstrated is that when only a few individuals are sampled, those individuals may belong to only a few species; however, when more individuals are present more species will be represented. The second approach to rarefaction is to plot the number of samples along `\(x\)` and the species richness along the `\(y\)`-axis (as in SADs too). So, rarefaction shows how richness accumulates with the number of individuals counted or with the number of samples taken. 

But what really distinguishes rarefaction curves from SADs is that rarefaction randomly re-samples the pool of `\(N\)` samples (that is equal or less than the total community size) a number of times and plots the average number of species found in each resample (1,2, ... `\(N\)`) as a function of individuals or samples. The `rarecurve()` function draws a rarefaction curve for each row of the species data table. All these plots are made with base R graphics, but it will be a trivial exercise to reproduce them with **ggplot2**.

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

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-9-1.png" width="672" />

The warning is produced because the function expects incidence data (presence-absence), but I'm feeding it abundance (count) data. Nothing serious, as the function converts the abundance data to incidences.

### Distance-decay curves

### Eelevation and other gradients
