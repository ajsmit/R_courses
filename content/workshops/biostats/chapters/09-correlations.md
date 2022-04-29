---
date: "2021-01-01"
draft: false
excerpt: What you need to know upfront.
subtitle: ""
title: "8. Correlation"
links:
  - icon: images
    icon_pack: fas
    name: Correlations Slides (1)
    url: https://ajsmit.github.io/BCB744/Correlations_slides--1-.html
  - icon: images
    icon_pack: fas
    name: Correlations Slides (2)
    url: https://ajsmit.github.io/BCB744/Correlations_slides--2-.html
  - icon: star
    icon_pack: fa
    name: Correlations Exercises
    url: https://ajsmit.github.io/BCB744/Correlations_exercises.html
weight: 9
---

<!--- # Correlation --->

<div class="panelset">
  <div class="panel">
    <div class="panel-name">Correlation Slides 1</div>
    <iframe width="750" height="422"  src="https://ajsmit.github.io/BCB744/Correlations_slides--1-.html" frameborder="0" allowfullscreen></iframe>
  </div>
  <div class="panel">
    <div class="panel-name">Correlation Slides 2</div>
    <iframe width="750" height="422" src="https://ajsmit.github.io/BCB744/Correlations_slides--2-.html" frameborder="0" allowfullscreen></iframe>
  </div>
</div>



A correlation is performed when we want to investigate the potential *association* between two continuous quantitative variables, or between some ordinal variables. We assume that the association is linear, like in a linear regression, and that one variable increases or decreases by a constant amount for a corresponding unit increase or decrease in the other variable. This does not suggest that one variable explains the other -- that is the purpose of regression, as seen in the [previous](https://ajsmit.github.io/R_Stats_Official/08-regressions.html) Chapter. Like all statistical tests, correlation requires a series of assumptions as well:

-   pair-wise data
-   absence of outliers
-   linearity
-   normality of distribution
-   homoscedasticity
-   level (type) of measurement
-   continuous data (Pearson correlation)
-   ordinal data (Spearman correlation)

The degree of association is measured by a correlation coefficient, denoted by `\(r\)` (note, in a regression we use the `\(r^{2}\)`, which must not be confused for `\(r\)`). The `\(r\)` statistic is sometimes called the correlation coefficient; it is a measure of linear association. The value for `\(r\)` varies from -1 to 1, with 0 indicating that there is absolutely no association, 1 showing a perfect positive association, and -1 a perfect inverse correlation.

## Pearson correlation

In order to investigate correlations in biological data lets load the `ecklonia` dataset.


```r
# Load libraries
library(tidyverse)
library(ggpubr)
library(corrplot)

# Load data
ecklonia <- read.csv("../../../../static/data/ecklonia.csv")
```

We will also create a subsetted version of our data by removing all of the categorical variables. If we have a dataframe where each column represents pair-wise continuous/ordinal measurements with all of the other columns we may very quickly and easily perform a much wider range of correlation analyses.


```r
ecklonia_sub <- ecklonia %>%
  select(-species, - site, - ID)
```

When the values we are comparing are continuous, we may use a Pearson test. This is the default and so requires little work on our end. The resulting statistic from this test is known as the Pearson correlation coefficient:


```r
# Perform correlation analysis on two specific variables
# Note that we do not need the final two arguments in this function to be stated
# as they are the defaut settings.
# They are only shown here to illustrate that they exist.
cor.test(x = ecklonia$stipe_length, ecklonia$frond_length,
         use = "everything", method = "pearson")
```

```
R> 
R> 	Pearson's product-moment correlation
R> 
R> data:  ecklonia$stipe_length and ecklonia$frond_length
R> t = 4.2182, df = 24, p-value = 0.0003032
R> alternative hypothesis: true correlation is not equal to 0
R> 95 percent confidence interval:
R>  0.3548169 0.8300525
R> sample estimates:
R>       cor 
R> 0.6524911
```

Above we have tested the correlation between the length of *Ecklonia maxima* stipes and the length of their fronds. A perfect positive (negative) relationship would produce a value of 1 (-1), whereas no relationship would produce a value of 0. The result above, `cor = 0.65` is relatively strong.

As is the case with everything else we have learned thus far, a good visualisation can go a long way to help us understand what the statistics are doing. Below we visualise the stipe length to frond length relationship.


```r
# Calculate Pearson r beforehand for plotting
r_print <- paste0("r = ",
                  round(cor(x = ecklonia$stipe_length, ecklonia$frond_length),2))

# Then create a single panel showing one correlation
ggplot(data = ecklonia, aes(x = stipe_length, y = frond_length)) +
  geom_smooth(method = "lm", colour = "grey90", se = F) +
  geom_point(colour = "mediumorchid4") +
  geom_label(x = 300, y = 240, label = r_print) +
  labs(x = "Stipe length (cm)", y = "Frond length (cm)")
```

<div class="figure">
<img src="/workshops/biostats/chapters/09-correlations_files/figure-html/corr-plot1-1.png" alt="Scatterplot showing relationship between _Ecklonia maxima_ stipe length (cm) and frond length (cm). The correlation coefficient (Pearson r) is shown in the top left corner. Note that the grey line running through the middle is a fitted linear model and is not generating the correlation value. Rather it is included to help visually demonstrate the strength of the relationship." width="70%" />
<p class="caption">Figure 1: Scatterplot showing relationship between _Ecklonia maxima_ stipe length (cm) and frond length (cm). The correlation coefficient (Pearson r) is shown in the top left corner. Note that the grey line running through the middle is a fitted linear model and is not generating the correlation value. Rather it is included to help visually demonstrate the strength of the relationship.</p>
</div>

Just by eye-balling this scatterplot it should be clear that these data tend to increase at a roughly similar rate. Our Pearson r value is an indication of what that is.

Should our dataset contain multiple variables, as `ecklonia` does, we may investigate all of the correlations simultaneously. Remember that in order to do so we want to ensure that we may perform the same test on each of our paired variables. In this case we will use `ecklonia_sub` as we know that it contains only continuous data and so are appropriate for use with a Pearson test. By default R will use all of the data we give it and perform a Pearson test so we do not need to specify any further arguments. Note however that this will only output the correlation coefficients, and does not produce a full test of each correlation. This will however be useful for us to have just now.


```r
ecklonia_pearson <- round(cor(ecklonia_sub), 2)
ecklonia_pearson
```

```
R>                      stipe_length stipe_diameter frond_length digits
R> stipe_length                 1.00           0.59         0.65   0.24
R> stipe_diameter               0.59           1.00         0.39   0.24
R> frond_length                 0.65           0.39         1.00   0.36
R> digits                       0.24           0.24         0.36   1.00
R> primary_blade_width          0.34           0.83         0.28   0.14
R> primary_blade_length         0.13           0.32        -0.02   0.10
R> stipe_mass                   0.58           0.82         0.39   0.07
R> frond_mass                   0.51           0.51         0.57   0.28
R> epiphyte_length              0.61           0.54         0.61   0.05
R>                      primary_blade_width primary_blade_length stipe_mass
R> stipe_length                        0.34                 0.13       0.58
R> stipe_diameter                      0.83                 0.32       0.82
R> frond_length                        0.28                -0.02       0.39
R> digits                              0.14                 0.10       0.07
R> primary_blade_width                 1.00                 0.34       0.83
R> primary_blade_length                0.34                 1.00       0.16
R> stipe_mass                          0.83                 0.16       1.00
R> frond_mass                          0.36                 0.15       0.47
R> epiphyte_length                     0.41                 0.26       0.51
R>                      frond_mass epiphyte_length
R> stipe_length               0.51            0.61
R> stipe_diameter             0.51            0.54
R> frond_length               0.57            0.61
R> digits                     0.28            0.05
R> primary_blade_width        0.36            0.41
R> primary_blade_length       0.15            0.26
R> stipe_mass                 0.47            0.51
R> frond_mass                 1.00            0.44
R> epiphyte_length            0.44            1.00
```

```r
write.csv(ecklonia_pearson, "../../../../static/data/ecklonia_pearson.csv")
```

The output, called a pairwise correlation matrix, can be seen in Excel where it looks like this:

![A correlation matrix showing Pearson's `\(r\)`.](Resources/correlation_matrix.png){width="95%"}

> **Task 1:** What does the outcome of this test show? Please describe in detail how to interpret the output, and discuss the interesting characteristics of the correlation matrix.

How would be visualise this matrix of correlations? It is relatively straightforward to quickly plot correlation results for all of our variables in one go. In order to show which variables associate most with which other variables all at once, without creating chaos, we will create what is known as a heat map. This visualisation uses a range of colours, usually blue to red, to demonstrate where more of something is. In this case, we use it to show where more correlation is occurring between morphometric properties of the kelp *Ecklonia maxima*.


```r
corrplot(ecklonia_pearson, method = "circle")
```

<div class="figure">
<img src="/workshops/biostats/chapters/09-correlations_files/figure-html/corr-plot2-1.png" alt="Correlation plot showing the strength of all correlations between all variables as a scale from red (negative) to blue (positive)." width="70%" />
<p class="caption">Figure 2: Correlation plot showing the strength of all correlations between all variables as a scale from red (negative) to blue (positive).</p>
</div>

> **Task 2:** What does the series of dark blue circles through the middle of this plot mean?

> **Task 3:** Why does the scale bar on the right show the colour red?

> **Task 4:** Which morphometric properties correlate best/worst?

> **Task 5:** Browse the internet and find two or three other ways (hint: find other packages, for example) to visualise pairwise correlations, and create corresponding figures for the *Ecklonia* data.

## Spearman rank correlation

When the data we want to compare are not continuous, but rather ordinal, we will need to use Spearman's rank correlation. This is not often a test one uses in biology because we tend to want to compare continuous data within categories. In the code below we will add a column of ordinal data to our `ecklonia` data to so that we may look at this test.


```r
# Create ordinal data
ecklonia$length <- as.numeric(cut((ecklonia$stipe_length + ecklonia$frond_length), breaks = 3))

# What does this new column look like?
head(select(ecklonia, c(species, site, stipe_length, frond_length, length)), 10)
```

```
R>    species           site stipe_length frond_length length
R> 1   maxima Boulders Beach          456          116      1
R> 2   maxima Boulders Beach          477          141      2
R> 3   maxima Boulders Beach          427          144      1
R> 4   maxima Boulders Beach          347          127      1
R> 5   maxima Boulders Beach          470          160      2
R> 6   maxima Boulders Beach          478          181      2
R> 7   maxima Boulders Beach          472          174      2
R> 8   maxima Boulders Beach          459           95      1
R> 9   maxima Boulders Beach          397           87      1
R> 10  maxima Boulders Beach          541          127      2
```

> **Task 6:** Explain in writing what the code above does. Focus specifically on the line of code with the `cut()` function in it.

Now let us correlate the new `length` variable with any one of the other variables:


```r
cor.test(ecklonia$length, ecklonia$digits, method = "spearman")
```

```
R> 
R> 	Spearman's rank correlation rho
R> 
R> data:  ecklonia$length and ecklonia$digits
R> S = 1930, p-value = 0.08906
R> alternative hypothesis: true rho is not equal to 0
R> sample estimates:
R>       rho 
R> 0.3401765
```

Note that unlike Pearson's correlation where the correlation coefficient is denoted by `\(r\)`, a Spearman correlation return the `\(\rho\)` coefficient. The interpretation is the same is for Pearson's correlation coefficient, however.

## Kendall rank correlation

This test will work for both continuous and ordinal data. A sort of dealers choice of correlation tests. It's main purpose is to allow us to perform a correlation on non-normally distributed data. Let's look at the normality of our `ecklonia` variables and pull out those that are not normal in order to see how the results of this test may differ from our Pearson tests.


```r
ecklonia_norm <- ecklonia_sub %>%
  gather(key = "variable") %>%
  group_by(variable) %>%
  summarise(variable_norm = as.numeric(shapiro.test(value)[2]))
ecklonia_norm
```

```
R> # A tibble: 9 × 2
R>   variable             variable_norm
R>   <chr>                        <dbl>
R> 1 digits                     0.0671 
R> 2 epiphyte_length            0.626  
R> 3 frond_length               0.202  
R> 4 frond_mass                 0.277  
R> 5 primary_blade_length       0.00393
R> 6 primary_blade_width        0.314  
R> 7 stipe_diameter             0.170  
R> 8 stipe_length               0.213  
R> 9 stipe_mass                 0.817
```

> **Task 7:** Explain in written langauge what each line of the code, above, does.

From this analysis we may see that the values for primary blade length are not normally distributed. In order to make up for this violation of our assumption of normality we may use the Kendall test.


```r
cor.test(ecklonia$primary_blade_length, ecklonia$primary_blade_width, method = "kendall")
```

```
R> 
R> 	Kendall's rank correlation tau
R> 
R> data:  ecklonia$primary_blade_length and ecklonia$primary_blade_width
R> z = 2.3601, p-value = 0.01827
R> alternative hypothesis: true tau is not equal to 0
R> sample estimates:
R>       tau 
R> 0.3426171
```

Here the correlation coefficient is called Kendall's `\(\tau\)` but it is interpreted as we would Pearson's.
