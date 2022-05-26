---
date: "2021-01-01"
draft: false
excerpt: null
links:
  - icon: images
    icon_pack: fas
    name: Dissimilarities Slides
    url: /pdf/BCB743/BCB743_05_dissimilarity.pdf
  - icon: file-export
    icon_pack: fa
    name: Doubs.RData
    url: /BCB743/NEwR-2ed_code_data/NEwR2-Data/Doubs.RData
subtitle: ""
title: "5. Species Dissimilarities"
weight: 7
---

<!--- # Topic 5: Species dissimilarities --->

We have already covered all the necessary theory in Topic 3 - Biodiversity. The dissimilarity matrices that capture α-diversity and the contemporary measures of β-diversity are in fact *the same species dissimilarity matrices I refer to here under species dissimilarities*, and on which we will continue to rely on in the subsequent topics as input to many of the ordination techniques.

So, refer back to [Topic 3 - Biodiversity](https://ajsmit.netlify.app/workshops/quantecol/chapters/02-biodiversity/) and remind yourselves what that's all about.

To test your understanding of this important topic, please address the following questions and submit next week Monday at 17:00 via GitHub.

### Assignment 2 Questions

Using the Doubs species data in [Numerical Ecology with R](http://adn.biol.umontreal.ca/~numericalecology/numecolR/):

> **Question 1:** Look at the dataset and explain its structure in words.
>
> **Question 2:** Would we use Bray-Curtis or Jaccard dissimilarities?
>
> **Question 3:** Apply the calculation.
>
> **Question 4:** Explain the meaning of the results in broad terms.
>
> **Question 5:** Examine it more closely: what general pattern comes out?
>
> **Question 6:** Plot this pattern (hint, it is best seen in the 1st column of the dissimilarity matrix).
>
> **Question 7:** What explanation can you offer for this pattern?
>
> **Question 8:** Using the `decostand()` function, create presence/absence data, and apply the appropriate `vegdist()` function to obtain a suitable dissimilarity matrix.
>
> **Question 9:** Create another plot and explain the pattern.

Submit a R script wherein you provide answers to Questions 1--9 by no later than 8:00 tomorrow. Label the script as follows: **`BCB743_<Name>_<Surname>_Assignment_2.R`**, e.g. **`BCB743_AJ_Smit_Assignment_2.R`**.
