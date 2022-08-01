---
date: "2021-01-01"
draft: false
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: non-Metric Multidimensional Scaling Slides
    url: /pdf/BCB743/BCB743_11_nMDS.pdf
  - icon: file-export
    icon_pack: fa
    name: Doubs.RData
    url: /BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData
subtitle: ""
title: "11a. non-Metric multidimensional scaling (nMDS)"
weight: 15
---

<!--- # Topic 11: non-Metric multidimensional scaling (nMDS) --->

nMDS is a rank-based *indirect gradient analysis* (i.e. not an eigen-analysis) that uses a distance or dissimilarity matrix as input. Whereas the ordination methods discussed thus far try to maximise the variance or correspondence between sites, nMDS strives to represent pairwise dissimilarities between sites in ordination space. It does not use the distances or dissimilarities directly (hence *indirect*), but these are substituted with their ranks (e.g. dissimilarities between pairs of sites are ordered by rank) (and hence *non-metric* in the name). This results in a loss of insight into the magnitude of difference between site pairs, but we benefit from the technique being more robust and less influenced by deviations from idealised data distributions.

nMDS is the non-metric equivalent to PCoA, the latter sometimes being called metric multi-dimensional scaling.

## Set-up the analysis environment


```r
library(tidyverse)
library(vegan)

# setting up a 'root' file path so I don't have to keep doing it later...
root <- "../../../static/BCB743/"
```

## The Doubs River data

We continue to use the species data:


```r
load(paste0(root, "NEwR-2ed_code_data/NEwR2-Data/Doubs.RData"))
spe <- dplyr::slice(spe, -8)
```

## Do the nMDS


```r
spe_nmds <- metaMDS(spe, distance = "bray")
```

```
## Run 0 stress 0.07477817 
## Run 1 stress 0.07477835 
## ... Procrustes: rmse 8.595306e-05  max resid 0.0004127545 
## ... Similar to previous best
## Run 2 stress 0.1119518 
## Run 3 stress 0.07376237 
## ... New best solution
## ... Procrustes: rmse 0.01938775  max resid 0.09466933 
## Run 4 stress 0.07506668 
## Run 5 stress 0.119678 
## Run 6 stress 0.1104318 
## Run 7 stress 0.1210356 
## Run 8 stress 0.0884457 
## Run 9 stress 0.08696387 
## Run 10 stress 0.11163 
## Run 11 stress 0.08696386 
## Run 12 stress 0.1104323 
## Run 13 stress 0.0923481 
## Run 14 stress 0.08845295 
## Run 15 stress 0.07429351 
## Run 16 stress 0.08797354 
## Run 17 stress 0.08845297 
## Run 18 stress 0.1111092 
## Run 19 stress 0.1234675 
## Run 20 stress 0.1196708 
## *** No convergence -- monoMDS stopping criteria:
##      1: no. of iterations >= maxit
##     19: stress ratio > sratmax
```

```r
spe_nmds
```

```
## 
## Call:
## metaMDS(comm = spe, distance = "bray") 
## 
## global Multidimensional Scaling using monoMDS
## 
## Data:     spe 
## Distance: bray 
## 
## Dimensions: 2 
## Stress:     0.07376237 
## Stress type 1, weak ties
## No convergent solutions - best solution after 20 tries
## Scaling: centring, PC rotation, halfchange scaling 
## Species: expanded scores based on 'spe'
```

As always, reading the help file for (accessible as `?metaMDS`) is invaluable (as are the help files for all other ordination techniques).

There's a summary method available, but it is not particularly useful and I don't display the output here:


```r
summary(spe_nmds)
```
Although `summary(spe_nmds)` does not return anything interesting, the species and site scores are nevertheless available directly through the `scores()` command, and they can be plotted as layer in **ggplot2** if need be:


```r
scores(spe_nmds)
```

```
## $sites
##          NMDS1       NMDS2
## 1  -1.79266820  0.81124566
## 2  -1.14371942 -0.15587635
## 3  -1.00364962 -0.07393066
## 4  -0.62128003 -0.07787740
## 5   0.07218048  0.45963091
## 6  -0.42770625 -0.15248613
## 7  -0.87073694 -0.22968589
## 8  -0.01450201 -0.86232553
## 9  -0.52657564 -0.40344729
## 10 -1.00870096 -0.37639511
## 11 -0.97242807 -0.16294582
## 12 -1.16251422  0.09842360
## 13 -0.80282788  0.12500326
## 14 -0.49302247  0.18043980
## 15 -0.18887827  0.27657182
## 16  0.08278495  0.12287472
## 17  0.29916615  0.11287643
## 18  0.44619325  0.14925193
## 19  0.76766601  0.28434885
## 20  0.86285337  0.37730324
## 21  0.95581595  0.44464819
## 22  0.75320844 -1.44503750
## 23  1.12997296 -0.63164681
## 24  0.85943730 -0.87250114
## 25  0.93379579  0.12311249
## 26  0.97571302  0.36313328
## 27  1.02418599  0.37348722
## 28  0.79653285  0.55866353
## 29  1.06970350  0.58314072
## 
## $species
##           NMDS1       NMDS2
## Cogo -0.9122291 -0.10320365
## Satr -1.1128179 -0.22533206
## Phph -0.7891079 -0.32042833
## Babl -0.5341270 -0.28923085
## Thth -0.9380555 -0.09578410
## Teso -0.5248310  0.16527348
## Chna  0.9020527  0.36590939
## Pato  0.5174858  0.38544353
## Lele  0.3304758  0.28594831
## Sqce  0.3587433 -0.15475223
## Baba  0.7041815  0.47504404
## Albi  0.7284778  0.47033293
## Gogo  0.6855755  0.30420466
## Eslu  0.6098495  0.42167281
## Pefl  0.6175285  0.50377265
## Rham  0.9671054  0.58268319
## Legi  0.9566092  0.50915041
## Scer  0.9663020  0.55180458
## Cyca  0.9590485  0.62823066
## Titi  0.7245438  0.41795035
## Abbr  1.0829671  0.67961330
## Icme  1.1286360  0.78230578
## Gyce  1.0747735  0.40703289
## Ruru  0.7596646  0.15124820
## Blbj  1.0955895  0.58021016
## Alal  0.9938579  0.02695003
## Anan  1.0095579  0.61212569
```

See *Numerical Ecology in R* (pp. 145 to 149) for information about the interpretation of a nMDSand the ordination diagrams shown below.

## Ordination diagrams

We create the ordination diagrammes as before, but new concepts introduced here are **stress**, **Shepard plots**, and **goodness of fit**. The stress indicates the scatter of observed dissimilarities against an expected monotone regression, while a Shepard diagram plots ordination distances against original dissimilarities, and adds a monotone or linear fit line to highlight this relationship. The `stressplot()` function also produces two fit statistics. The goodness-of-fit of the ordination is measured as the `\(R^{2}\)` of either a linear or a non-linear regression of the nMDS distances on the original ones.


```r
par(mfrow = c(2, 2))
stressplot(spe_nmds, main = "Shepard plot")
ordiplot(spe_nmds, type = "t", cex = 0.6,
         main = paste0("nMDS stress = ", round(spe_nmds$stress, 2)))
gof = goodness(spe_nmds)
plot(spe_nmds, type = "t", main = "Goodness of fit")
points(spe_nmds, display = "sites", cex = gof * 200)
# ...bigger bubbles indicate a worse fit
```

<img src="/quantecol/chapters/11-nMDS_files/figure-html/unnamed-chunk-6-1.png" width="672" />

We can also build ordination plots from scratch to suit specific needs:


```r
pl <- ordiplot(spe_nmds, type = "none", main = "nMDS fish abundances ")
points(pl, "sites", pch = 21, cex = 1.75, col = "grey80", bg = "grey80")
points(pl, "species", pch = 21, col = "turquoise", arrows = TRUE)
text(pl, "species", col = "blue4", cex = 0.9)
text(pl, "sites", col = "red4", cex = 0.9)
```

<img src="/quantecol/chapters/11-nMDS_files/figure-html/unnamed-chunk-7-1.png" width="672" />

Or we can fit response surfaces using `ordisurf()` and project environmental drivers:


```r
require('viridis')
```

```
## Loading required package: viridis
```

```
## Loading required package: viridisLite
```

```r
palette(viridis(8))
par(mar = c(4, 4, 0.9, 0.5) + .1, mfrow = c(2, 2))
with(spe, tmp <- ordisurf(spe_nmds ~ Satr, bubble = 3,
                          family = quasipoisson, knots = 2, col = 6,
                          display = "sites", main = "Satr"))
abline(h = 0, v = 0, lty = 3)
with(spe, tmp <- ordisurf(spe_nmds ~ Scer, bubble = 3,
                          family = quasipoisson, knots = 2, col = 6,
                          display = "sites", main = "Scer"))
abline(h = 0, v = 0, lty = 3)
with(spe, tmp <- ordisurf(spe_nmds ~ Teso, bubble = 3,
                          family = quasipoisson, knots = 2, col = 6,
                          display = "sites", main = "Teso"))
abline(h = 0, v = 0, lty = 3)
with(spe, tmp <- ordisurf(spe_nmds ~ Cogo, bubble = 3,
                          family = quasipoisson, knots = 2, col = 6,
                          display = "sites", main = "Cogo"))
abline(h = 0, v = 0, lty = 3)

env <- dplyr::slice(env, -8)

(spe_nmds_env <- envfit(spe_nmds, env)) 
```

```
## 
## ***VECTORS
## 
##        NMDS1    NMDS2     r2 Pr(>r)    
## dfs  0.97101  0.23904 0.7488  0.001 ***
## ele -0.98911 -0.14715 0.6115  0.001 ***
## slo -0.74921  0.66233 0.3267  0.022 *  
## dis  0.88576  0.46414 0.5684  0.001 ***
## pH  -0.26222  0.96501 0.0180  0.799    
## har  0.96353 -0.26761 0.3773  0.007 ** 
## pho  0.45925 -0.88831 0.5442  0.001 ***
## nit  0.87779 -0.47904 0.5819  0.001 ***
## amm  0.42925 -0.90319 0.5549  0.002 ** 
## oxy -0.74237  0.66999 0.7395  0.001 ***
## bod  0.44188 -0.89707 0.6576  0.001 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## Permutation: free
## Number of permutations: 999
```

```r
plot(spe_nmds_env, col = "grey40")
plot(spe_nmds_env, p.max = 0.05, col = "red")
```

<img src="/quantecol/chapters/11-nMDS_files/figure-html/unnamed-chunk-8-1.png" width="672" />

### Assignment 7 Questions

> 1.  Using two unconstrained ordination techniques of your choice, analyse the mite data in the **vegan** package. Provide a brief description and discussion of what you have found, and produce the R code.
>
> 2.  Using two unconstrained ordination techniques of your choice (not already used in 1, above) analyse the dune data in the **vegan** package. Provide a brief description and discussion of what you have found, and produce the R code.

Submit a R script wherein you provide answers to Questions 1--2 by no later than 8:00 tomorrow. Label the script as follows: **`BCB743_<Name>_<Surname>_Assignment_7.R`**, e.g. **`BCB743_AJ_Smit_Assignment_7.R`**.
