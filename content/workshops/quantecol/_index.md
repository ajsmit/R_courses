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

## Course structure

These links point to online resources such as datasets and R scripts in support of the video and PDF lecture material. It is essential that you work through these examples and workflows.

{{< rawhtml >}}
<table>
    <thead>
    <tr>
    <th style="text-align:left">Wk</th>
    <th style="text-align:left">Lect</th>
    <th style="text-align:left">Topic</th>
    <th style="text-align:center">Class</th>
    <th style="text-align:left">Slides</th>
    <th style="text-align:center">Reading</th>
    <th style="text-align:center">Data</th>
    <th style="text-align:center">Ex</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td style="text-align:left">Wk 1</td>
    <td style="text-align:left">Lect 1</td>
    <td style="text-align:left">Introduction</td>
    <td style="text-align:center"><a href="/workshops/quantecol/chapters/01-introduction/" title="Lecture 1"><i class="fas fa-graduation-cap"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_01_intro.pdf"><i class="fas fa-file-pdf" title="Lecture 1 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left"></td>
    <td style="text-align:left"><strong>BIODIVERSITY</strong></td>
    <td style="text-align:center"></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 2</td>
    <td style="text-align:left">Biodiversity (1)</td>
    <td style="text-align:center"><a href="/workshops/quantecol/02-biodiversity/"><i class="fas fa-graduation-cap" title="Lecture 2"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_02_biodiversity_1.pdf"><i class="fas fa-file-pdf" title="Lecture 2 slides (1)"></i></a> <a href="/pdf/BCB743/BCB743_02_biodiversity_2.pdf"><i class="fas fa-file-pdf" title="Lecture 2 slides (2)"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/Smit_et_al_2013.pdf"><i class="fas fa-file-pdf" title="Smit et al (2013)"></i></a> <a href="/pdf/BCB743/Smit_et_al_2017.pdf"><i class="fas fa-file-pdf" title="Smit et al (2017)"></i></a> <a href="/pdf/BCB743/The_seaweed_data.pdf"><i class="fas fa-file-pdf" title="About the seaweed data"></i></a></td>
    <td style="text-align:center"><a href="/BCB743/seaweed/SeaweedsSpp.csv"><i class="fas fa-file-csv" title="SeaweedsSpp.csv"></i></a> <a href="/BCB743/seaweed/light_levels.csv"><i class="fas fa-file-csv" title="light_levels.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 3</td>
    <td style="text-align:left">Biodiversity (2)</td>
    <td style="text-align:center"></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left">Wk 2</td>
    <td style="text-align:left">Self study</td>
    <td style="text-align:left">Ecological theories</td>
    <td style="text-align:center"></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left"></td>
    <td style="text-align:left"><strong>MATRICES</strong></td>
    <td style="text-align:center"></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 4</td>
    <td style="text-align:left">Environmental distance</td>
    <td style="text-align:center"><a href="/workshops/quantecol/04-env_dist/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_04_environmental_distance.pdf"><i class="fas fa-file-pdf" title="Lecture 4 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/seaweed/Euclidian_distance_demo_data_xyz.csv"><i class="fas fa-file-csv" title="Euclidian_distance_demo_data_xyz.csv"></i></a> <a href="/BCB743/seaweed/Euclidian_distance_demo_data_env.csv"><i class="fas fa-file-csv" title="Euclidian_distance_demo_data_env.csv"></i></a> <a href="/BCB743/seaweed/sites.csv"><i class="fas fa-file-csv" title="sites.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 5</td>
    <td style="text-align:left">Species dissimilarity</td>
    <td style="text-align:center"><a href="/workshops/quantecol/05-spp_dissimilarity/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_05_dissimilarity.pdf"><i class="fas fa-file-pdf" title="Lecture 5 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/Num_Ecol_R_book_ed1/DoubsEnv.csv"><i class="fas fa-file-csv" title="DoubsEnv.csv"></i></a> <a href="/BCB743/Num_Ecol_R_book_ed1/DoubsSpe.csv"><i class="fas fa-file-csv" title="DoubsSpe.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left">Wk 3</td>
    <td style="text-align:left">Self study</td>
    <td style="text-align:left">Deeper into gradients</td>
    <td style="text-align:center"><a href="/workshops/quantecol/03-deep_dive/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/seaweed/SeaweedEnv.RData"><i class="fas fa-file-export" title="SeaweedEnv.RData"></i></a> <a href="/BCB743/seaweed/dists_mat.RData"><i class="fas fa-file-export" title="dists_mat.RData"></i></a> <a href="/BCB743/seaweed/bioregions.csv"><i class="fas fa-file-csv" title="bioregions.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 6</td>
    <td style="text-align:left">Correlations et al.</td>
    <td style="text-align:center"><a href="/workshops/quantecol/06-correlations/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_06_correlations.pdf"><i class="fas fa-file-pdf" title="Lecture 6 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/Num_Ecol_R_book_ed1/DoubsEnv.csv"><i class="fas fa-file-csv" title="DoubsEnv.csv"></i></a> <a href="/BCB743/Num_Ecol_R_book_ed1/DoubsSpe.csv"><i class="fas fa-file-csv" title="DoubsSpe.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left"></td>
    <td style="text-align:left"><strong>ORDINATION</strong></td>
    <td style="text-align:center"></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 7</td>
    <td style="text-align:left">Ordinations</td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_07_ordination.pdf"><i class="fas fa-file-pdf" title="Lecture 7 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 8</td>
    <td style="text-align:left">PCA (1)</td>
    <td style="text-align:center"><a href="/workshops/quantecol/08-pca/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_08_PCA.pdf"><i class="fas fa-file-pdf" title="Lecture 8 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/Num_Ecol_R_book_ed1/DoubsEnv.csv"><i class="fas fa-file-csv" title="DoubsEnv.csv"></i></a> <a href="/BCB743/Num_Ecol_R_book_ed1/DoubsSpe.csv"><i class="fas fa-file-csv" title="DoubsSpe.csv"></i></a> <a href="/BCB743/Num_Ecol_R_book_ed1/cleanplot.pca.R/"><i class="fas fa-file-code" title="cleanplot.pca.R"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left">Wk 4</td>
    <td style="text-align:left">Self study</td>
    <td style="text-align:left">PCA (2)</td>
    <td style="text-align:center"><a href="/workshops/quantecol/08-pca_sdg/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/WHO/WHO.zip/"><i class="fas fa-file-archive" title="WHO.zip"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 9</td>
    <td style="text-align:left">CA</td>
    <td style="text-align:center"><a href="/workshops/quantecol/09-ca/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_09_CCA.pdf"><i class="fas fa-file-pdf" title="Lecture 9 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/Num_Ecol_R_book_ed1/DoubsEnv.csv"><i class="fas fa-file-csv" title="DoubsEnv.csv"></i></a> <a href="/BCB743/Num_Ecol_R_book_ed1/DoubsSpe.csv"><i class="fas fa-file-csv" title="DoubsSpe.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 10</td>
    <td style="text-align:left">PCoA</td>
    <td style="text-align:center"><a href="/workshops/quantecol/10-pcoa/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_10_PCoA.pdf"><i class="fas fa-file-pdf" title="Lecture 10 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/seaweed/SeaweedEnv.RData"><i class="fas fa-file-export" title="SeaweedEnv.RData"></i></a> <a href="/BCB743/Num_Ecol_R_book_ed1/DoubsEnv.csv"><i class="fas fa-file-csv" title="DoubsEnv.csv"></i></a> <a href="/BCB743/Num_Ecol_R_book_ed1/DoubsSpe.csv"><i class="fas fa-file-csv" title="DoubsSpe.csv"></i></a> <a href="/BCB743/seaweed/bioregions.csv"><i class="fas fa-file-csv" title="bioregions.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left">Wk 5</td>
    <td style="text-align:left">Lect 11</td>
    <td style="text-align:left">nMDS</td>
    <td style="text-align:center"><a href="/workshops/quantecol/11-nmds/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_11_nMDS.pdf"><i class="fas fa-file-pdf" title="Lecture 11 slides"></i></a></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/BCB743/Num_Ecol_R_book_ed1/DoubsEnv.csv"><i class="fas fa-file-csv" title="DoubsEnv.csv"></i></a> <a href="/BCB743/Num_Ecol_R_book_ed1/DoubsSpe.csv"><i class="fas fa-file-csv" title="DoubsSpe.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Self study</td>
    <td style="text-align:left">nMDS + PERMANOVA (diatoms)</td>
    <td style="text-align:center"><a href="/workshops/quantecol/11-nmds_diatoms/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
     <td style="text-align:center"></td>
    <td style="text-align:center"><a href="/pdf/BCB743/Mayombo_et_al_2019.pdf"><i class="fas fa-file-pdf" title="Mayombo et al (2019)"></i></a></td>
    <td style="text-align:center"><a href="/BCB743/diatoms/PB_data_matrix_abrev.csv"><i class="fas fa-file-csv" title="PB_data_matrix_abrev.csv"></i></a> <a href="/BCB743/diatoms/PB_data_matrix.csv"><i class="fas fa-file-csv" title="PB_data_matrix.csv"></i></a> <a href="/BCB743/diatoms/PB_diat_env.csv"><i class="fas fa-file-csv" title="PB_diat_env.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 12</td>
    <td style="text-align:left">CCA &amp; RDA</td>
    <td style="text-align:center"><a href="/workshops/quantecol/12-constrained_ordination/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/BCB743_12_constrained_ordination.pdf"><i class="fas fa-file-pdf" title="Lecture 12 slides"></i></a></td>
    <td style="text-align:center"><a href="/pdf/BCB743/Smit_et_al_2017.pdf"><i class="fas fa-file-pdf" title="Smit et al (2017)"></i></a> <a href="/pdf/BCB743/The_seaweed_data.pdf"><i class="fas fa-file-pdf" title="About the seaweed data"></i></a></td>
    <td style="text-align:center"><a href="/BCB743/seaweed/SeaweedsSpp.csv"><i class="fas fa-file-csv" title="SeaweedsSpp.csv"></i></a> <a href="/BCB743/seaweed/SeaweedsEnv.csv"><i class="fas fa-file-csv" title="SeaweedsEnv.csv"></i></a> <a href="/BCB743/seaweed/sites.csv"><i class="fas fa-file-csv" title="sites.csv"></i></a> <a href="/BCB743/seaweed/bioregions.csv"><i class="fas fa-file-csv" title="bioregions.csv"></i></a></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left"></td>
    <td style="text-align:left"><strong>CLUSTER ANALYSIS</strong></td>
    <td style="text-align:center"></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left">Wk 6</td>
    <td style="text-align:left">Lect 13</td>
    <td style="text-align:left">Cluster analysis</td>
    <td style="text-align:center"><a href="/workshops/quantecol/13-cluster_analysis/"><i class="fas fa-graduation-cap" aria-hidden="true"></i></a></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    <tr>
    <td style="text-align:left"></td>
    <td style="text-align:left">Lect 13</td>
    <td style="text-align:left">Review &amp; assignment</td>
    <td style="text-align:center"></td>
    <td style="text-align:left"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    <td style="text-align:center"></td>
    </tr>
    </tbody>
</table>
{{< /rawhtml >}}

# Modern ecological problems

**This is a course about community ecology and not so much about population ecology.** Community ecology underpins the vast fields of biodiversity and biogeography, and concerns spatial scales from squares of meters to all of Earth. We can look at historical, contemporary, and future processes that have been implicated in shaping the distribution of life on our planet.

Community ecologists tend to analyse how multiple environmental factors act as drivers that influence the distribution of tens or hundreds of species. These data tend to often be messy (not in the sense of untidy data as per the 'tidyverse' definition of tidy data, but it can be that too!) and statistical considerations need to be understood within the context of the data available to us. This translates to errors of measurement and errors due to extreme values, the presence of a few very rare or very abundant species, autocorrelated residuals (due to repeated sampling, for example), colinearity, etc. These challenges make to application of 'basic' statistical approaches problematic, and a new branch of inferential and exploratory statistical needs to be followed. These approaches involve techniques that allow us to work with all the data at once, and because it can simultaneously analyse all the variables (multiple environmental drivers acting on multiple species at multiple places and across multiple times), this group of statistics is called 'multivariate statistics.' There are two main groups of multivariate statistics: 'classifications' and 'ordinations.' Classification generally concerns placing samples (species or environments) into groups or hierarchies of groups, while ordination is best suited for analyses that involve arranging samples along gradients. Often they complement each other, but we shall see later that each approach has its own strengths. Irrespective of the analysis, the data share a few characteristics.

These multivariate datasets have far more information in them than can de detected by the human eye and univariate statistics.

![More than meets the eye](/workshops/quantecol/_index_files/more_than_meets_the_eye.jpeg)

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

