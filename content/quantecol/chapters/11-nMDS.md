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
## Run 1 stress 0.08843914 
## Run 2 stress 0.1203424 
## Run 3 stress 0.08841667 
## Run 4 stress 0.07478407 
## ... Procrustes: rmse 0.003627905  max resid 0.01438358 
## Run 5 stress 0.1119521 
## Run 6 stress 0.120581 
## Run 7 stress 0.1142563 
## Run 8 stress 0.111103 
## Run 9 stress 0.08801542 
## Run 10 stress 0.07477799 
## ... New best solution
## ... Procrustes: rmse 0.0002184056  max resid 0.00104899 
## ... Similar to previous best
## Run 11 stress 0.120581 
## Run 12 stress 0.07376242 
## ... New best solution
## ... Procrustes: rmse 0.01940485  max resid 0.09467385 
## Run 13 stress 0.07477814 
## Run 14 stress 0.07376256 
## ... Procrustes: rmse 5.385263e-05  max resid 0.0002484466 
## ... Similar to previous best
## Run 15 stress 0.07506691 
## Run 16 stress 0.1119533 
## Run 17 stress 0.1104327 
## Run 18 stress 0.08801543 
## Run 19 stress 0.09201579 
## Run 20 stress 0.07376234 
## ... New best solution
## ... Procrustes: rmse 0.0004348235  max resid 0.002091495 
## ... Similar to previous best
## *** Solution reached
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
## Stress:     0.07376234 
## Stress type 1, weak ties
## Two convergent solutions found after 20 tries
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
## 1  -1.79246047  0.81149407
## 2  -1.14370896 -0.15588826
## 3  -1.00363231 -0.07396450
## 4  -0.62131251 -0.07790777
## 5   0.07217565  0.45961149
## 6  -0.42770106 -0.15250035
## 7  -0.87073855 -0.22970805
## 8  -0.01448235 -0.86233475
## 9  -0.52657741 -0.40346366
## 10 -1.00866878 -0.37638900
## 11 -0.97241635 -0.16297855
## 12 -1.16251120  0.09836141
## 13 -0.80284025  0.12494494
## 14 -0.49306115  0.18038803
## 15 -0.18891017  0.27652718
## 16  0.08280953  0.12285935
## 17  0.29914446  0.11285760
## 18  0.44613250  0.14925079
## 19  0.76765317  0.28436049
## 20  0.86282462  0.37732054
## 21  0.95579174  0.44465868
## 22  0.75323824 -1.44500467
## 23  1.12997538 -0.63162900
## 24  0.85943720 -0.87248605
## 25  0.93378414  0.12312797
## 26  0.97568817  0.36315307
## 27  1.02417049  0.37350237
## 28  0.79651225  0.55866985
## 29  1.06968399  0.58316679
## 
## $species
##           NMDS1       NMDS2
## Cogo -0.9122375 -0.10328136
## Satr -1.1128018 -0.22534373
## Phph -0.7891099 -0.32045695
## Babl -0.5341352 -0.28925287
## Thth -0.9380576 -0.09585811
## Teso -0.5248536  0.16518527
## Chna  0.9020293  0.36592414
## Pato  0.5174638  0.38542615
## Lele  0.3304574  0.28592869
## Sqce  0.3587334 -0.15473649
## Baba  0.7041592  0.47503666
## Albi  0.7284605  0.47033142
## Gogo  0.6855524  0.30420961
## Eslu  0.6098313  0.42166925
## Pefl  0.6175098  0.50376293
## Rham  0.9670823  0.58269196
## Legi  0.9565884  0.50915982
## Scer  0.9662811  0.55181758
## Cyca  0.9590261  0.62823495
## Titi  0.7245237  0.41795486
## Abbr  1.0829425  0.67962562
## Icme  1.1286140  0.78231514
## Gyce  1.0747527  0.40705804
## Ruru  0.7596481  0.15126923
## Blbj  1.0955667  0.58022812
## Alal  0.9938419  0.02699254
## Anan  1.0095368  0.61213649
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
## dfs  0.97101  0.23903 0.7488  0.001 ***
## ele -0.98912 -0.14712 0.6115  0.001 ***
## slo -0.74910  0.66246 0.3267  0.014 *  
## dis  0.88577  0.46413 0.5684  0.001 ***
## pH  -0.26236  0.96497 0.0180  0.774    
## har  0.96351 -0.26768 0.3773  0.006 ** 
## pho  0.45929 -0.88829 0.5441  0.002 ** 
## nit  0.87782 -0.47899 0.5819  0.001 ***
## amm  0.42929 -0.90317 0.5549  0.001 ***
## oxy -0.74241  0.66995 0.7395  0.001 ***
## bod  0.44193 -0.89705 0.6575  0.001 ***
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
