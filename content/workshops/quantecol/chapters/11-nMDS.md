---
date: "2021-01-01"
draft: false
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: non-Metric Multidimensional Scaling Slides
    url: /pdf/BCB743_11_nMDS.pdf
subtitle: ""
title: "11a. non-Metric multidimensional scaling (nMDS)"
weight: 14
---

<!--- # Topic 11: non-Metric multidimensional scaling (nMDS) --->

nMDS is a rank-based *indirect gradient analysis* (i.e. not an eigen-analysis) that uses a distance or dissimilarity matrix as input. Whereas the ordination methods discussed thus far try to maximise the variance or correspondence between sites, nMDS strives to represent pairwise dissimilarities between sites in ordination space. It does not use the distances or dissimilarities directly (hence *indirect*), but these are substituted with their ranks (e.g. dissimilarities between pairs of sites are ordered by rank) (and hence *non-metric* in the name). This results in a loss of insight into the magnitude of difference between site pairs, but we benefit from the technique being more robust and less influenced by deviations from idealised data distributions.

nMDS is the non-metric equivalent to PCoA, the latter sometimes being called metric multi-dimensional scaling.

## Set-up the analysis environment


```r
library(tidyverse)
library(vegan)
```

## The Doubs River data

We continue to use the species data:


```r
spe <- read.csv("/Users/ajsmit/Dropbox/R/workshops/Quantitative_Ecology/Num_Ecol_R_book_ed1/DoubsSpe.csv")
spe <- dplyr::select(spe, -1)
spe <- dplyr::slice(spe, -8)
```

## Do the nMDS


```r
spe_nmds <- metaMDS(spe, distance = "bray")
```

```
## Run 0 stress 0.07477805 
## Run 1 stress 0.1248897 
## Run 2 stress 0.1223247 
## Run 3 stress 0.08696384 
## Run 4 stress 0.07477818 
## ... Procrustes: rmse 9.898015e-05  max resid 0.0004732488 
## ... Similar to previous best
## Run 5 stress 0.1221737 
## Run 6 stress 0.08901468 
## Run 7 stress 0.0750668 
## ... Procrustes: rmse 0.01473175  max resid 0.06365692 
## Run 8 stress 0.08843915 
## Run 9 stress 0.1250564 
## Run 10 stress 0.07477812 
## ... Procrustes: rmse 6.12521e-05  max resid 0.0002936674 
## ... Similar to previous best
## Run 11 stress 0.07478423 
## ... Procrustes: rmse 0.003639739  max resid 0.01446982 
## Run 12 stress 0.1110569 
## Run 13 stress 0.1170163 
## Run 14 stress 0.07376217 
## ... New best solution
## ... Procrustes: rmse 0.0193905  max resid 0.09465655 
## Run 15 stress 0.1141838 
## Run 16 stress 0.1169775 
## Run 17 stress 0.0922274 
## Run 18 stress 0.1203424 
## Run 19 stress 0.1121122 
## Run 20 stress 0.07477817 
## *** No convergence -- monoMDS stopping criteria:
##     20: stress ratio > sratmax
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
## Stress:     0.07376217 
## Stress type 1, weak ties
## No convergent solutions - best solution after 20 tries
## Scaling: centring, PC rotation, halfchange scaling 
## Species: expanded scores based on 'spe'
```


```r
summary(spe_nmds) # not useful
```

See *Numerical Ecology in R* (pp. 145 to 149) for information about the interpretation of a nMDSand the ordination diagrams shown below.

## Ordination diagrams

We create the ordination diagrammes as before, but new concepts introduced here are **stress**, **Shepard plots**, and **goodness of fit**. The stress indicates the scatter of observed dissimilarities against an expected monotone regression, while a Shepard diagram plots ordination distances against original dissimilarities, and adds a monotone or linear fit line to highlight this relationship. The `stressplot()` function also produces two fit statistics. The goodness-of-fit of the ordination is measured as the `\(R^{2}\)` of either a linear or a non-linear regression of the nMDS distances on the original ones.


```r
par(mfrow = c(2, 2))
stressplot(spe_nmds, main = "Shepard plot")
ordiplot(spe_nmds, type = "t", cex = 1.5,
         main = paste0("nMDS stress = ", round(spe_nmds$stress, 2)))
gof = goodness(spe_nmds)
plot(spe_nmds, type = "t", main = "Goodness of fit")
points(spe_nmds, display = "sites", cex = gof * 200)
# ...bigger bubbles indicate a worse fit
```

<img src="/workshops/quantecol/chapters/11-nMDS_files/figure-html/unnamed-chunk-5-1.png" width="672" />

We can also build ordination plots from scratch to suit specific needs:


```r
pl <- ordiplot(spe_nmds, type = "none", main = "nMDS fish abundances ")
points(pl, "sites", pch = 21, cex = 1.75, col = "grey80", bg = "grey80")
points(pl, "species", pch = 21, col = "turquoise", arrows = TRUE)
text(pl, "species", col = "blue4", cex = 0.9)
text(pl, "sites", col = "red4", cex = 0.9)
```

<img src="/workshops/quantecol/chapters/11-nMDS_files/figure-html/unnamed-chunk-6-1.png" width="672" />

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

env <- read.csv("/Users/ajsmit/Dropbox/R/workshops/Quantitative_Ecology/Num_Ecol_R_book_ed1/DoubsEnv.csv")
env <- dplyr::select(env, -1)
env <- dplyr::slice(env, -8)

(spe_nmds_env <- envfit(spe_nmds, env)) 
```

```
## 
## ***VECTORS
## 
##        NMDS1    NMDS2     r2 Pr(>r)    
## dfs  0.97103  0.23898 0.7488  0.001 ***
## alt -0.98916 -0.14682 0.6114  0.001 ***
## slo -0.74780  0.66392 0.3268  0.018 *  
## flo  0.88591  0.46386 0.5684  0.001 ***
## pH  -0.26380  0.96458 0.0179  0.771    
## har  0.96329 -0.26847 0.3773  0.003 ** 
## pho  0.45983 -0.88801 0.5439  0.001 ***
## nit  0.87815 -0.47838 0.5819  0.001 ***
## amm  0.42983 -0.90291 0.5547  0.001 ***
## oxy -0.74290  0.66940 0.7395  0.001 ***
## bod  0.44248 -0.89678 0.6572  0.001 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## Permutation: free
## Number of permutations: 999
```

```r
plot(spe_nmds_env, col = "grey40")
plot(spe_nmds_env, p.max = 0.05, col = "red")
```

<img src="/workshops/quantecol/chapters/11-nMDS_files/figure-html/unnamed-chunk-7-1.png" width="672" />

### Questions

1.  Using two unconstrained ordination techniques of your choice, analyse the mite data in the **vegan** package. Provide a brief description and discussion of what you have found, and produce the R code.
2.  Using two unconstrained ordination techniques of your choice (not already used in 1, above) analyse the dune data in the **vegan** package. Provide a brief description and discussion of what you have found, and produce the R code.

Submit an R script wherein you provide answers to these questions by no later than 17:00 on Friday 23 July 2021.
