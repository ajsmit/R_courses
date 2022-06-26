---
author: Prof. AJ Smit
description: "Website for the BCB743 module offered as elective to the University of the Western Cape Biodiversity & Conservation Biology Honours students."
layout: single-series
show_author_byline: true
show_post_date: false
show_post_thumbnail: true
subtitle:
thumbnail_left: false
title: Quantitative Ecology
type: collection

# set up common front matter for all individual pages inside project
cascade:
  layout: single-series
  show_author_byline: true
  show_post_date: true
  show_comments: false
  type: collection
---

# Syllabus, overview, and expectations
<!--- # Introduction --->

> *"We have become, by the power of a glorious evolutionary accident called intelligence, the stewards of life's continuity on earth. We did not ask for this role, but we cannot abjure it. We may not be suited to it, but here we are."*
>
> --- Stephen J. Gould

## Syllabus

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
      <td style="text-align:left">W1</td>
      <td style="text-align:left">L1</td>
      <td style="text-align:left">Introduction</td>
      <td style="text-align:center"><a href="/quantecol/chapters/01-introduction/" title="Lecture 1"><i class="fas fa-chalkboard-teacher"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_01_intro.pdf"><i class="fas fa-images" title="Lecture 1 slides"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BES-Data-Guide-2017_web.pdf"><i class="fas fa-images" title="BES Data Guide"></i></a> <a href="/pdf/BCB743/BES-Reproducible-Code-2017.pdf"><i class="fas fa-images" title="BES Reproducible Code"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
      <td style="text-align:left"><i class="fas fa-book-open"></i> <strong>BIODIVERSITY</strong></td>
      <td style="text-align:center"></td>
      <td style="text-align:left"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L2</td>
      <td style="text-align:left">Quantifying Diversity</td>
      <td style="text-align:center"><a href="/quantecol/chapters/02a-biodiversity/"><i class="fas fa-chalkboard-teacher" title="Lecture 2"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_02_biodiversity_1.pdf"><i class="fas fa-images" title="Lecture 2 slides (1)"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/Smit_et_al_2013.pdf"><i class="fas fa-file-pdf" title="Smit et al (2013)"></i></a> <a href="/pdf/BCB743/Smit_et_al_2017.pdf"><i class="fas fa-file-pdf" title="Smit et al (2017)"></i></a> <a href="/pdf/BCB743/Smit_the_seaweed_data.pdf"><i class="fas fa-file-pdf" title="About the seaweed data"></i></a></td>
      <td style="text-align:center"><a href="/BCB743/seaweed/SeaweedsSpp.csv"><i class="fas fa-file-csv" title="SeaweedsSpp.csv"></i></a> <a href="/BCB743/seaweed/light_levels.csv"><i class="fas fa-file-csv" title="light_levels.csv"></i></a></td>
      <td style="text-align:center"><a href="/slides/BCB743/02-biodiversity.html"><i class="fas fa-balance-scale-right" title="Lecture 2 exercises"></i></a></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L3</td>
      <td style="text-align:left">Quantifying Structure and Pattern</td>
      <td style="text-align:center"><a href="/quantecol/chapters/02b-biodiversity/"><i class="fas fa-chalkboard-teacher" title="Lecture 2"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_02_biodiversity_2.pdf"><i class="fas fa-images" title="Lecture 2 slides (2)"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/Shade_et_al_2018.pdf"><i class="fas fa-file-pdf" title="Shade et al (2018)"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left">W2</td>
      <td style="text-align:left">Self</td>
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
      <td style="text-align:left"><i class="fas fa-book-open"></i> <strong>MATRICES</strong></td>
      <td style="text-align:center"></td>
      <td style="text-align:left"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L4</td>
      <td style="text-align:left">Environmental distance</td>
      <td style="text-align:center"><a href="/quantecol/chapters/04-env_dist/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_04_environmental_distance.pdf"><i class="fas fa-images" title="Lecture 4 slides"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/seaweed/Euclidian_distance_demo_data_xyz.csv"><i class="fas fa-file-csv" title="Euclidian_distance_demo_data_xyz.csv"></i></a> <a href="/BCB743/seaweed/Euclidian_distance_demo_data_env.csv"><i class="fas fa-file-csv" title="Euclidian_distance_demo_data_env.csv"></i></a> <a href="/BCB743/seaweed/sites.csv"><i class="fas fa-file-csv" title="sites.csv"></i></a></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L5</td>
      <td style="text-align:left">Species dissimilarity</td>
      <td style="text-align:center"><a href="/quantecol/chapters/05-spp_dissimilarity/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_05_dissimilarity.pdf"><i class="fas fa-images" title="Lecture 5 slides"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData"><i class="fas fa-file-export" title="Doubs.RData"></i></a></td>
      <td style="text-align:center"><a href="/slides/BCB743/05-spp_dissimilarity.html"><i class="fas fa-balance-scale-right" title="Lecture 5 exercises"></i></a></td>
    </tr>
    <tr>
      <td style="text-align:left">W3</td>
      <td style="text-align:left">Self</td>
      <td style="text-align:left">Deeper into gradients</td>
      <td style="text-align:center"><a href="/quantecol/chapters/03-deep_dive/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:left"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/seaweed/SeaweedEnv.RData"><i class="fas fa-file-export" title="SeaweedEnv.RData"></i></a> <a href="/BCB743/seaweed/dists_mat.RData"><i class="fas fa-file-export" title="dists_mat.RData"></i></a> <a href="/BCB743/seaweed/bioregions.csv"><i class="fas fa-file-csv" title="bioregions.csv"></i></a></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L6</td>
      <td style="text-align:left">Correlations et al.</td>
      <td style="text-align:center"><a href="/quantecol/chapters/06-correlations/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_06_correlations.pdf"><i class="fas fa-images" title="Lecture 6 slides"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData"><i class="fas fa-file-export" title="Doubs.RData"></i></a></td>
      <td style="text-align:center"><a href="/slides/BCB743/06-correlations.html"><i class="fas fa-balance-scale-right" title="Lecture 6 exercises"></i></a></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
      <td style="text-align:left"><i class="fas fa-book-open"></i> <strong>ORDINATION</strong></td>
      <td style="text-align:center"></td>
      <td style="text-align:left"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L7</td>
      <td style="text-align:left">Ordination</td>
      <td style="text-align:center"><a href="/quantecol/chapters/07-ordination/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_07_ordination.pdf"><i class="fas fa-images" title="Lecture 7 slides"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L8</td>
      <td style="text-align:left">PCA (1)</td>
      <td style="text-align:center"><a href="/quantecol/chapters/08-pca/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_08_PCA.pdf"><i class="fas fa-images" title="Lecture 8 slides"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData"><i class="fas fa-file-export" title="Doubs.RData"></i></a> <a href="/BCB743/NEwR-2ed_code_data/NEwR2-Functions/cleanplot.pca.R"><i class="fas fa-file-code" title="cleanplot.pca.R"></i></a></td>
      <td style="text-align:center"><a href="/slides/BCB743/08-pca.html"><i class="fas fa-balance-scale-right" title="Lecture 8 exercises"></i></a></td>
    </tr>
    <tr>
      <td style="text-align:left">W4</td>
      <td style="text-align:left">Self</td>
      <td style="text-align:left">PCA (2)</td>
      <td style="text-align:center"><a href="/quantecol/chapters/08-pca_sdg/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:left"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/WHO/WHO.zip/"><i class="fas fa-file-archive" title="WHO.zip"></i></a></td>
      <td style="text-align:center"><a href="/slides/BCB743/08-pca_sdg.html"><i class="fas fa-balance-scale-right" title="Self study exercises"></i></a></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L9</td>
      <td style="text-align:left">CA</td>
      <td style="text-align:center"><a href="/quantecol/chapters/09-ca/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_09_CCA.pdf"><i class="fas fa-images" title="Lecture 9 slides"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData"><i class="fas fa-file-export" title="Doubs.RData"></i></a></td>
      <td style="text-align:center"><a href="/slides/BCB743/09-ca.html"><i class="fas fa-balance-scale-right" title="Lecture 9 exercises"></i></a></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L10</td>
      <td style="text-align:left">PCoA</td>
      <td style="text-align:center"><a href="/quantecol/chapters/10-pcoa/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_10_PCoA.pdf"><i class="fas fa-images" title="Lecture 10 slides"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/seaweed/SeaweedEnv.RData"><i class="fas fa-file-export" title="SeaweedEnv.RData"></i></a> <a href="/BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData"><i class="fas fa-file-export" title="Doubs.RData"></i></a> <a href="/BCB743/seaweed/bioregions.csv"><i class="fas fa-file-csv" title="bioregions.csv"></i></a></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left">W5</td>
      <td style="text-align:left">L11</td>
      <td style="text-align:left">nMDS</td>
      <td style="text-align:center"><a href="/quantecol/chapters/11-nmds/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_11_nMDS.pdf"><i class="fas fa-images" title="Lecture 11 slides"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData"><i class="fas fa-file-export" title="Doubs.RData"></i></a></td>
      <td style="text-align:center"><a href="/slides/BCB743/11-nmds.html"><i class="fas fa-balance-scale-right" title="Lecture 11 exercises"></i></a></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">Self</td>
      <td style="text-align:left">nMDS + PERMANOVA (diatoms)</td>
      <td style="text-align:center"><a href="/quantecol/chapters/11-nmds_diatoms/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/pdf/BCB743/Mayombo_et_al_2019.pdf"><i class="fas fa-file-pdf" title="Mayombo et al (2019)"></i></a></td>
      <td style="text-align:center"><a href="/BCB743/diatoms/PB_data_matrix_abrev.csv"><i class="fas fa-file-csv" title="PB_data_matrix_abrev.csv"></i></a> <a href="/BCB743/diatoms/PB_data_matrix.csv"><i class="fas fa-file-csv" title="PB_data_matrix.csv"></i></a> <a href="/BCB743/diatoms/PB_diat_env.csv"><i class="fas fa-file-csv" title="PB_diat_env.csv"></i></a></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L12</td>
      <td style="text-align:left">CCA &amp; RDA</td>
      <td style="text-align:center"><a href="/quantecol/chapters/12-constrained_ordination/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/BCB743_12_constrained_ordination.pdf"><i class="fas fa-images" title="Lecture 12 slides"></i></a></td>
      <td style="text-align:center"><a href="/pdf/BCB743/Smit_et_al_2017.pdf"><i class="fas fa-file-pdf" title="Smit et al (2017)"></i></a> <a href="/pdf/BCB743/The_seaweed_data.pdf"><i class="fas fa-file-pdf" title="About the seaweed data"></i></a></td>
      <td style="text-align:center"><a href="/BCB743/seaweed/SeaweedsSpp.csv"><i class="fas fa-file-csv" title="SeaweedsSpp.csv"></i></a> <a href="/BCB743/seaweed/SeaweedsEnv.csv"><i class="fas fa-file-csv" title="SeaweedsEnv.csv"></i></a> <a href="/BCB743/seaweed/sites.csv"><i class="fas fa-file-csv" title="sites.csv"></i></a> <a href="/BCB743/seaweed/bioregions.csv"><i class="fas fa-file-csv" title="bioregions.csv"></i></a></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
      <td style="text-align:left"><i class="fas fa-book-open"></i> <strong>CLUSTER ANALYSIS</strong></td>
      <td style="text-align:center"></td>
      <td style="text-align:left"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left">W6</td>
      <td style="text-align:left">L13</td>
      <td style="text-align:left">Cluster analysis</td>
      <td style="text-align:center"><a href="/quantecol/chapters/13-cluster_analysis/"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i></a></td>
      <td style="text-align:left"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
    </tr>
    <tr>
      <td style="text-align:left"></td>
      <td style="text-align:left">L13</td>
      <td style="text-align:left">Review &amp; assignment</td>
      <td style="text-align:center"></td>
      <td style="text-align:left"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"></td>
      <td style="text-align:center"><a href="/slides/BCB743/10-int_assign.html"><i class="fas fa-balance-scale-right" title="Integrative assignment"></i></a></td>
    </tr>
  </tbody>
</table>
{{< /rawhtml >}}


**The icons in the table indicate the following:**

<i class="fas fa-chalkboard-teacher"></i> Worked-through example code accompanying the lecture material.</p>
<i class="fas fa-images"></i> The lecture slides.</p>
<i class="fas fa-file-pdf"></i> PDF material for further reading (compulsory and examinable).</p>
<i class="fas fa-file-csv"></i> CSV data files to accompany the code.</p>
<i class="fas fa-file-export"></i> RData files to go with the worked- through code.</p>
<i class="fas fa-file-code"></i> R scripts.</p>
<i class="fas fa-balance-scale-right"></i> Exercises contributing towards continuous assessment.</p>

 See [**Reading**](/quantecol/#reading) for additional information.

### Main outcomes

By the end of this module, students will be able to:
1.	understand the concepts of alpha, beta and gamma diversity;
2.	know and understand the current hypotheses that attempt to explain species assembly processes in space and time (e.g. neutral and niche mechanisms);
3.	collect ecological data at the appropriate scale, which would lend themselves to a quantitative analysis of points 1 and 2, above;
4.	use the R software and associated packages to undertake the analyses required in point 3, above;
5.	interpret the outcomes of the above analyses and use it to quantitatively characterise points 1 and 2, above; 
6.	communicate the findings by written and oral means.

### Main content

**Core theoretical framework** Ecological hypotheses underlying the processes of species assembly in space and time, including neutral and niche-based mechanisms, and historical events; overview of the currently known and understood distributional patterns of major groups of organisms at global, regional and local scales; consideration of sampling designs aimed at capturing these patterns and drivers so as to arrive at a processed based understanding of species assembly.

**Field-activities** Data collection aimed at a quantitative test of the relevant hypotheses, above.
Statistical/software competence: the management and analysis of ecological data; reproducible and collaborative research; the use of R as a tool for the analysis multivariate ecological data; multivariate techniques such as nMDS, PCA, RDA and cluster analysis; graphical data summaries and visualisations.

## Prerequisites

You should have a moderate numerical literacy and have prior programming experience. Such experience will have been obtained in the [BCB744](/workshops/) module, which is a module about doing statistics in R. If you have a reasonable experience in coding and statistical analysis you should find yourself well prepared.

## Method of instruction

You are provided with reading material (lecture slides, code, website content) that you are expected to consume **prior to the class**. Classes will involve brief introductions to new concepts, and will be followed by working on exercises in class that cover those concepts. The workshop is designed to be as interactive as possible, so while you are working on exercises the tutor and I will circulate among you and engage with you to help you understand any material and the associated code you are uncomfortable with. Often this will result in discussions of novel applications and alternative approaches to the data analysis challenges you are required to solve. More challenging concepts might emerge during the assignments (typically these will be submitted the following day), and any such challenges will be dealt with in class prior to learning new concepts.

Although the module is theory-heavy, a large part of it is also about coding. It is up to you to take your coding skills to the next level and move beyond what I teach in class. Coding is a bit like learning a language, and as such programming is a skill that is best learned by doing.

## Learning colaboratively

Discuss the BCB743 workshop activities with your peers as you work on them. Use also the WhatsApp group set up for the module for discussion purposes (I might assist via this medium if neccesary if your questions/comments have relevance to the whole class). A better option is to use [GitHub Issues](/quantecol/#help-via-bcb744-and-bcb743-issues-on-github). You will learn more in this module if you work with your friends than if you do not. Ask questions, answer questions, and share ideas liberally. Please identify your work partners by name on all assignments (if you decide to work in pairs).

**Cooperative learning is not a licence for plagiarism. Plagiarism is a serious offence and will be dealt with concisely. Consequences of cheating are severe---they range from a 0% for the assignment or exam up to dismissal from the course for a second offense.**

### Reusing code found elsewhere

A huge volume of code is available on the web and it can be adapted to solve your own problems. You may make use of any online resources (e.g. form [StackOverflow](https://stackoverflow.com/), a thoroughly-used source of discussion about [R code](https://stackoverflow.com/questions/tagged/r))---but you **MUST** clearly indicate (cite) that your solution relies on found code, regardless to what extent you have modified it to your own needs. Reused code that is discovered via a web search and which is not explicitly cited is plagiarism and it will be treated as such. On assignments you may not directly share code with your peers in this workshop.

## Software

In this course we will rely entirely on [R](https://cran.r-project.org/) running within the [RStudio](https://www.rstudio.com/) IDE. The use of R was covered extensively in the [BCB744](http://localhost:4321/workshops/) module where the [installation process](http://localhost:4321/workshops/intro_r/chapters/02-rstudio/) was discussed. We will primarily use the [**vegan**](https://cran.r-project.org/web/packages/vegan/index.html) package, but some useful functions are also provided by the package [**BiodiversityR**](https://github.com/cran/BiodiversityR) (and [here](http://apps.worldagroforestry.org/downloads/Publications/PDFS/b13695.pdf) and [here](https://rpubs.com/Roeland-KINDT)). Various other R packages offer overlapping and additional methods, but **vegan** should accommodate >90% of your Quantitative Ecology needs.

## Computers

You are encouraged to provide your own laptops and to install the neccesary software before the module starts. Limited support can be provided if required. There are also computers with R and RStudio (and the neccesary add-on libraries) available in the 5th floor lab in the BCB Department.

## Attendance

This workhop-based, hands on course can only deliver acceptible outcomes if you attend all classes. The schedule is set and cannot be changed. Sometimes an occasional absence cannot be avoided. Please be curtious and notify myself or the tutor in advance of any absence. If you work with a partner in class, notify them too. Keep up with the reading assignments while you are away and we will all work with you to get you back up to speed on what you miss. If you do miss a class, however, the assignments must still be submitted on time (also see [**Late submission of CA**](/quantecol/#late-submission-of-ca)).

Since you may decide to work in collaboration with a peer on tasks and assignments, please keep this person informed at all times in case some emergency makes you unavailable for a period of time. Someone might depend on your input and contributions---do not leave someone in the lurch so that they cannot complete a task in your absence.

## Assessment policy

Continuous assessments (CA) and an exam will provide a final mark for the module. The weighting of the CA and the exam is 0.6 and 0.4, respectively. All assessments are open book, so consult your code and reading material if and when you need to.

### Continuous assessment

Quantitative Ecology is about working with real-world datasets. To this end, a series of mini-projects (assessments) involving real data are a required part of the BCB743. You may work alone or with a single partner on all projects (in which case you will share the same mark). All assignments are due by the date and time indicated, and due care must be taken that they are submitted as instructed, i.e. paying attention to naming conventions and the format of the files submitted---typically this will be in R Markdown (.Rmd) and the knitted output (I prefer .html).

The Continuous Assessment (CA) is comprised of the material indicated in the Syllabus by the <i class="fas fa-balance-scale-right"></i> icon. There are seven smaller assessments (each weighted 0.1) and one slightly more demanding Integrative Assessment (weighted 0.3) at the end of the module.

Random quizzes will not form part of the CA for BCB743.

### Exam

The exam will be a 48-hour affair that you can do in the comfort of your home. It will involve the analysis of real world data, and it is expected that the submission includes 1) statements of aims, objectives, and hypotheses; 2) the full and detailed methods followed by analyses together with all code, 3) full reporting of results in a manner suited for peer reviewed publications; 4) graphical support highlighting the patterns observed (again with the code), and 5) a discussion if and when required. The allocation of marks to the various sections is:

1. Aims, objectives, and hypotheses: 5%
2. Methods and analyses: 45%
3. Results: 20%
4. Graphs: 15%
5. Dicsussion: 15%

### Submission of assignments and exams

A statement such as the one below accompanies every assignment---pay attention, as failing to observe this instruction may result in a loss of marks (i.e. if an assignment remains ungraded because the owner of the material cannot be identified):

Submit a R script wherein you provide answers to Questions 1--9 by no later than 8:00 tomorrow. Label the script as follows (e.g.): **BCB743_AJ_Smit_Assignment_2.R**.

### Late submission of CA

Late assignments will be penalised 10% per day and will not be accepted more than 48 hours late, unless evidence such as a doctor's note, a death certificate, or another documented emergency can be provided. If you know in advance that a submission will be late, please discuss this and seek prior approval. This policy is based on the idea that in order to learn how to translate your human thoughts into computer language (coding) you should be working with them at multiple times each week---ideally daily. Time has been allocated in class for working on assignments and students are expected to continue to work on the assignments outside of class. Successfully completing (and passing) this module requires that you finish assignments based on what we have covered in class by the following class period. Work diligently from the onset so that even if something unexpected happens at the last minute you should already be close to done. This approach also allows rapid feedback to be provided to you, which can only be accomplished by returning assignments quickly and punctually.

## Support

It's expected that some tricky aspects of the module will take time to master, and the best way to master problematic material is to practice, practice some more, and then to ask questions. Trying for 10 minutes and then giving up is not good enough. I'll be more sympathetic to your cause if you can demonstrate having tried for a full day before giving up and asking me. When you ask questions about some challenge, this is the way to do it---explain to me your numerous attempts at trying to solve the problem, and explain how these various attempts have failed. *I will not help you if you have not tried to help yourself first* (maybe with advice from friends). There will be time in class to do this, typically before we embark on a new topic. You are also encouraged to bring up related questions that arise in your own B.Sc. (Hons.) research project.

Should you require more time with me, find out when I am 'free' and set an appointment by sending me a calendar invitation. I am happy to have a personal meeting with you via Zoom, but I prefer face-to-face in my office.

### Help via BCB744 and BCB743 Issues on GitHub

All discussion for the BCB744 and BCB743 workshops will be held in the [Issues](https://github.com/ajsmit/R_courses/issues) of [this repository](https://github.com/ajsmit/R_courses). Please post all content-related questions there, and use email only for personal matters. Note that this is a public repository, so be professional in your writing here (grammar, etc.).

To start a new thread, create a **New issue**. Tag your peers using their handle---@ajsmit, for example---to get their attention.

Once a question has been answered, the issue will be closed, so lots of good answers might end up in closed issues. Don't forget to look there when looking for answers---you can use the **Search** feature on this repository to find answers that might have been offered by the same or similar problem experienced by someone else in the past.

**Guidelines for posting questions:**

- First search existing issues (open or closed) for answers. If the question has already been answered, you're done! If there is an open issue, feel free to contribute to it. Or feel free to open a closed issue if you believe the answer is not satisfactory.
- Give your issue an informative title.
    + Good: "Error: could not find function "ggplot""
    + Bad: "My code does not work!”
Note that you can edit an issue’s title after it's been posted.
- Format your questions nicely using markdown and code formatting. Preview your issue prior to posting.
- As I explained above, your peers and I will more sympathetic to your cause if you can show *all the things you have tried as you, yourself, tried to fix the issue first*.
- Include code and example data so the person trying to help you have something to work with (and which results in the error, perhaps)
- Where appropriate, provide links to specific files, or even lines within them, in the body of your issue. This will help your peers understand your question. Note that only the teaching team will have access to private repos.
- (Optional) Tag someone or some group of people. Start by typing their GitHub username prefixed with the @ symbol. Of course this supposes that each of you have a GitHub account and username.
- Hit **Submit new issue** when you're ready to post.

## Reading

You are **expected to read additional material** in support of the content covered in class and on this website.

A **compulsory** reference is [Numerical Ecology with R](http://adn.biol.umontreal.ca/~numericalecology/numecolR/) by Daniel Borcard, François Gillet and Pierre Legendre. Much of the class' content and many of the examples (and code) that I use have been adapted from this source. It should be considered the 'gold standard' reference for Quantitative Ecology.

A second **highly recommended text** is the book [Tree Diversity Analysis](http://apps.worldagroforestry.org/downloads/Publications/PDFS/b13695.pdf) by Roeland Kindt and Richard Coe.

I can also recommend a few websites with excellent content, such as:

* David Zelený's [Analysis of Community Ecology Data in R](https://www.davidzeleny.net/anadat-r/doku.php)
* Mike Palmer's [Ordination Methods for Ecologists](http://ordination.okstate.edu/)
* [GUide to STatistical Analysis in Microbial Ecology (GUSTA ME)](https://sites.google.com/site/mb3gustame/)

Note that the URLs with links to additional reading that appear with the worked-through example code should **not be seen as optional**. They are there for a reason and should be consulted even though I might not necessarily refer to each of them in class.

Use these materials liberally.

Should you want to download the source code for the BCB743 (and BCB744 website), you may find it on [<i class="fab fa-github"></i> GitHub](https://github.com/ajsmit/R_courses).

## Datasets used in this module

Note that the links provided might not necessarily lead to the **vegan** help page.

|  | Dataset                                                    | Source                                                |
|:-|------------------------------------------------------------|-------------------------------------------------------|
| 1| Vegetation and Environment in Dutch Dune Meadows           | [**vegan**](https://www.davidzeleny.net/anadat-r/doku.php/en:data:dune) |
| 2| Oribatid Mite Data with Explanatory Variables              | [**vegan**](http://adn.biol.umontreal.ca/~numericalecology/data/oribates.html) |    
| 3| The Doubs River Data                                       | [**Numerical Ecology with R**](https://www.davidzeleny.net/anadat-r/doku.php/en:data:doubs) |
| 4| The Barro Colorado Island Tree Counts                      | [**vegan**](https://www.davidzeleny.net/anadat-r/doku.php/en:data:bci) |
| 5| John Bolton, Rob Anderson, and Herre Stegenga's Seaweed Data | [**Smit et al., 2017**](https://www.frontiersin.org/articles/10.3389/fmars.2017.00404/) |
| 6| Serge Mayombo's Diatoms Data                               | [**Mayombo et al., 2019**](https://www.tandfonline.com/doi/abs/10.2989/1814232X.2019.1592778) |
| 7| World Health Organization Sustainable Development Goals Data | [**WHO**](https://www.who.int/data)    


  <!-- ## Function list

  You will encounter the following functions for the first time in this module:

  | Function              | Description                                        |
  |:----------------------|----------------------------------------------------|
  | `adonis2()`           | Permutational Multivariate Analysis of Variance Using Distance Matrices |
  | `anova.betadisper()`  | PERMDIST 2 for Multivariate homogeneity of groups dispersions (variances) |
  | `anova.cca ()`        | Permutation Test for CCA, RDA and CA of Principal Coordinates |
  | `anova.manyglm()`     | Analysis of Deviance for Multivariate Generalized Linear Model Fits for Abundance Data |
  | `beta.pair()`         | Incidence-based Pair-wise Dissimilarities |
  | `betadisper()`        | Multivariate homogeneity of groups dispersions (variances) |
  | `betapart.core()`     | Core Calculations of betapart |
  | `biplot()`            | Biplot of Multivariate Data |
  | `capscale()`          | [Partial] Distance-based Redundancy Analysis |
  | `cca()`               | [Partial] [Constrained] Correspondence Analysis and Redundancy Analysis |
  | `cleanplot.pc()`      | Numerical Ecology in R's PCA Plot |
  | `daisy()`             | Dissimilarity Matrix Calculation |
  | `decostand()`         | Standardization Methods for Community Ecology |
  | `diag()`              | Matrix Diagonals |
  | `diversity()`         | Ecological Diversity Indices |
  | `diversityresult()`   | Alternative Diversity Results |
  | `fviz_cluster()`      | Visualize Clustering Results |
  | `fviz_nbclust()`      | Determining and Visualizing the Optimal Number of Clusters |
  | `fviz_silhouette()`   | Visualize Silhouette Information from Clustering |
  | `geodist()`           | Convert Lon-Lat Coordinates into Vector or Matrix of Geodesic Distances in Metres |
  | `ggcorrplot()`        | Visualization of a Correlation Matrix Using ggplot2 |
  | `goodness()`          | Diagnostic Tools for [Constrained] Ordination (CCA, RDA, DCA, CA, PCA) |
  | `imputePCA()`         | Impute Dataset with PCA |
  | `lowerTriangle()`     | Extract or Replace the Upper/Lower Triangular Portion of a Matrix |
  | `manyglm()`           | Fitting Generalized Linear Models for Multivariate Abundance Data |
  | `meanvar.plot()`      | Construct Mean-Variance Plots for Multivariate Abundance Data |
  | `metaMDS()`           | Nonmetric Multidimensional Scaling with Stable Solution from Random Starts, Axis Scaling and Species Scores |
  | `mvabund()`           | Multivariate Abundance Data Objects |
  | `ordiellipse()`       | Display Groups or Factor Levels in Ordination Diagrams |
  | `ordiplot()`          | Alternative Plot and Identify Functions for Ordination |
  | `ordispider()`        | Display Groups or Factor Levels in Ordination Diagrams |
  | `ordisurf()`          | Fit and Plot Smooth Surfaces of Variables on Ordination |
  | `pam()`               | Partitioning Around Medoids |
  | `permutest()`         | Permutation Test for CCA, RDA and CA of Principal Coordinates |
  | `rda()`               | [Partial] [Constrained] Correspondence Analysis and Redundancy Analysis |
  | `RsquareAdj()`        | Adjusted R-square |
  | `scores()`            | Get Species or Site Scores from an Ordination |
  | `specnumber()`        | Ecological Diversity Indices |
  | `stressplot()`        | Goodness of Fit and Shepard Plot for Nonmetric Multidimensional Scaling |
  | `t()`                 | Matrix Transpose |
  | `vegdist()`           | Dissimilarity Indices for Community Ecologists |
  | `vif.cca()`           | Diagnostic Tools for [Constrained] Ordination (CCA, RDA, DCA, CA, PCA) | -->
