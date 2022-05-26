---
date: "2021-01-01"
draft: false
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: Intro Slides
    url: /pdf/BCB743/BCB743_01_intro.pdf
  - icon: images
    icon_pack: fas
    name: Intro Exercises
    url: /slides/BCB743/01-introduction.html
subtitle: ""
title: "1. Introduction"
weight: 2
---

> *"The great challenge of the twenty-first century is to raise people everywhere to a decent standard of living while preserving as much of the rest of life as possible."*
>
> --- Edward O. Wilson

![NSFW](/quantecol/chapters/01-introduction_files/NSFW.jpg)

(This chapter is in development.)

## Macroecology and quantitative ecology

**This is a course about community ecology and not so much about population ecology.** Community ecology underpins the vast fields of biodiversity and biogeography, and concerns spatial scales from squares of meters to all of Earth. We can look at historical, contemporary, and future processes that have been implicated in shaping the distribution of life on our planet.

Community ecologists tend to analyse how multiple environmental factors act as drivers that influence the distribution of tens or hundreds of species. These data tend to often be messy (not in the sense of untidy data as per the 'tidyverse' definition of tidy data, but it can be that too!) and statistical considerations need to be understood within the context of the data available to us. This translates to errors of measurement and errors due to extreme values, the presence of a few very rare or very abundant species, autocorrelated residuals (due to repeated sampling, for example), collinearity, etc. These challenges make to application of 'basic' statistical approaches problematic, and a new branch of inferential and exploratory statistics needs to be followed. These approaches involve techniques that allow us to work with all the data at once, and because it can simultaneously analyse all the variables (multiple environmental drivers acting on multiple species at multiple places and across multiple times), this group of statistics is called **multivariate statistics**. There are two main groups of multivariate statistics: **classifications** and **ordinations**. Classification generally concerns placing samples (species or environments) into groups or hierarchies of groups, while ordination is best suited for analyses that involve arranging samples along gradients. Often they complement each other, but we shall see later that each approach has its own strengths. Irrespective of the analysis, the data share a few characteristics.

These multivariate datasets have far more information in them than can de detected by the human eye and univariate statistics.

<img src="/quantecol/_index_files/more_than_meets_the_eye.jpeg" alt="More than meets the eye" width="80%"/>

**Macroecology** is an all-encompassing view of ecology, which seeks to define the geographical patterns and processes in biodiversity across all spatial scales, from local to global, across time scales from years to millennia, and across all taxonomic hierarchies (from genetic variability within species, up to major higher level taxa, such as families and orders). It attempts to arrive a unifying theory for ecology across all of these scales—e.g. one that can explain all patterns in structure and functioning from microbes to blue whales. Most importantly, perhaps, is that it attempts to offer mechanistic explanations for these patterns. At the heart of all explanation is also deep insights stemming from understanding evolution (facilitated by the growth of phylogenetic datasets---see below).
This is a modern development of ecology, whereas up to 20 years ago the focus has been mostly on populations (the dynamics of individuals of one species interacting among each other and with their environment) and communities (collections of multiple populations, and how they interact with each other and their environment, and how this affects the structure and dynamics of ecosystems).

On a basic data analytical level, population ecology, community ecology, and macroecology all share the same approach as far as the underlying data are concerned. We start with **tables of species and environmental** conditions at a selection of sites, and these are converted to **distance and dissimilarity matrices**. From here analyses can show insights into how biodiversity is structured, e.g. **species-abundance distributions**, **occupancy-abundance curves**, **species-area curves**, **distance decay curves**, and **gradient analyses**. 

In the last decade, modern developments in statistical approaches have contributed towards the development of macroecology, because of the growth of **hypotheses-driven** (but not necessarily involving experimentation) multivariate statistical approaches geared to test for the presence of one or several ecological hypotheses---this was not seen in population and community ecology so much. Contributing towards the growth of macroecology and the underlying statistical approaches, the deluge of new data across vast scales has also necessitated deeper analytical development, i.e. leveraging statistical tools and also the power of **modern computing infrastructure**. These modern approaches are also bringing into the fold of combined computations based on species and environmental tables also data on the phylogenetic relationships among organisms (and hence this brings the context of evolution).

## Data

### Properties of ecological datasets

Ecological data sets are usually arrange in a *matrix*, which **has species (or higher level taxa, whose resolution depends on the research question at hand) arranged as columns** and **samples (typically the sites, stations, transects, time, plots, etc.) as rows**. We call this a **sites × species** table. In the case of environmental data it will of course be a **sites × environment** table. The term 'sample' may be applied differently compared to how we used it in the [Basic Statistics Workshop](https://ajsmit.github.io/R_Stats_Official/); here we use it to denote the basic unit of observation. Samples may be quadrats, transects, stations, sites, traps, seine net tows, trawls, grids cells on a map, etc. It is important to clearly and unambiguously define the basic unit of the sample in the paper's Methods section.

Example species and environmental data sets are displayed below in Figures 2.1-2.4. The species matrix here comprises distribution records of 846 macroalgal species within each of 58 × 50 km-long sections along South Africa's coastline. So, the matrix has 58 rows, one for each sample (here each of the coastal sections), and 846 columns, one for each of the seaweed species found in South Africa. Some of the coastal sections do not have a species present and it will simply be coded as 0 (for not present in the case of presence/absence data, or 0 units of biomass or abundance, etc.). The matching environmental data set has information about various measurements of seawater temperature and chlorophyll-*a* content---their names are along the columns, and there are 18 of them. It is important that a sample of the environment is available for each of the seaweed samples, so there will also be 58 rows present in this data set. So, it is a matching data set in the sense that each sample of species data is matched by a sample of the environment (both have 58 rows). Using this data set, it was the intention of Smit et al. (2017) to describe the gradients in seaweed distribution as a function of the underlying seawater temperatures.

![The table (or spreadsheet) view of the species data. Note the species codes appearing as column headers; numbered from 1 through to 58 (row 58 is at the bottom of the table, so you'd have to scroll down to see it) at the bottom of the table are each of the samples --- in this case, there is one sample per station.](/quantecol/chapters/01-introduction_files/species_table.png)

![This is a tibble printout of the same species data we saw in the previous Figure](/quantecol/chapters/01-introduction_files/env_tibble.png)

![The table view of the environmental data. The names of the environmental variables appear as column headers, and numbered from 1 through to 58 at the bottom of the table are each of the samples --- the samples are defined as per the previous figures.](/quantecol/chapters/01-introduction_files/species_table.png)

Species data may be recorded as various kinds of measurements, such as presence/absence data, biomass, frequency, or abundance. 'Presence/absence' of species simply tells us the the species is there or is not there. It is binary. 'Abundance' generally refers to the number of individuals per unit of area or volume, or to percent cover. 'Biomass' refers to the mass of the species per unit of area or volume. The type of measure will depend on the taxa and the questions under consideration. The important thing to note is that all species have to be homogeneous in terms of the metric used (i.e. all of it as presence/absence, or abundance, or biomass, not mixtures of them). The matrix's constituent row vectors are considered the species composition for the corresponding sample (i.e. a row runs across multiple columns, and this tells us that the sample is comprised of all the species whose names are given by the column titles---note that in the case of the data in Figure 2.1-2.2, it is often the case that there are 0s, meaning that not all species are present at some sites). Species composition is frequently expressed in terms of relative abundance; i.e. constrained to a constant total such as 1 or 100%.

The environmental data may be heterogeneous, i.e. the units of measure may differ among the variables. For example, pH has no units, concentration of some nutrient has a unit of (typically) μM, elevation may be in meters, etc. Because these units differ so much, and because they therefore have different magnitudes and ranges, we may need to standarise them. The purpose of multivariate analysis is to find patterns in these complex sets of data, and to explain why these patterns are present.

Many community data matrices share some general characteristics:

-   Most species occur only infrequently. The majority of species might typically be represented at only a *few locations* (where they might be quite abundant). Or some species are simply *rare* in the sampled region (i.e. when they are present, they are present at a very low abundance). This results in *sparse matrices*, as we see in Figures 2.1-2.2, where the bulk of the entries consists of zeros.

-   Ecologists tend to sample a multitude of factors that they think influence species composition, so the matching environmental data set will also have multiple (10s) of columns that will be assessed in various hypotheses about the drivers of species patterning across the landscape. For example, fynbos biomass may be influenced by the fire regime, elevation, aspect, soil moisture, soil chemistry, edaphic features, etc. These datasets are called *multi-dimensional* matrices, with the 'dimensions' referring the the many species or environmental variables.

-   Even though we may capture a multitude of information about many environmental factors, *the number of important ones is generally quite low* --- i.e. a few factors can explain the majority of the explainable variation, and it is our intention to find out which of them is most important.

-   Much of the signal may be spurious, i.e. the matrices have *high noise*. Variability is a general characteristic of the data, and this may result in false patterns emerging. This is so because our sampling may capture a huge amount of stochasticity (processes that are entirely non-deterministic), which may mask the real pattern of interest. Imaginative and creative sampling may reveal some of the patterns we are after, but this requires long years of experience and is not something that can easily be taught as part of our module.

-   There is a huge amount of *collinearity*. Basically, what this means is that although it is often the case that many explanatory variables are able to explain patterning, only a few of them act in a way that implies causation. Collinearity is something we will return to later on.

### Field sampling

### Historical data

### Remotely sensed data

### Modelled data (projections)

## Exploring the data

### In the beginning
At the start of the analysis, before we get to the hypothesis testing and multivariate approaches, we need to explore the data and compute the various synthetic descriptors (refer to the Basic Statistics Workshop). Recall that this exploratory data analysis includes the various measures of central tendency and dispersion/variation around the mean or median. Using the techniques that we already know, we can produce data summaries and statistical visualisations for each variable independently. So, we say that we produce univariate summaries, and if there is a need, we may also wish to include some of the univariate inferential statistics. Be guided by the research questions as to what is required. Typically, I don't like to produce too many detailed inferential statistics of the univariate data, choosing in stead to see which relationships and patterns emerge from the exploratory summary plots before testing their statistical significance using multivariate approaches. But that is me. Sometimes, some hypotheses call for a few univariate inferential analyses.

### Geographical coordinates

We will examine in this section ways to plot the species and environmental data on maps...

### Describe the environment

### Describe the community data

### Data transformations

Make a table of the various types of ecological distances (Euclidean, Sørensen, Bray-Curtis, etc.), and what to use them for (typically). Refer to Table 3.1, p. 51, of @borcard2011.

## Pairwise matrices

Although we typically start our forays into data exploration using sites × species and sites × environment tables, the formal statistical analyses usually require 'pairwise association matrices.' Such matrices are symmetrical (or lower triangle) square matrices (i.e. `\(n \times n\)`). These matrices tell us about how related any sample is with any other sample in our pool of samples (i.e. relatedness among rows with respect to whatever populates the columns, be they species information of environmental information).

Let us consider various kinds of distance matrices under the following headings.

### Correlation

### Association

Two samples with similar species composition are ecologically similar, while two samples that share few species are ecologically distant. In Figure 4.1, below, the data displayed in Figure 2.1 have been converted into a dissimilarity distance matrix of dimension `\(58 \times 58\)`. The are a few things of interest in this matrix:

* The distance matrix is square and therefore symmetrical. In other words, there are as many rows as there are columns, and this number corresponds to the number of samples in our sites × species matrix.

* The cells of the diagonal running from top-left to bottom-right contain zeros, showing rather obviously that there is no difference between a sample and the sample itself. 

* The 'upper triangle' above the diagonal is an inversion of the 'lower triangle' below the diagonal; because they are identical in terms of the pairwise relationships that they encode, distance matrices are sometimes represented simply by the lower triangular matrix.

* These matrices contain ecological information. For example, between samples (here each of 58 × 50-km long coastal sections) that are geographically close together, the dissimilarity will is generally low (i.e. the samples are similar in their species composition), while the further sites are removed from each other, the greater the dissimilarity will be. (*Note: not all samples are not always related to each other as a function of distance --- this is a characteristic of the data used for this particular example analysis, so be aware of the context when interpreting distance matrices.*)

* All information about the particular species present within each sample are now gone since that information has been collapsed to a dissimilarity measure.

### Similarity and dissimilarity

## The kinds of multivariate analyses

### Cluster analysis

The objective of cluster analysis is to recognise groups of ecologically-related species in an environment, e.g., as which might belong to different vegetation types. Classification is suitable to studies where the processes in question do not necessarily act along gentle gradients, but result from rapid disjunctions between portions of the environment. Typical research questions that are addressed by classification techniques are:

* Are the collections of species similar enough to justify placing them into groups? 

* How do we recognise what the typical features are (e.g. the complement of species; the suite of environmental variables) that cause the samples to fall within one group or another?

### Unconstrained ordination

### Constrained (canonical) ordination

This kind of analysis is sometimes called 'direct gradient analysis'.

With the introduction of Constrained Correspondence Analysis (CCA), testing statistical hypotheses became possible within a multivariate framework, allowing us to move beyond applying multivariate techniques simply for pattern-finding or exploratory purposes (ter Braak 1985).
