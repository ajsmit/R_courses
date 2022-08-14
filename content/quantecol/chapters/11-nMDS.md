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
## Run 0 stress 0.07477805 
## Run 1 stress 0.07477805 
## ... New best solution
## ... Procrustes: rmse 5.440483e-06  max resid 1.258377e-05 
## ... Similar to previous best
## Run 2 stress 0.08841669 
## Run 3 stress 0.07376221 
## ... New best solution
## ... Procrustes: rmse 0.01939928  max resid 0.094646 
## Run 4 stress 0.1124304 
## Run 5 stress 0.1225935 
## Run 6 stress 0.08696391 
## Run 7 stress 0.07506667 
## Run 8 stress 0.1203424 
## Run 9 stress 0.07429326 
## Run 10 stress 0.09288416 
## Run 11 stress 0.1208167 
## Run 12 stress 0.0880154 
## Run 13 stress 0.124453 
## Run 14 stress 0.07429329 
## Run 15 stress 0.1124306 
## Run 16 stress 0.07506662 
## Run 17 stress 0.07376223 
## ... Procrustes: rmse 0.0002298588  max resid 0.001105342 
## ... Similar to previous best
## Run 18 stress 0.07429336 
## Run 19 stress 0.1104418 
## Run 20 stress 0.11235 
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
## Stress:     0.07376221 
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
## 1  -1.78747787  0.81744198
## 2  -1.14366752 -0.15623814
## 3  -1.00358248 -0.07477767
## 4  -0.62137169 -0.07857421
## 5   0.07185438  0.45924440
## 6  -0.42772132 -0.15281702
## 7  -0.87060450 -0.23019818
## 8  -0.01413709 -0.86260691
## 9  -0.52651480 -0.40390849
## 10 -1.00851947 -0.37662677
## 11 -0.97239639 -0.16375632
## 12 -1.16272545  0.09690650
## 13 -0.80295598  0.12358231
## 14 -0.49318935  0.17929875
## 15 -0.18905072  0.27563935
## 16  0.08270543  0.12241133
## 17  0.29909822  0.11255770
## 18  0.44583712  0.14953608
## 19  0.76715490  0.28460686
## 20  0.86210237  0.37774423
## 21  0.95503516  0.44491136
## 22  0.75402336 -1.44440172
## 23  1.13004570 -0.63118021
## 24  0.85949687 -0.87220241
## 25  0.93320409  0.12360354
## 26  0.97500022  0.36365973
## 27  1.02352527  0.37384574
## 28  0.79606360  0.55879873
## 29  1.06876793  0.58349946
## 
## $species
##           NMDS1       NMDS2
## Cogo -0.9122189 -0.10506419
## Satr -1.1123735 -0.22563318
## Phph -0.7890642 -0.32113996
## Babl -0.5341378 -0.28971117
## Thth -0.9380705 -0.09762312
## Teso -0.5249259  0.16330129
## Chna  0.9014747  0.36633824
## Pato  0.5170739  0.38511485
## Lele  0.3301055  0.28554002
## Sqce  0.3584916 -0.15439080
## Baba  0.7036256  0.47490993
## Albi  0.7279499  0.47025890
## Gogo  0.6850506  0.30436776
## Eslu  0.6093163  0.42159214
## Pefl  0.6169930  0.50353256
## Rham  0.9664221  0.58288053
## Legi  0.9559722  0.50938051
## Scer  0.9655865  0.55203286
## Cyca  0.9583346  0.62827749
## Titi  0.7239568  0.41807757
## Abbr  1.0821660  0.67985739
## Icme  1.1278097  0.78238855
## Gyce  1.0740950  0.40762385
## Ruru  0.7591997  0.15178913
## Blbj  1.0948304  0.58060084
## Alal  0.9933648  0.02796921
## Anan  1.0088396  0.61233116
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

A good rule of thumb: stress <0.05 provides an excellent representation in reduced dimensions, <0.1 is great, <0.2 is so-so, and stress <0.3 provides a poor representation.

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
## dfs  0.97105  0.23886 0.7489  0.001 ***
## ele -0.98922 -0.14646 0.6114  0.001 ***
## slo -0.74646  0.66543 0.3269  0.023 *  
## dis  0.88608  0.46354 0.5683  0.002 ** 
## pH  -0.26530  0.96417 0.0178  0.804    
## har  0.96305 -0.26932 0.3772  0.002 ** 
## pho  0.46037 -0.88773 0.5437  0.001 ***
## nit  0.87847 -0.47780 0.5820  0.001 ***
## amm  0.43038 -0.90265 0.5544  0.001 ***
## oxy -0.74339  0.66886 0.7394  0.001 ***
## bod  0.44304 -0.89650 0.6569  0.001 ***
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
