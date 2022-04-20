---
date: "2021-01-01"
draft: false
excerpt: What you need to know upfront.
subtitle: ""
title: "9. Confidence intervals"
links:
  - icon: images
    icon_pack: fas
    name: Confidence Interval Slides
    url: https://ajsmit.github.io/BCB744/Confidence_intervals_slides.html
  - icon: star
    icon_pack: fa
    name: Confidence Interval Exercises
    url: https://ajsmit.github.io/BCB744/Confidence_intervals_exercises.html
weight: 10
---

<!-- # Confidence intervals --->



A confidence interval (CI) tells us within what range we may be certain to find the true mean from which any sample has been taken. If we were to repeatedly sample the same population over and over and calculated a mean every time, the 95% CI indicates the range that 95% of those means would fall into.

## Calculating confidence intervals


```r
Input <- ("
Student  Grade   Teacher   Score  Rating
a        Gr_1    Vladimir  80     7
b        Gr_1    Vladimir  90    10
c        Gr_1    Vladimir 100     9
d        Gr_1    Vladimir  70     5
e        Gr_1    Vladimir  60     4
f        Gr_1    Vladimir  80     8
g        Gr_10   Vladimir  70     6
h        Gr_10   Vladimir  50     5
i        Gr_10   Vladimir  90    10
j        Gr_10   Vladimir  70     8
k        Gr_1    Sadam     80     7
l        Gr_1    Sadam     90     8
m        Gr_1    Sadam     90     8
n        Gr_1    Sadam     80     9
o        Gr_10   Sadam     60     5
p        Gr_10   Sadam     80     9
q        Gr_10   Sadam     70     6
r        Gr_1    Donald   100    10
s        Gr_1    Donald    90    10
t        Gr_1    Donald    80     8
u        Gr_1    Donald    80     7
v        Gr_1    Donald    60     7
w        Gr_10   Donald    60     8
x        Gr_10   Donald    80    10
y        Gr_10   Donald    70     7
z        Gr_10   Donald    70     7
")

data <- read.table(textConnection(Input), header = TRUE)
summary(data)
```

```
R>    Student             Grade             Teacher              Score       
R>  Length:26          Length:26          Length:26          Min.   : 50.00  
R>  Class :character   Class :character   Class :character   1st Qu.: 70.00  
R>  Mode  :character   Mode  :character   Mode  :character   Median : 80.00  
R>                                                           Mean   : 76.92  
R>                                                           3rd Qu.: 87.50  
R>                                                           Max.   :100.00  
R>      Rating      
R>  Min.   : 4.000  
R>  1st Qu.: 7.000  
R>  Median : 8.000  
R>  Mean   : 7.615  
R>  3rd Qu.: 9.000  
R>  Max.   :10.000
```

The package **rcompanion** has a convenient function for estimating the confidence intervals for our sample data. The function is called `groupwiseMean()` and it has a few options (methods) for estimating the confidence intervals, e.g. the 'traditional' way using the *t*-distribution, and a bootstrapping procedure.

Let us produce the confidence intervals using the traditional method for the group means:


```r
library(rcompanion)
# Ungrouped data are indicated with a 1 on the right side of the formula,
# or the group = NULL argument; so, this produces the overall mean
groupwiseMean(Score ~ 1, data = data, conf = 0.95, digits = 3)
```

```
R>    .id  n Mean Conf.level Trad.lower Trad.upper
R> 1 <NA> 26 76.9       0.95       71.7       82.1
```

```r
# One-way data
groupwiseMean(Score ~ Grade, data = data, conf = 0.95, digits = 3)
```

```
R>   Grade  n Mean Conf.level Trad.lower Trad.upper
R> 1  Gr_1 15   82       0.95       75.3       88.7
R> 2 Gr_10 11   70       0.95       62.6       77.4
```

```r
# Two-way data
groupwiseMean(Score ~ Teacher + Grade, data = data, conf = 0.95, digits = 3)
```

```
R>    Teacher Grade n Mean Conf.level Trad.lower Trad.upper
R> 1   Donald  Gr_1 5   82       0.95       63.6      100.0
R> 2   Donald Gr_10 4   70       0.95       57.0       83.0
R> 3    Sadam  Gr_1 4   85       0.95       75.8       94.2
R> 4    Sadam Gr_10 3   70       0.95       45.2       94.8
R> 5 Vladimir  Gr_1 6   80       0.95       65.2       94.8
R> 6 Vladimir Gr_10 4   70       0.95       44.0       96.0
```

Now let us do it through bootstrapping:


```r
groupwiseMean(Score ~ Grade,
              data = data,
              conf = 0.95,
              digits = 3,
              R = 10000,
              boot = TRUE,
              traditional = FALSE,
              normal = FALSE,
              basic = FALSE,
              percentile = FALSE,
              bca = TRUE)
```

```
R>   Grade  n Mean Boot.mean Conf.level Bca.lower Bca.upper
R> 1  Gr_1 15   82        82       0.95      74.7      86.7
R> 2 Gr_10 11   70        70       0.95      62.7      75.5
```

```r
groupwiseMean(Score ~ Teacher + Grade,
              data = data,
              conf = 0.95,
              digits = 3,
              R = 10000,
              boot = TRUE,
              traditional = FALSE,
              normal = FALSE,
              basic = FALSE,
              percentile = FALSE,
              bca = TRUE)
```

```
R>    Teacher Grade n Mean Boot.mean Conf.level Bca.lower Bca.upper
R> 1   Donald  Gr_1 5   82      81.9       0.95      68.0      90.0
R> 2   Donald Gr_10 4   70      70.0       0.95      60.0      75.0
R> 3    Sadam  Gr_1 4   85      85.0       0.95      80.0      87.5
R> 4    Sadam Gr_10 3   70      70.0       0.95      60.0      76.7
R> 5 Vladimir  Gr_1 6   80      80.0       0.95      68.3      88.3
R> 6 Vladimir Gr_10 4   70      69.9       0.95      55.0      80.0
```

These upper and lower limits may then be used easily within a figure.


```r
# Load libraries
library(tidyverse)

# Create dummy data
r_dat <- data.frame(value = rnorm(n = 20, mean = 10, sd = 2),
                    sample = rep("A", 20))

# Create basic plot
ggplot(data = r_dat, aes(x = sample, y = value)) +
  geom_errorbar(aes(ymin = mean(value) - sd(value), ymax = mean(value) + sd(value))) +
  geom_jitter(colour = "firebrick1")
```

<div class="figure">
<img src="/workshops/biostats/chapters/10-confidence_files/figure-html/unnamed-chunk-4-1.png" alt="A very basic figure showing confidence intervals (CI) for a random normal distribution." width="70%" />
<p class="caption">Figure 1: A very basic figure showing confidence intervals (CI) for a random normal distribution.</p>
</div>

## CI of compared means

AS stated above, we may also use CI to investigate the difference in means between two or more sample sets of data. We have already seen this in the ANOVA Chapter, but we shall look at it again here with our now expanded understanding of the concept.


```r
# First calculate ANOVA of seapl length of different iris species
iris_aov <- aov(Sepal.Length ~ Species, data = iris)

# Then run a Tukey test
iris_Tukey <- TukeyHSD(iris_aov)

# Lastly use base R to quickly plot the results
plot(iris_Tukey)
```

<div class="figure">
<img src="/workshops/biostats/chapters/10-confidence_files/figure-html/unnamed-chunk-5-1.png" alt="Results of a post-hoc Tukey test showing the confidence interval for the effect size between each group." width="70%" />
<p class="caption">Figure 2: Results of a post-hoc Tukey test showing the confidence interval for the effect size between each group.</p>
</div>

> **Task 1:** Judging from the figure above, which species have significantly different sepal lengths?

## Harrell plots

The most complete use of CI that we have seen to date is the Harrell plot. This type of figure shows the distributions of each sample set in the data as boxplots in a lower panel. In the panel above those boxplots it then lays out the results of a post-hoc Tukey test. This very cleanly shows both the raw data as well as high level statistical results of the comparisons of those data. Thanks to the magic of the Internet we may create these figures with a single line of code. This does however require that we load several new libraries.


```r
# The easy creation of these figures has quite a few dependencies
library(lsmeans)
library(Hmisc)
library(broom)
library(car)
library(data.table)
library(cowplot)
source("../../../../static/R/fit_model.R")
source("../../../../static/R/make_formula_str.R")
source("../../../../static/R/HarrellPlot.R")

# Load data
ecklonia <- read.csv("../../../../static/data/ecklonia.csv")

# Create Harrell Plot
HarrellPlot(x = "site", y = "stipe_length", data = ecklonia, short = T)[1]
```

```
R> $gg
```

<div class="figure">
<img src="/workshops/biostats/chapters/10-confidence_files/figure-html/unnamed-chunk-6-1.png" alt="Harrell plot showing the distributions of stipe lengths (cm) of the kelp _Ecklonia maxima_ at two different sites in the bottom panel. The top panel shows the confidence interval of the effect of the difference between these two sample sets based on a post-hoc Tukey test." width="70%" />
<p class="caption">Figure 3: Harrell plot showing the distributions of stipe lengths (cm) of the kelp _Ecklonia maxima_ at two different sites in the bottom panel. The top panel shows the confidence interval of the effect of the difference between these two sample sets based on a post-hoc Tukey test.</p>
</div>

> **Task 2:** There are a lot of settings for `HarrellPlot()`, what do some of them do?

The above figure shows that the CI of the difference between stipe lengths (cm) at the two sites does not cross 0. This means that there is a significant difference between these two sample sets. But let's run a statistical test anyway to check the results.


```r
# assumptions
ecklonia %>% 
  group_by(site) %>% 
  summarise(stipe_length_var = var(stipe_length),
            stipe_length_Norm = as.numeric(shapiro.test(stipe_length)[2]))
```

```
R> # A tibble: 2 × 3
R>   site           stipe_length_var stipe_length_Norm
R>   <chr>                     <dbl>             <dbl>
R> 1 Batsata Rock             14683.            0.0128
R> 2 Boulders Beach            4970.            0.0589
```

```r
# We fail both assumptions...

# non-parametric test
wilcox.test(stipe_length ~ site, data = ecklonia)
```

```
R> 
R> 	Wilcoxon rank sum test with continuity correction
R> 
R> data:  stipe_length by site
R> W = 146, p-value = 0.001752
R> alternative hypothesis: true location shift is not equal to 0
```

The results of our Wilcox rank sum test, unsurprisingly, support the output of `HarrelPlot()`.
