---
date: "2021-01-01"
draft: false
excerpt: null
subtitle: ""
title: "16. Dates"
weight: 16
---



This script covers some of the more common issues we may face while dealing with dates.


```r
## Load libraries
library(tidyverse)
library(lubridate)
library(zoo)

## Load data
sad_dates <- read.csv("../../../../static/data/sad_dates.csv")
```

## Date details

Look at strip time format for guidance


```r
?strptime
```

Check the local time zone


```r
Sys.timezone(location = TRUE)
```

```
R> [1] "Africa/Johannesburg"
```

## Creating daily dates

Create date columns out of the mangled date data we have loaded.


```r
## Create good date column
new_dates <- sad_dates %>%
  mutate(new_good = as.Date(good))

## Correct bad date column
new_dates <- new_dates %>%
  mutate(new_bad = as.Date(bad, format = "%m/%d/%y"))

## Correct ugly date column
new_dates <- new_dates %>%
  mutate(new_ugly = seq(as.Date("1998-01-13"), as.Date("1998-01-21"), by = "day"))
```

## Creating hourly dates

If we want to create date values out of data that have hourly values (or smaller), we must create 'POSIXct' valus because 'Date' values may not have a finer temporal resolution than one day.


```r
## Correcting good time stamps with hours
new_dates <- new_dates %>%
  mutate(new_good_hours = as.POSIXct(good_hours, tz = "Africa/Mbabane"))

## Correcting bad time stamps with hours
new_dates <- new_dates %>%
  mutate(new_bad_hours = as.POSIXct(bad_hours, format = "%Y-%m-%d %I:%M:%S %p", tz = "Africa/Mbabane"))

## Correcting bad time stamps with hours
new_dates <- new_dates %>%
  mutate(new_ugly_hours = seq(as.POSIXct("1998-01-13 09:00:00", tz = "Africa/Mbabane"),
                              as.POSIXct("1998-01-13 17:00:00", tz = "Africa/Mbabane"), by = "hour"))
```

But shouldn't there be a function that loads dates correctly?

## Importing dates in one step

Why yes, yes there is. `read_csv()` is the way to go.


```r
smart_dates <- read_csv("../../../../static/data/sad_dates.csv")
```

But why does it matter that we correct the values to dates? For starters, it affects the way our plots look/work. Let's create some random numbers for plotting and see how these compare against our date values when we create figures.


```r
## Generate random number
smart_dates$numbers <- rnorm(9, 2, 10)

## Scatterplot with correct dates
ggplot(smart_dates, aes(x = good, y = numbers)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)
```

<img src="/workshops/intro_r/chapters/17-dates_files/figure-html/dates-deeper-1-1.png" width="672" />

```r
## Scatterplot with incorrect dates
ggplot(smart_dates, aes(x = bad, y = numbers)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)
```

<img src="/workshops/intro_r/chapters/17-dates_files/figure-html/dates-deeper-1-2.png" width="672" />

```r
## OR
ggplot(smart_dates, aes(x = ugly, y = numbers)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)
```

<img src="/workshops/intro_r/chapters/17-dates_files/figure-html/dates-deeper-1-3.png" width="672" />

If the dates are formatted correctly it also allows us to do schnazy things with the data.


```r
smart_dates$good[4]+32
```

```
R> [1] "1998-02-17"
```

```r
smart_dates$good[9]-smart_dates$good[3]
```

```
R> Time difference of 6 days
```

```r
as.Date(smart_dates$good[9]:smart_dates$good[3])
```

```
R> [1] "1998-01-21" "1998-01-20" "1998-01-19" "1998-01-18" "1998-01-17"
R> [6] "1998-01-16" "1998-01-15"
```

```r
smart_dates$good[9]-10247
```

```
R> [1] "1970-01-01"
```
