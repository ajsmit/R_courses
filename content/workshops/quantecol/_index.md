---
author: AJ Smit
date: "2021-01-25"
description: |
  BCB's Quantitative Ecology pages
excerpt: null
layout: single-series
publishDate: "2021-01-22"
show_author_byline: false
show_post_date: true
show_post_thumbnail: true
subtitle: Quantitative Ecology
title: BCB743
weight: 3
---

<!--- # Introduction --->

> *"We have become, by the power of a glorious evolutionary accident called intelligence, the stewards of life's continuity on earth. We did not ask for this role, but we cannot abjure it. We may not be suited to it, but here we are."*
>
> --- Stephen J. Gould

# Modern ecological problems

**This is a course about community ecology and not so much about population ecology.** Community ecology underpins the vast fields of biodiversity and biogeography, and concerns spatial scales from squares of meters to all of Earth. We can look at historical, contemporary, and future processes that have been implicated in shaping the distribution of life on our planet.

Community ecologists tend to analyse how multiple environmental factors act as drivers that influence the distribution of tens or hundreds of species. These data tend to often be messy (not in the sense of untidy data as per the 'tidyverse' definition of tidy data, but it can be that too!) and statistical considerations need to be understood within the context of the data available to us. This translates to errors of measurement and errors due to extreme values, the presence of a few very rare or very abundant species, autocorrelated residuals (due to repeated sampling, for example), colinearity, etc. These challenges make to application of 'basic' statistical approaches problematic, and a new branch of inferential and exploratory statistical needs to be followed. These approaches involve techniques that allow us to work with all the data at once, and because it can simultaneously analyse all the variables (multiple environmental drivers acting on multiple species at multiple places and across multiple times), this group of statistics is called 'multivariate statistics.' There are two main groups of multivariate statistics: 'classifications' and 'ordinations.' Classification generally concerns placing samples (species or environments) into groups or hierarchies of groups, while ordination is best suited for analyses that involve arranging samples along gradients. Often they complement each other, but we shall see later that each approach has its own strengths. Irrespective of the analysis, the data share a few characteristics.

These multivariate datasets have far more information in them than can de detected by the human eye and univariate statistics.

![More than meets the eye](../Resources/more_than_meets_the_eye.jpeg)

# Function content

You will encounter the following functions for the first time in this module:

-   `adonis2()` -- Permutational Multivariate Analysis of Variance Using Distance Matrices
-   `anova.betadisper()` -- PERMDIST 2 for Multivariate homogeneity of groups dispersions (variances)
-   `anova.cca()` -- Permutation Test for Constrained Correspondence Analysis, Redundancy Analysis and Constrained Analysis of Principal Coordinates
-   `anova.manyglm()` -- Analysis of Deviance for Multivariate Generalized Linear Model Fits for Abundance Data
-   `beta.pair()` -- Incidence-based pair-wise dissimilarities
-   `betadisper()` -- Multivariate homogeneity of groups dispersions (variances)
-   `betapart.core()` -- Core calculations of betapart
-   `biplot()` -- Biplot of Multivariate Data
-   `capscale()` -- [Partial] Distance-based Redundancy Analysis
-   `cca()` -- [Partial] [Constrained] Correspondence Analysis and Redundancy Analysis
-   `cleanplot.pca()` -- Numerical Ecology in R's PCA plot
-   `daisy()` -- Dissimilarity Matrix Calculation
-   `decostand()` -- Standardization Methods for Community Ecology
-   `diag()` - Matrix Diagonals
-   `diversity()` -- Ecological Diversity Indices
-   `diversityresult()` -- Alternative Diversity Results
-   `fviz_cluster()` -- Visualize Clustering Results
-   `fviz_nbclust()` -- Dertermining and Visualizing the Optimal Number of Clusters
-   `fviz_silhouette()` -- Visualize Silhouette Information from Clustering
-   `geodist()` -- Convert lon-lat coordinates into vector or matrix of geodesic distances in metres
-   `ggcorrplot()` -- Visualization of a correlation matrix using ggplot2
-   `goodness()` -- Diagnostic Tools for [Constrained] Ordination (CCA, RDA, DCA, CA, PCA)
-   `imputePCA()` -- Impute dataset with PCA
-   `lowerTriangle()` -- Extract or replace the upper/lower triangular portion of a matrix
-   `manyglm()` -- Fitting Generalized Linear Models for Multivariate Abundance Data
-   `meanvar.plot()` -- Construct Mean-Variance plots for Multivariate Abundance Data
-   `metaMDS()` -- Nonmetric Multidimensional Scaling with Stable Solution from Random Starts, Axis Scaling and Species Scores
-   `mvabund()` -- Multivariate Abundance Data Objects
-   `ordiellipse()` -- Display Groups or Factor Levels in Ordination Diagrams
-   `ordiplot()` -- Alternative plot and identify Functions for Ordination
-   `ordispider()` -- Display Groups or Factor Levels in Ordination Diagrams
-   `ordisurf()` -- Fit and Plot Smooth Surfaces of Variables on Ordination
-   `pam()` -- Partitioning Around Medoids
-   `permutest()` -- Permutation Test for Constrained Correspondence Analysis, Redundancy Analysis and Constrained Analysis of Principal Coordinates
-   `rda()` -- [Partial] [Constrained] Correspondence Analysis and Redundancy Analysis
-   `RsquareAdj()` -- Adjusted R-square
-   `scores()` -- Get Species or Site Scores from an Ordination
-   `specnumber()` -- Ecological Diversity Indices
-   `stressplot()` -- Goodness of Fit and Shepard Plot for Nonmetric Multidimensional Scaling
-   `t()` -- Matrix Transpose
-   `vegdist()` -- Dissimilarity Indices for Community Ecologists
-   `vif.cca()` -- Diagnostic Tools for [Constrained] Ordination (CCA, RDA, DCA, CA, PCA)

These links point to online resources such as datasets and R scripts in support of the video and PDF lecture material. It is essential that you work through these examples and workflows.

## Week 1

### Introduction

These materials are incomplete...

-   **[Lecture 1]** Introduction

    -   Ecological data
    -   Data properties
    -   What do we do with the data?
    -   Exploring the data

### Biodiversity

-   **[Lecture 2]** Biodiversity
-   **[Lecture 3]** Biodiversity (continue)

## Week 2

-   **[Lecture 4]** Biodiversity (continue)
-   **[Self study]** Gradients: What structures biodiversity?
-   **[Self study]** Historical, neutral, and niche theories

### Matrices

-   **[Lecture 5]** Environmental distance
-   **[Lecture 6]** Species dissimilarity
-   **[Self study]** Gradients revisited: Deep dive into gradients

## Week 3

-   **[Self study]** Correlations and associations
-   **[Lecture 7]** Introduction to ordination (theory only; refer to PDF slides and lecture video)

### Ordinations

-   **[Lecture 8]** Principal component analysis (PCA)

## Week 4

-   **[Self study]** PCA (continue)
-   **[Self study]** PCA of World Health Organization data on progress towards attaining SDGs
-   **[Lecture 9]** Correspondence analysis (CA)
-   **[Lecture 10]** Principal coordinate analysis (PCoA)

## Week 5

-   **[Lecture 11]** non-Metric multi-dimensional scaling (nMDS)
-   **[Self study]** nMDS + PERMANOVA analysis of Mayombo's diatom data
-   **[Lecture 12]** Constrained ordination
-   **[Lecture 13]** Cluster analysis

## Week 6

-   **[Lecture 14]** All topics: Review and assignments
