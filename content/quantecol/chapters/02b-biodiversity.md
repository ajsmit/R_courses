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
title: "2b. Diversity Structure and Patterns"
weight: 4
---

In this Chapter we will explore how diversity is structured. Again refer to David Zelený's writing on his [Analysis of community data in R](https://www.davidzeleny.net/anadat-r/doku.php/en:diversity_analysis) website.

## Coenoclines, coenoplanes and coenospaces

A **coenocline** is a graphical display of *all species* response curves (see definition, below) *simultaneously* along one environmental gradient. It aids our understanding of the species response curve if we imgine the gradient operating in only one geographical direction. The **coenoplane** concept extends the coenocline to cover two gradients. Again, our visual respresentation can be facilitated if the two gradients are visualised orthogonal (in this case, at right angles) to each other (e.g. east--west and north--south) and they do not interact. A **coenospace** complicates the model substantially, as it can allow for an unspecified number of gradients to operate simulataneously on multiple species at once, and it will probably also capture interactions of environmental drivers on the species.

### Species response curves

Plotting the abundance of a species as a function of position along a gradient is called a **species response curve**. If a long enough gradient is sampled, a species typically has a *unimodal* response (one peak *resembling* a Gaussian distribution) to the gradient. Although the idealised Gaussian response is desired (for statistical purposes, largely), in nature the curve might deviate quite noticeably from what's considered ideal. It is probable that a perfect normal species distribution along a gradient can only be expected when the gradient is perfectly linear in magnitude (seldom true in nature), operates along only one geographical direction (unlikely), and that all other potentially additive environmental influences are constant across the ecological (coeno-) space (also not a realistic expectation).

### Unimodal species response

The **unimodal** model is an idealised species reponse curve (visualised as a coenocline) where a species has only one mode of abundance. The unimodel model offers a convenient heuristic tool for understanding how species can become structured along environmental gradients. In this type of species response curve the species has one optimal environmental condition where it is most abundant (fewest ecophysiological and ecological stressors). If any aspect of the environment is suboptimal (greater or lesser than the optimum), the species will perform more poorly and it will have a lower abundance.

The R package **coenocliner** implements the unimodal (and also a beta response model, not covered in the module). Please see the implementation of [**coenocliner** by Gavin Simpson](https://fromthebottomoftheheap.net/2014/07/31/simulating-species-abundance-data-with-the-coenocliner-package/), the author of the package. Download and install the package, and play around with its functionality in order to gain deeper insight into how gradients can structure communities (i.e., sort species).

## Macroecological patterns

We have seen the distribution of one or several species along gradients, but lets extend the view to ecological patterns and the ecological processes that structure the communities -- sometimes we will see reference to 'community assembly processes' to desribe how species are structured into communities. Let's develop views that are based on all the information contained in the species tables, i.e. abundance, the number of sites, and the diversity of the biota. This deeper view is not necessarily captured if we limit our toolkit to species response curves (but they are certainly also counted, below).

Some of you will be familiar with the paper by Shade et al. (2018). Several kinds of ecological patterns are mentioned in the paper, and they can be derived from a species table with abundance data (but *not* presence-absence data!) such as this mites dataset used extensively in the Numerical Ecology with R book:


```
##    Brachysp Phthirsp Hoplcfpa Rhysardu Atrostri Protopsp Malacfeg
## 1        17        5        5        3        2        1        4
## 2         2        7       16        0        6        0        4
## 3         4        3        1        1        2        0        3
## 4        23        7       10        2        2        0        4
## 5         5        8       13        9        0       13        0
## 6        19        7        5        9        3        2        3
## 7        17        3        8        2        3        0        3
## 64        3        0       16        0        0        0        0
## 65        4        0       10        0        0        0        0
## 66        8        0       18        0        0        0        0
## 67        4        0        3        0        0        0        0
## 68        6        0       22        0        0        0        0
## 69       20        2        4        0        0        0        0
## 70        5        0       11        0        0        0        0
```

Note that Figure 1 in Shade et al. (2018) starts with a species table where the species are arranged down the rows and the sites along the variables (columns). I, and also the **vegan** package, require that the **species are along the variables and the sites down the rows**. This is the convention that will be used throughout this module.

Univariate diversity measures such as Simpson and Shannon diversity can be prepared from species tables, but we can also use it to calculate measures of beta-diversity that looks at pairwise comparisons (see below).

The patterns that can be derived from such a table include:

* species-abundance distribution;
* occupancy-abundance curves;
* species-area curves;
* distance-decay curves;
* rarefaction curves;
* elevation gradients.

We will calculate each for the mites data.

### Species-abundance distribution

The species abundance distribution (SAD) is a fundamental pattern in ecology. Typical communities have a few species that are very abundant, whereas most of them are quite rare; indeed -- this is perhaps a universal law in ecology. SAD represents this relationship graphically by plotting the abundance rank on the `\(x\)`-axis and the number of species (or some other taxonomic level) along `\(y\)`, as was first done by R.A. Fisher and colleagues (1943). He then fitted the data by log series that ideally capture situations where most of the species are quite rare with only a few very abundant ones -- called **Fisher's log series distribution** -- and is implemented in **vegan** by the `fisherfit()` function:


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
## No. of species: 91 
## Fisher alpha:   36.40222
```

```r
plot(fish)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-2-1.png" width="480" />

F.W. Preston (1948) showed that when data from a thoroughly sampled population are transformed into octaves along the `\(x\)`-axis (number of species binned into inntervals of 1, 2, 4, 8, 16, 32 etc.), the SAD that results is approximated by a symmetric Gaussian distribution. This is because more thorough sampling makes species that occur with a high frequency more common and those that occur only once or are very rare become either less common will remain completely absent. This SAD is called **Preston's log-normal distribution**. In the **Vegan** package there is an updated version of Preston's approach with a mathematical improvement to better handle ties. It is called `prestondistr()`:


```r
pres <- prestondistr(BCI[k,])
pres
```

```
## 
## Preston lognormal model
## Method: maximized likelihood to log2 abundances 
## No. of species: 91 
## 
##       mode      width         S0 
##  0.9473289  1.7296234 24.1288066 
## 
## Frequencies by Octave
##                 0        1        2        3        4        5
## Observed 18.00000 25.50000 18.50000 16.50000 7.500000 5.000000
## Fitted   20.76802 24.11762 20.04945 11.93161 5.083045 1.550164
```

```r
plot(pres)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-3-1.png" width="480" />

R. H. Whittaker (1965) introduced **rank abundance distribution curves** (sometimes called a dominance-diversity curves or Whittaker plots). Here the `\(x\)`-axis has species ranked according to their relative abundance, with the most abundant species at the left and rarest at the right. The `\(y\)`-axis represents relative species abundances (often log-transformed). The shape (the steepness and the length of the tail) indicates the relative proportion of dominant and rare species in a community. In vegan we can accomplish fitting this type of SAD with the `radfit()` function. The default plot is somewhat more complicated as it shows brokenstick, preemption, log-Normal, Zipf and Zipf-Mandelbrot models fitted to the ranked species abundance data:


```r
rad <- radfit(BCI[k,])
rad
```

```
## 
## RAD models, family poisson 
## No. of species 91, total abundance 407
## 
##            par1      par2     par3    Deviance AIC      BIC     
## Null                                   48.4601 310.2954 310.2954
## Preemption  0.045481                   35.7131 299.5483 302.0592
## Lognormal   0.93734   1.0762           20.0017 285.8370 290.8588
## Zipf        0.12454  -0.79329          40.3051 306.1404 311.1621
## Mandelbrot  5.2811   -1.7171   11.146   4.7226 272.5579 280.0905
```

```r
plot(rad)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-4-1.png" width="672" />

We can also fit the rank abundance distribution curves to several sites at once (previsouly we have done so on only one site):


```r
m <- sample(nrow(BCI), 6)
rad2 <- radfit(BCI[m, ])
rad2
```

```
## 
## Deviance for RAD models:
## 
##                  15       34       16        6       47     20
## Null        54.6908  96.9569  71.4490  72.1627 105.2750 45.067
## Preemption  42.9077  94.6008  57.1444  54.7709  81.6840 33.728
## Lognormal   21.9427  23.2471  31.8308  19.5788  43.1745 19.018
## Zipf        46.3612  20.7959  48.8686  32.4630  48.6464 42.503
## Mandelbrot   4.9979   6.2270   8.7297   5.5973   9.4122  7.286
```

```r
plot(rad2)
```

<img src="/quantecol/chapters/02b-biodiversity_files/figure-html/unnamed-chunk-5-1.png" width="672" />

Above, we see that the model selected for capturing the shape of the SAD is Mandelbrot, and it is plotted individually for each of the randomly selected sites. Model selection works through Akaike’s or Schwartz’s Bayesian information criteria (AIC or BIC; AIC is the default -- select the model with the lowest AIC).
