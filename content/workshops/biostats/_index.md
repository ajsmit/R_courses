---
author: "AJ Smit, Robert Schlegel"
categories:
  - Basics
  - R
  - Statistics
  - Visualisation
date: "2021-01-25"
description: |
  BCB's Biostatistics pages
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: Additional resources
    url: https://ajsmit.github.io/BCB744/Web-Resources.html
layout: single-series
publishDate: "2021-01-22"
show_author_byline: false
show_post_date: true
show_post_thumbnail: true
slug: bcb744_intro
subtitle: Biostatistics
tags:
  - basic
  - statistics
  - graphics
title: BCB744 (Part B)
weight: 2
---

These notes are provided to students at the BioStatistics in R (BCB744) Workshop, held at The University of the Western Cape, 28 March - 1 April 2022.

**Authors:** Prof AJ Smit and Dr Robert Schlegel

> *"An approximate answer to the right problem is worth a good deal more than an exact answer to an approximate problem."*
>
> --- John Tukey

![Assumptions](/workshops/biostats/_index_files/wahlberg_assumptions.jpeg)

<!--- # About --->

> *"A scientist worthy of a lab coat should be able to make original discoveries while wearing a clown suit, or give a lecture in a high squeaky voice from inhaling helium. It is written nowhere in the math of probability theory that one may have no fun."*
>
> --- Eliezer Yudkowsky

> *"Prediction is very difficult, especially about the future."*
>
> ---- Niels Bohr

<!-- ## Preliminaries -->

## Venue, date and time

Basic Statistics is the second half of the BSc (Hons) BioStats BCB744 core module, and will run in Semester 1 of 2022. This workshop will take place from Monday 28 March to Friday 1 April from 8:30--15:30. There will be an assignment due about three weeks after the end of this module, as well as a test; these two marks will contribute 50% of the marks for the BioStats module. More on the assignment and test later.

## Course outline

1.  About (this chapter)
2.  Types of data
3.  Descriptive statistics: Measures of location and dispersion
4.  Representing data graphically
5.  Distributions
6.  One-sample and two-sample tests
7.  Multi-sample (\>2) tests
8.  Linear regression
9.  Correlation
10. Confidence intervals
11. Transforming data
12. Generalised linear model (GLM)
13. Chi square tests

The course content can broadly be classified into two parts: *Descriptive Statistics* and *Inferential Statistics*.

Descriptive statistics and their associated statistical and graphical data summaries will be covered in Chapters 3 and 4. In Chapter 5 we will introduce the concepts of data distributions, knowledge of which is required to select the most appropriate inferential statistical methods.

Chapters 6-13 are about inferential statistics. Inferential tests allow us to evaluate hypotheses within a framework of probabalistic theory, which helps us infer the nature of a 'population' based on a smaller represenative set of samples. In partiucular, we can infer whether the property under scrutiny (arrived at by means of a designed experiment or a directed sampling programme) occured as a result of deterministic influences, or whether it is as a result of chance.

> **NOTE:** I will not be covering everything in these notes, but will only have time to focus on the main points. I hope that by providing longer notes than necessary, it is a resource you can work through by yourself after the workshop.

## About this Workshop

The aim of this workshop is to guide you through the outline given above. The workshop focuses broadly (and unequally) on three groups of concepts:

-   Data and distributions
-   Descriptive statistics and graphics
-   Inferential statistics

Data and distributions are unsurprisingly about the data itself. Here we will talk about the various kinds of data that we will encounter as biologists. In the second part we will describe the data using a combination of numerical and graphical summaries. Third, all of this culminates in trying to infer from a small subset (a sample) of subjects if the characteristics under scrutiny also hold true for the entire population. We may also ask questions about probailities, i.e. measuring the likelihood that an event will occur, or that an experiment has an outcome that is different from a situation where the influential factor(s) has no effect, or that some observation or outcome is non-random.

## This is biology: why more R coding?

Please refer to the [Intro R Workshop: Data Manipulation, Analysis and Graphing](https://ajsmit.github.io/Intro_R_Official/) for why we feel strongly that you use R [@R2017] for the analyses that we will perform here. All of the reasons provided there are valid here too, but one reason perhaps more so than others---R and RStudio promote the principles of *reproducible research*, and in fact make it very easy to implement. We will focus on some of these principles throughout the workshop, and the assignments will require that you submit a fully functional working script, complete with all the notes, memos, examples, data, executable code, and output that will result from completing the course material.

What other options are there for analysing the kinds of data that we will encounter in biological research? Software packages like the ones you may be familiar with, such as Statistica and SPSS, are often used to perform many of these analyses. They are rather limited with regards to the full scope of modern statistical methods in use by biologists today, but many people still use these kinds of software as they provide the basic kinds analyses that still form the staple of the biological and medical sciences. For the many reasons provided above, we prefer to use R as the *engine* within which to do our biological data analysis. R is used by academic statisticians the world over, and it is therefore an excellent choice for our purpose here.

## Installing R and RStudio

We assume that you already have R installed on your computer, as all of you will have already completed the the Intro R Workshop. If you need a refresher, please refer to [Intro R Workshop: Data Manipulation, Analysis and Graphing](https://ajsmit.github.io/Intro_R_Official/) for the installation instructions.

## Resources

-   New users should introduce themselves to the [R ecosystem](fg2re.sellorm.com)
-   A fancy interactive website that covers a wide range of [basic statistics](http://students.brown.edu/seeing-theory/)
-   An easy to follow walkthrough for a [statistical analysis](http://www.sthda.com/english/wiki/unpaired-two-samples-t-test-in-r)
-   Learn more about [tidy statistical inference](https://infer.netlify.com)
-   A thorough journey through the philosophy of [data visualisation](http://www.serialmentor.com/dataviz/)
-   [Google](www.google.com)
-   [Stack Overflow](www.stackoverflow.com)

## Assessment and teaching philosophy

Your grades will be based on the aggregate performance across two group projects; the first group project was completed after the Intro R Workshop. The project for this workshop will represent 35% of the total grade for BioStatistics. The remaining 15% will come from daily participation. This will be assessed by the R scripts produced in class and follows these five criteria:

-   The script has been uploaded to GitHub
-   The script covers the content of the day
-   The code runs without errors
-   Proper style conventions have been observed
-   Liberally commented

**BONUS POINTS**

-   Additional analysis not performed in class
-   Additional figure not created in class

In cases where students are borderline between lower and higher grades, a high level of participation in the class discussions and class in general will win the day for the higher grade.

The daily scripts are essential to understanding the material. Although they comprise only 15% of the final grade, performance on the projects is usually correlated with effort on the daily assignments.

Whereas plagiarism will not be tolerated, students ARE encouraged to work together to learn from one another and solve problems in a collaborative and collegial way.

## About this document

This document, which as available as an HTML file that's viewable on a web browser of your choice (anything will do, but we discourage using Internet Explorer) and as a PDF (accessible from the link at the top of any of the website's pages) that may be printed, was prepared by the software tools available to R via RStudio. We use the package called `bookdown` that may be accessed and read about [here](https://bookdown.org/yihui/bookdown/) to produce this documentation. The entire source code to reproduce this book is available from my [GitHub repo](https://github.com/ajsmit/Basic_stats).

You will notice that this repository uses [GitHub](https://github.com), and you are advised to set up your own repository for R scripts and all your data. We will touch on GitHub and the principles of reproducible research later, and GitHub forms a core ingredient of such a workflow.

<!-- The R session information when compiling this book is shown below: -->

<!-- ```{r prelim-session} -->

<!-- sessionInfo() -->

<!-- ``` -->
