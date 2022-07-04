---
date: "2021-01-01"
draft: false
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: Correlations Slides
    url: /pdf/BCB743/BCB743_06_correlations.pdf
  - icon: file-export
    icon_pack: fa
    name: Doubs.RData
    url: /BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData
subtitle: ""
title: "6. Correlations and Associations"
weight: 8
editor_options: 
  chunk_output_type: console
output: 
  html_document: 
    toc: yes
    fig_caption: yes
---

<!--- # Topic 6: Correlations and associations --->

## Set-up the analysis environment


```r
library(tidyverse)
library(vegan)
library(Hmisc) # for rcorr()

# setting up a 'root' file path so I don't have to keep doing it later...
root <- "../../../static/BCB743/"
```

## The Doubs River data

The background to the data is described by David Zelený on his excellent [website](https://www.davidzeleny.net/anadat-r/doku.php/en:data:doubs) and in the book **Numerical Ecology with R** by Borcard et al. (2011). These data are a beautiful example of how gradients structure biodiversity. It will be in your own interest to fully understand how the various environmental factors used as explanatory variables vary along a riverine gradient from the source to the terminus of the river.

### Correlations between environmental variables


```r
load(paste0(root, "NEwR-2ed_code_data/NEwR2-Data/Doubs.RData"))

head(env, 5)
```

```
##    dfs ele  slo  dis  pH har  pho  nit  amm  oxy bod
## 1  0.3 934 48.0 0.84 7.9  45 0.01 0.20 0.00 12.2 2.7
## 2  2.2 932  3.0 1.00 8.0  40 0.02 0.20 0.10 10.3 1.9
## 3 10.2 914  3.7 1.80 8.3  52 0.05 0.22 0.05 10.5 3.5
## 4 18.5 854  3.2 2.53 8.0  72 0.10 0.21 0.00 11.0 1.3
## 5 21.5 849  2.3 2.64 8.1  84 0.38 0.52 0.20  8.0 6.2
```

We use [correlations](https://ajsmit.netlify.app/workshops/quantecol/chapters/06-correlations/) to establish how the environmental variables relate to one another across the sample sites. We do not need to standardise as one would do for the calculation of Euclidian distances, but in some instances data transformations might be necessary:


```r
env_cor <- round(cor(env), 2)
env_cor
```

```
##       dfs   ele   slo   dis    pH   har   pho   nit   amm   oxy   bod
## dfs  1.00 -0.94 -0.38  0.95  0.01  0.70  0.48  0.75  0.41 -0.51  0.39
## ele -0.94  1.00  0.44 -0.87 -0.04 -0.74 -0.44 -0.76 -0.38  0.36 -0.34
## slo -0.38  0.44  1.00 -0.34 -0.22 -0.53 -0.19 -0.31 -0.17  0.31 -0.18
## dis  0.95 -0.87 -0.34  1.00  0.02  0.70  0.39  0.61  0.29 -0.36  0.25
## pH   0.01 -0.04 -0.22  0.02  1.00  0.09 -0.08 -0.05 -0.12  0.18 -0.15
## har  0.70 -0.74 -0.53  0.70  0.09  1.00  0.36  0.51  0.29 -0.38  0.34
## pho  0.48 -0.44 -0.19  0.39 -0.08  0.36  1.00  0.80  0.97 -0.72  0.89
## nit  0.75 -0.76 -0.31  0.61 -0.05  0.51  0.80  1.00  0.80 -0.63  0.64
## amm  0.41 -0.38 -0.17  0.29 -0.12  0.29  0.97  0.80  1.00 -0.72  0.89
## oxy -0.51  0.36  0.31 -0.36  0.18 -0.38 -0.72 -0.63 -0.72  1.00 -0.84
## bod  0.39 -0.34 -0.18  0.25 -0.15  0.34  0.89  0.64  0.89 -0.84  1.00
```

Or if we want to see the associated *p*-values to establish a statistical significance:


```r
rcorr(as.matrix(env))
```

```
##       dfs   ele   slo   dis    pH   har   pho   nit   amm   oxy   bod
## dfs  1.00 -0.94 -0.38  0.95  0.01  0.70  0.48  0.75  0.41 -0.51  0.39
## ele -0.94  1.00  0.44 -0.87 -0.04 -0.74 -0.44 -0.76 -0.38  0.36 -0.34
## slo -0.38  0.44  1.00 -0.34 -0.22 -0.53 -0.19 -0.31 -0.17  0.31 -0.18
## dis  0.95 -0.87 -0.34  1.00  0.02  0.70  0.39  0.61  0.29 -0.36  0.25
## pH   0.01 -0.04 -0.22  0.02  1.00  0.09 -0.08 -0.05 -0.12  0.18 -0.15
## har  0.70 -0.74 -0.53  0.70  0.09  1.00  0.36  0.51  0.29 -0.38  0.34
## pho  0.48 -0.44 -0.19  0.39 -0.08  0.36  1.00  0.80  0.97 -0.72  0.89
## nit  0.75 -0.76 -0.31  0.61 -0.05  0.51  0.80  1.00  0.80 -0.63  0.64
## amm  0.41 -0.38 -0.17  0.29 -0.12  0.29  0.97  0.80  1.00 -0.72  0.89
## oxy -0.51  0.36  0.31 -0.36  0.18 -0.38 -0.72 -0.63 -0.72  1.00 -0.84
## bod  0.39 -0.34 -0.18  0.25 -0.15  0.34  0.89  0.64  0.89 -0.84  1.00
## 
## n= 30 
## 
## 
## P
##     dfs    ele    slo    dis    pH     har    pho    nit    amm    oxy   
## dfs        0.0000 0.0365 0.0000 0.9771 0.0000 0.0076 0.0000 0.0251 0.0040
## ele 0.0000        0.0146 0.0000 0.8447 0.0000 0.0144 0.0000 0.0376 0.0493
## slo 0.0365 0.0146        0.0625 0.2362 0.0028 0.3067 0.0997 0.3593 0.1006
## dis 0.0000 0.0000 0.0625        0.9147 0.0000 0.0355 0.0004 0.1136 0.0522
## pH  0.9771 0.8447 0.2362 0.9147        0.6405 0.6619 0.7976 0.5134 0.3494
## har 0.0000 0.0000 0.0028 0.0000 0.6405        0.0481 0.0039 0.1191 0.0370
## pho 0.0076 0.0144 0.3067 0.0355 0.6619 0.0481        0.0000 0.0000 0.0000
## nit 0.0000 0.0000 0.0997 0.0004 0.7976 0.0039 0.0000        0.0000 0.0002
## amm 0.0251 0.0376 0.3593 0.1136 0.5134 0.1191 0.0000 0.0000        0.0000
## oxy 0.0040 0.0493 0.1006 0.0522 0.3494 0.0370 0.0000 0.0002 0.0000       
## bod 0.0309 0.0677 0.3546 0.1770 0.4232 0.0619 0.0000 0.0001 0.0000 0.0000
##     bod   
## dfs 0.0309
## ele 0.0677
## slo 0.3546
## dis 0.1770
## pH  0.4232
## har 0.0619
## pho 0.0000
## nit 0.0001
## amm 0.0000
## oxy 0.0000
## bod
```

We can also do a visual exploration (see Question 1, below).

<!-- ```{r} -->
<!-- library(ggcorrplot) -->
<!-- ggcorrplot(env_cor, type = 'upper', outline.col = "white", -->
<!--            colors = c("#00AFBB", "white", "#FC4E07"), -->
<!--            lab = TRUE) -->
<!-- ``` -->

### Assignment 3 Questions

> **Question 1:** Create a plot of pairwise correlations.
>
> **Question 2:** Name to two top positive and two top negative *statistically-significant* correlations.
>
> **Question 3:** For each, discuss the mechanism behind the relationships. Why do these relationships exist?

### Association between species

The Doubs River fish species dataset is an example of abundance data and it will serve well to examine the properties of an association matrix:


```r
head(spe)
```

```
##   Cogo Satr Phph Babl Thth Teso Chna Pato Lele Sqce Baba Albi Gogo Eslu Pefl
## 1    0    3    0    0    0    0    0    0    0    0    0    0    0    0    0
## 2    0    5    4    3    0    0    0    0    0    0    0    0    0    0    0
## 3    0    5    5    5    0    0    0    0    0    0    0    0    0    1    0
## 4    0    4    5    5    0    0    0    0    0    1    0    0    1    2    2
## 5    0    2    3    2    0    0    0    0    5    2    0    0    2    4    4
## 6    0    3    4    5    0    0    0    0    1    2    0    0    1    1    1
##   Rham Legi Scer Cyca Titi Abbr Icme Gyce Ruru Blbj Alal Anan
## 1    0    0    0    0    0    0    0    0    0    0    0    0
## 2    0    0    0    0    0    0    0    0    0    0    0    0
## 3    0    0    0    0    0    0    0    0    0    0    0    0
## 4    0    0    0    0    1    0    0    0    0    0    0    0
## 5    0    0    2    0    3    0    0    0    5    0    0    0
## 6    0    0    0    0    2    0    0    0    1    0    0    0
```

In order to calculate an association matrix for the fish species we first need to **transpose** the data:


```r
spe_t <- t(spe)
```

### Assignment 3 Questions

> **Question 4:** Why do we need to transpose the data?
>
> **Question 5:** What are the properties of a transposed species table?

Now we can calculate the association matrix:


```r
spe_assoc1 <- vegdist(spe_t, method = "jaccard")
 # display only a portion of the data...
as.matrix((spe_assoc1))[1:10, 1:10]
```

```
##           Cogo      Satr      Phph      Babl      Thth      Teso      Chna
## Cogo 0.0000000 0.7368421 0.7794118 0.7945205 0.3333333 0.4545455 0.9354839
## Satr 0.7368421 0.0000000 0.3108108 0.4705882 0.7368421 0.7333333 0.9583333
## Phph 0.7794118 0.3108108 0.0000000 0.2804878 0.7794118 0.7571429 0.9113924
## Babl 0.7945205 0.4705882 0.2804878 0.0000000 0.8108108 0.7397260 0.8481013
## Thth 0.3333333 0.7368421 0.7794118 0.8108108 0.0000000 0.5833333 0.9000000
## Teso 0.4545455 0.7333333 0.7571429 0.7397260 0.5833333 0.0000000 0.8787879
## Chna 0.9354839 0.9583333 0.9113924 0.8481013 0.9000000 0.8787879 0.0000000
## Pato 0.8918919 0.9078947 0.7948718 0.7307692 0.9210526 0.7500000 0.4827586
## Lele 0.8627451 0.8235294 0.7386364 0.6666667 0.9056604 0.7346939 0.6136364
## Sqce 0.8360656 0.7978723 0.7346939 0.6562500 0.8730159 0.8281250 0.7017544
##           Pato      Lele      Sqce
## Cogo 0.8918919 0.8627451 0.8360656
## Satr 0.9078947 0.8235294 0.7978723
## Phph 0.7948718 0.7386364 0.7346939
## Babl 0.7307692 0.6666667 0.6562500
## Thth 0.9210526 0.9056604 0.8730159
## Teso 0.7500000 0.7346939 0.8281250
## Chna 0.4827586 0.6136364 0.7017544
## Pato 0.0000000 0.5000000 0.6774194
## Lele 0.5000000 0.0000000 0.4531250
## Sqce 0.6774194 0.4531250 0.0000000
```


```r
spe_assoc2 <- vegdist(spe_t, method = "jaccard", binary = TRUE)
as.matrix((spe_assoc2))[1:10, 1:10]
```

```
##           Cogo      Satr      Phph      Babl      Thth      Teso      Chna
## Cogo 0.0000000 0.5294118 0.6000000 0.6666667 0.2222222 0.4000000 0.8888889
## Satr 0.5294118 0.0000000 0.2380952 0.3600000 0.5294118 0.6111111 0.8846154
## Phph 0.6000000 0.2380952 0.0000000 0.1666667 0.6000000 0.6000000 0.7692308
## Babl 0.6666667 0.3600000 0.1666667 0.0000000 0.6666667 0.6666667 0.6153846
## Thth 0.2222222 0.5294118 0.6000000 0.6666667 0.0000000 0.4000000 0.8235294
## Teso 0.4000000 0.6111111 0.6000000 0.6666667 0.4000000 0.0000000 0.7500000
## Chna 0.8888889 0.8846154 0.7692308 0.6153846 0.8235294 0.7500000 0.0000000
## Pato 0.8125000 0.8333333 0.7083333 0.6000000 0.8125000 0.6428571 0.2307692
## Lele 0.8181818 0.6538462 0.5384615 0.3846154 0.8181818 0.7000000 0.4210526
## Sqce 0.7307692 0.5517241 0.3928571 0.2500000 0.7307692 0.7307692 0.5200000
##           Pato      Lele      Sqce
## Cogo 0.8125000 0.8181818 0.7307692
## Satr 0.8333333 0.6538462 0.5517241
## Phph 0.7083333 0.5384615 0.3928571
## Babl 0.6000000 0.3846154 0.2500000
## Thth 0.8125000 0.8181818 0.7307692
## Teso 0.6428571 0.7000000 0.7307692
## Chna 0.2307692 0.4210526 0.5200000
## Pato 0.0000000 0.3888889 0.5600000
## Lele 0.3888889 0.0000000 0.2800000
## Sqce 0.5600000 0.2800000 0.0000000
```

### Assignment 3 Questions

> **Question 6:** What are the properties of an association matrix? How do these properties differ from that of a i) species dissmilarity matrix and from a ii) correlation matrix?
>
> **Question 7:** What is the difference between `spp_assoc1` and `spp_assoc2`? Is the information contained in each markedly different from the other?
>
> **Question 8:** Explain the kind of insight we are able to glean from a species association matrix.

Submit a R script wherein you provide answers to Questions 1--8 by no later than 8:00 tomorrow. Label the script as follows: **`BCB743_<Name>_<Surname>_Assignment_3.R`**, e.g. **`BCB743_AJ_Smit_Assignment_3.R`**.

## References

Borcard, D., Gillet, F. & Legendre, P. (2011) Numerical Ecology with R. Springer.
