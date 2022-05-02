---
date: "2021-01-01"
draft: false
excerpt: null
subtitle: ""
title: "15. Base R primer"
weight: 15
---

Please note that the following chapter departs from the syntax employed by the **tidyverse**, as utilised throughout this workshop, in favour of the base R syntax. This may be changed in the future, but has been left for now in order to better highlight the fundamental machinations of the R language, upon which the **tidyverse** is based.

## Dataframes

The 'workhorse' data-containing structures you will use extensively in R are called *dataframes*. In fact, almost all of the work you do in R will be done directly with dataframes or will involve converting data into a dataframe. A dataframe is used for storing data as tables, with a table defined by a collection of vectors of similar or dissimilar data types but all of the same length. Don't worry if any of those terms are unknown or daunting. We will cover them in detail just now. But first we need to see what a dataframe looks like in order to provide context for all of the parts they consist of. After we have covered all of the terms used for data in R we will learn some methods of creating our own dataframes.

To load a dataframe into R is quite simple when the data are already in the '.Rdata' format. Let's load a small dataframe that was prepared for this class and see. The file extension '.Rdata' does not mean necessarily that the data are in a dataframe (table) format. This file extensions is actually a form of data compression unique to R and could hold anything from a single letter to the results of a complex species distribution model. For the following line of code to work we must make sure we are in the 'Intro_R_Workshop' project.


```r
load("../../../../static/data/intro_data.Rdata")
```

Upon loading the data frame we see in the **Environment** tab that there is a little blue circle next to our object. If we click on that we see a summary of each column. First it says what the data type for that column is and then shows the first several values therein.

If you click on the 'intro_data' word in your **Environment** tab it will open it in your **Source Editor** and allow you to click on the columns to organise them by ascending or descending order. Note that this does not change the dataframe, it is only a visual aid.

## Basic data types

There are several basic R data types that you frequently encounter in daily work. These include but are not limited to *numeric*, *integer*, *logical*, *character*, *factor* and *date* classes. All of these data types are present in our 'intro_data' dataframe for us to see practical examples. We will create our own examples as we go along.

### Numeric

Numeric data with decimal values are called *numeric* in R. It is the default computational data type. If we look at our data frame we see that the following columns are numeric: lon, lat, NA.perc, mean, min and max. What sort of data are these?

Let's create our own numeric object by assigning a decimal value to a variable `x` as follows, `x` will be of numeric type:


```r
x <- 1.2 # assign 1.2 to x
x # print the value of x
```

```
## [1] 1.2
```

```r
class(x) # what is the class of x?
```

```
## [1] "numeric"
```

Furthermore, even if we assign a number to a variable `k` that doesn't have a decimal place, it is still being saved as a numeric value:


```r
k <- 1
k
```

```
## [1] 1
```

```r
class(k)
```

```
## [1] "numeric"
```

If we want to really be certain that `k` is or is not an integer we use `is.integer()`:


```r
is.integer(k) # is k an integer?
```

```
## [1] FALSE
```

### Integer

An *integer* in R is a numeric value that does not have a decimal place. It may only be a round whole number. Integers are often used for count data and when converting qualitative data to numbers for data analysis. In our dataframe we may see that we have two integer columns: depth and length. Why are these integers?

In order to create your own integer variable(s) in R, we use the `as.integer()`. We can be assured that `y` is indeed an integer by checking with `is.integer()`:


```r
y <- as.integer(13)
y
```

```
## [1] 13
```

```r
class(y)
```

```
## [1] "integer"
```

```r
is.integer(y) # is it an integer?
```

```
## [1] TRUE
```

If we really have to, we can coerce a numeric value into an integer with the same `as.integer()` function:


```r
z <- as.integer(pi)
z
```

```
## [1] 3
```

```r
class(z)
```

```
## [1] "integer"
```

```r
is.integer(z) # is it an integer?
```

```
## [1] TRUE
```

### Logical

There are several *logic* values in R. We are mostly going to be concerned with the two main values we will be encountering: TRUE and FALSE. Note that all letters must be upper case. In our dataframe we see that only the 'thermo' column is logical. This column tells us whether or not the data were collected with a thermometer or not.

Logical values (`TRUE` or `FALSE`) are often created via comparison between variables:


```r
x <- 1; y <- 2 # sample values
z <- x > y
z
```

```
## [1] FALSE
```

```r
class(z)
```

```
## [1] "logical"
```

In order to perform logical operations we mostly use `&` (and), `|` (or), and `!` (negation):


```r
u <- TRUE; v <- FALSE; w <- TRUE; x <- FALSE
u & v
```

```
## [1] FALSE
```

```r
u & w
```

```
## [1] TRUE
```

```r
v & x
```

```
## [1] FALSE
```

```r
u | v
```

```
## [1] TRUE
```

```r
!u
```

```
## [1] FALSE
```

Although these logical operators can be immensely useful in more advanced R programming, we will not go into too much detail in this introductory course. For more information on the logical operators, see the R help material:


```r
help("&")
```

One final thing to note about logic in R is that it can be useful to perform arithmetic on logical values. `TRUE` has the value 1, while `FALSE` has value 0:


```r
as.integer(TRUE) # the numeric value of TRUE
```

```
## [1] 1
```

```r
as.integer(FALSE) # the numeric value of FALSE
```

```
## [1] 0
```

```r
sum(as.integer(intro_data$thermo))
```

```
## [1] 10
```

What is this telling us?

### Character

In our dataframe we see that only the 'src' column has the *character* values. This column is showing us which government body etc. collected the data in that row. At the use of a very familiar word, character, one may think this data type must be the most straightforward. This is not necessarily so as character values are used to represent *string* values in R. Because computers do not understand text the same way we do, they tend to handle this information differently. This allows us to do some pretty wild stuff with character values, but we won't be getting into that in this course as it quickly becomes very technical and generally speaking isn't very useful in a daily application.

If however we wanted to convert an object to a character value we would do so with `as.character()`:


```r
d <- as.character(pi)
class(d)
```

```
## [1] "character"
```

This can be useful if you have data that you want to be characters, but for one reason or another R has decided to make it a different data type.

If you want to join two character objects they can be concatenated with the `paste()` function:


```r
a <- "fluffy"; b <- "bunny"
paste(a, b)
```

```
## [1] "fluffy bunny"
```

```r
paste(a, b, sep = "-")
```

```
## [1] "fluffy-bunny"
```

More functions for string manipulation can be found in the R documentation --- type `help("sub")` at the command prompt. You may also wish to install Hadley Wickham's nifty **`stringr`** package for more cool ways to work with character strings.

### Factor

*Factor* values are somewhat difficult to explain and often even more difficult to understand. Factor values appear the same as character values when we look at them in a spreadsheet. But they are not the same. This will lead to much wailing and gnashing of teeth. So why then do factors exist and why would we use them? Factors allow us to numerically order names non-alphabetically, for example. This then allows one to order a list of research sites in geographical order. 

We will see many examples of factors during this course but for now look at the 'site' column in our dataframe. If we click on this column a couple of times we see that it reorders all the data based on ascending or descending order of the sites. But that order is not alphabetical, it is based on the *levels* within the factor column. Each factor value in a column is assigned a level integer value (e.g. 1, 2, 3, 4, etc.). If multiple values in a factor column are the same, they receive the same level value as well.

If we want to see what the levels within a factor column are we use `levels()`:


```r
levels(intro_data$site)
```

```
##  [1] "Port Nolloth"  "St Helena Bay" "Saldanha Bay"  "Muizenberg"   
##  [5] "Cape Agulhas"  "Mossel Bay"    "Tsitsikamma"   "Humewood"     
##  [9] "Hamburg"       "Durban"        "Richards Bay"  "Sodwana"
```

We will discuss in the next session what that `$` means. But for now, are you able to see what the pattern is in the levels of the site listing?

If we want to create our own factors we will use `as.factor()`:


```r
f <- as.factor(letters[1:5])
levels(f)
```

```
## [1] "a" "b" "c" "d" "e"
```

And if we want to change the order of our factor levels we use `factor()`:


```r
f <- factor(f, levels = c("b", "a", "c", "e", "d"))
levels(f)
```

```
## [1] "b" "a" "c" "e" "d"
```

Another reason for using factors to re-order our data, as we shall see tomorrow, is that this allows us to control the order in which values are plotted.

### Dates

See the next chapter about dates.

![Dates.](/collection/intro_r/chapters/16-base_r_files/Dried-dates.webp){width=80%}

## Vectors

A vector, by definition, is a one-dimensional sequence of data elements of the same basic type (class). Members in a vector are officially called components. Basically, a vector is a column. Indeed, a dataframe is nothing more than a collection of vectors stuck together. If we wanted to create a vector from our dataframe we would do this:


```r
lonely_vector <- intro_data$NA.perc
```

Notice that we may not click on the object `lonely_vector` in our **Environment** tab. This is because it is no longer two-dimensional. If we want to visualise the data we need to enter it into the console or run it from our script:


```r
lonely_vector
```

```
##  [1]  6 41 32  4 28 26  8  3  6 67 38 16
```

Let's create some vectors of our own:


```r
primes1 <- c(3, 5, 7)
primes1
```

```
## [1] 3 5 7
```

```r
class(primes1)
```

```
## [1] "numeric"
```

```r
p1 <- pi
p2 <- 5
p3 <- 7

primes2 <- c(p1, p2, p3)
primes2
```

```
## [1] 3.141593 5.000000 7.000000
```

```r
class(primes2)
```

```
## [1] "numeric"
```

```r
is.numeric(primes2)
```

```
## [1] TRUE
```

```r
is.integer(primes2) # integers coerced into floating point numbers
```

```
## [1] FALSE
```

We can also have vectors of logical values or character strings, and we can use the function `length()` to see how many components each has:


```r
tf <- c(TRUE, FALSE, TRUE, FALSE, FALSE)
tf
```

```
## [1]  TRUE FALSE  TRUE FALSE FALSE
```

```r
length(tf)
```

```
## [1] 5
```

```r
cs <- c("Mary", "has", "a", "silly", "lamb")
cs
```

```
## [1] "Mary"  "has"   "a"     "silly" "lamb"
```

```r
length(cs)
```

```
## [1] 5
```

Of course one would seldom enter data into R using the `c()` (combine) function, but it is useful for short calculations. More often than not one would import data from Excel (urgh!) or something more reputable. The kinds of data one can read into R are remarkable. We will get to that later on.

We can also combine vectors in many ways, and the simplest way is the append one after the other:


```r
primes12 <- c(primes1, primes2)
primes12
```

```
## [1] 3.000000 5.000000 7.000000 3.141593 5.000000 7.000000
```

```r
nonSense <- c(primes12, cs)
nonSense
```

```
##  [1] "3"                "5"                "7"                "3.14159265358979"
##  [5] "5"                "7"                "Mary"             "has"             
##  [9] "a"                "silly"            "lamb"
```

```r
class(nonSense)
```

```
## [1] "character"
```

In the code fragment above, notice how the numeric values are being coerced into character strings when the two vectors of dissimilar class are combined. This is necessary so as to maintain the same primitive data type for members in the same vector.

## Vector indices

What if we want to extract one or a few components from the vector? Easy... We retrieve values in a vector by declaring an index inside a single square bracket `[]` operator. For example, the following shows how to retrieve a vector component. Since the vector index is 1-based (*i.e.* the first component in a vector is numbered `1`), we use the index position `7` for retrieving the seventh member:


```r
nonSense[7] # find the seventh component in the vector
```

```
## [1] "Mary"
```

```r
# or combine them in interesting ways...
paste(nonSense[7], nonSense[8], nonSense[4], nonSense[10], "bunnies", sep = " ")
```

```
## [1] "Mary has 3.14159265358979 silly bunnies"
```

If the index given is negative, it will remove the value whose position has the same absolute value as the negative index. For example, the following creates a vector slice with the third member removed. However, if an index is out-of-range, a missing value will be reported via the symbol `NA`:


```r
a <- c(2, 6, 3, 8, 13)
a
```

```
## [1]  2  6  3  8 13
```

```r
a[-3]
```

```
## [1]  2  6  8 13
```

```r
a[10]
```

```
## [1] NA
```

## Vector creation

R has many funky ways of creating vectors. This process is important to understand because we will need to build on it to create our own dataframes. Here are some examples of vector creation:


```r
seq(1:10) # assign them to a variable if you want to...
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
seq(from = 0, to = 100, by = 10)
```

```
##  [1]   0  10  20  30  40  50  60  70  80  90 100
```

```r
seq(0, 100, len = 10) # one may omit from and to
```

```
##  [1]   0.00000  11.11111  22.22222  33.33333  44.44444  55.55556  66.66667
##  [8]  77.77778  88.88889 100.00000
```

```r
seq(1, 9, by = pi)
```

```
## [1] 1.000000 4.141593 7.283185
```

```r
rep(13, times = 13)
```

```
##  [1] 13 13 13 13 13 13 13 13 13 13 13 13 13
```

```r
rep(seq(1:5), times = 6)
```

```
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
```

```r
a <- rnorm(20, mean = 13, sd = 0.13) # random numbers with known mean and sd
rep(a, 5) # one may omit the times argument
```

```
##   [1] 12.99592 13.03072 13.00699 12.77644 13.09503 13.22587 12.96334 13.05256
##   [9] 13.00573 12.93340 13.04873 13.03852 13.06281 13.09638 12.98825 13.14610
##  [17] 13.02972 12.86721 12.99829 13.06169 12.99592 13.03072 13.00699 12.77644
##  [25] 13.09503 13.22587 12.96334 13.05256 13.00573 12.93340 13.04873 13.03852
##  [33] 13.06281 13.09638 12.98825 13.14610 13.02972 12.86721 12.99829 13.06169
##  [41] 12.99592 13.03072 13.00699 12.77644 13.09503 13.22587 12.96334 13.05256
##  [49] 13.00573 12.93340 13.04873 13.03852 13.06281 13.09638 12.98825 13.14610
##  [57] 13.02972 12.86721 12.99829 13.06169 12.99592 13.03072 13.00699 12.77644
##  [65] 13.09503 13.22587 12.96334 13.05256 13.00573 12.93340 13.04873 13.03852
##  [73] 13.06281 13.09638 12.98825 13.14610 13.02972 12.86721 12.99829 13.06169
##  [81] 12.99592 13.03072 13.00699 12.77644 13.09503 13.22587 12.96334 13.05256
##  [89] 13.00573 12.93340 13.04873 13.03852 13.06281 13.09638 12.98825 13.14610
##  [97] 13.02972 12.86721 12.99829 13.06169
```

```r
rep(c("A", "B", "C"), 3)
```

```
## [1] "A" "B" "C" "A" "B" "C" "A" "B" "C"
```

```r
rep(c("A", "B", "C"), each = 3)
```

```
## [1] "A" "A" "A" "B" "B" "B" "C" "C" "C"
```

```r
x <- c("01-31-1960", "02-13-1960", "06-23-1977", "01-01-2013")
class(x)
```

```
## [1] "character"
```

```r
z <- as.Date(x, "%m-%d-%Y")
class(z) # introducing the date class
```

```
## [1] "Date"
```

```r
seq(as.Date("2013-12-30"), as.Date("2014-01-04"), by = "days")
```

```
## [1] "2013-12-30" "2013-12-31" "2014-01-01" "2014-01-02" "2014-01-03"
## [6] "2014-01-04"
```

```r
seq(as.Date("2013-12-01"), as.Date("2016-01-31"), by = "months")
```

```
##  [1] "2013-12-01" "2014-01-01" "2014-02-01" "2014-03-01" "2014-04-01"
##  [6] "2014-05-01" "2014-06-01" "2014-07-01" "2014-08-01" "2014-09-01"
## [11] "2014-10-01" "2014-11-01" "2014-12-01" "2015-01-01" "2015-02-01"
## [16] "2015-03-01" "2015-04-01" "2015-05-01" "2015-06-01" "2015-07-01"
## [21] "2015-08-01" "2015-09-01" "2015-10-01" "2015-11-01" "2015-12-01"
## [26] "2016-01-01"
```

```r
seq(as.Date("2000/1/1"), by = "month", length.out = 12)
```

```
##  [1] "2000-01-01" "2000-02-01" "2000-03-01" "2000-04-01" "2000-05-01"
##  [6] "2000-06-01" "2000-07-01" "2000-08-01" "2000-09-01" "2000-10-01"
## [11] "2000-11-01" "2000-12-01"
```

```r
# and many more...
```

## Vector arithmetic

Arithmetic operations of vectors are performed component-by-component, *i.e.*, componentwise. For example, suppose we have vectors `a` and `b`:


```r
a <- c(1, 3, 5, 7)
b <- c(1, 2, 4, 8)
```

Then we multiply `a` by `5`...


```r
a * 5
```

```
## [1]  5 15 25 35
```

... and see that each component of `a` is multiplied by `5`. In other words, the shorter vector (here `5`) is recycled. Now multiply `a` with `b`...


```r
a * b
```

```
## [1]  1  6 20 56
```

...and we see that the components in one vector matches those in the other one-for-one. Similarly for subtraction, addition and division, we get new vectors via componentwise operations. Try this here now a few times with your own vectors.

But what if one vector is somewhat shorter than the other? The *recycling rule* comes into play. If two vectors are of unequal length, the shorter one will be recycled in order to match the longer vector. For example, the following vectors `u` and `v` have different lengths, and their sum is computed by recycling values of the shorter vector `u`:


```r
v <- rep(2, len = 13)
u <- rep(c(1, 20), len = 5)
v + u
```

```
## Warning in v + u: longer object length is not a multiple of shorter object
## length
```

```
##  [1]  3 22  3 22  3  3 22  3 22  3  3 22  3
```

## Dataframe creation

The most rudimentary way to create a dataframe is to create several vectors and then assemble them into a dataframe using `cbind()` --- this is a function that combines by *c*olumn. For instance:


```r
# create three vectors of different types
vec1 <- rep(c("A", "B", "C"), each = 5) # a character vector (a facctor)
vec2 <- seq.Date(from = as.Date("1981-01-01"), by = "day", 
                 length.out = length(vec1)) # date vector
vec3 <- rnorm(n = length(vec1), mean = 0, sd = 0.35) # numeric vector
# now assemble dataframe
df1 <- cbind(vec1, vec2, vec3)
head(df1)
```

```
##      vec1 vec2   vec3                  
## [1,] "A"  "4018" "-0.141653494038624"  
## [2,] "A"  "4019" "0.113104875559202"   
## [3,] "A"  "4020" "-0.892020464834879"  
## [4,] "A"  "4021" "-0.00244250809495045"
## [5,] "A"  "4022" "-0.153684993440955"  
## [6,] "B"  "4023" "0.640295779743719"
```

Another way to achieve the same thing is to use the `data.frame()` function that will allow you to achieve all of the above steps at once. Here is the example:


```r
df2 <- data.frame(vec1 = rep(c("A", "B", "C"), each = 5),
                  vec2 = seq.Date(from = as.Date("1981-01-01"), by = "day", 
                                  length.out = length(vec1)),
                  vec3 = rnorm(n = length(vec1), mean = 2, sd = 0.75))
head(df2, 2)
```

```
##   vec1       vec2     vec3
## 1    A 1981-01-01 2.654841
## 2    A 1981-01-02 2.182218
```

What about the names of the dataframe that you just created? Are you happy that they are descriptive enough? If you aren't, don't fear. There are several different ways in which we can change it. We can assign the existing separate vectors `vec1`, `vec2` and `vec3` to more user-friendly names using the `data.frame()` function, like this:


```r
df1 <- data.frame(level = vec1,
                  sample.date = vec2,
                  measurement = vec3)
head(df1, 2)
```

```
##   level sample.date measurement
## 1     A  1981-01-01  -0.1416535
## 2     A  1981-01-02   0.1131049
```

Another way is to change the name after you have created the dataframe using the `colnames()` assignment function, as in:


```r
colnames(df2) <- c("level", "sample.date", "measurement")
head(df2, 2)
```

```
##   level sample.date measurement
## 1     A  1981-01-01    2.654841
## 2     A  1981-01-02    2.182218
```

```r
names(df2)
```

```
## [1] "level"       "sample.date" "measurement"
```

Dataframes are very versatile and we can do many operations on them. A common requirement is to add a column to a dataframe that contains the outcome of some calculation. We could create a new column in the dataframe 'on the fly', as in:


```r
df2.1 <- df1 # copy the dataframe
df2.1$meas.anom <- df1$measurement - mean(df1$measurement)
df2.1$meas.diff <- df2.1$measurement - df2.1$meas.anom
head(df2.1, 2)
```

```
##   level sample.date measurement  meas.anom   meas.diff
## 1     A  1981-01-01  -0.1416535 -0.1015833 -0.04007022
## 2     A  1981-01-02   0.1131049  0.1531751 -0.04007022
```

We can also combine dataframes in different ways. Perhaps you have two (or more) dataframe that conform to the same layout, *i.e.* they have the same number of columns (although the length of the dataframes may differ), they have the same data type in those columns and the names of those columns are the same. Also, the order of the columns must be identical in all the dataframes. Two separate dataframe with the same structure may, for example, result from two identical experiments that were repeated at different times. We can then stack one on top (*e.g.* combine our experiments) of the other using the *r*ow bind function `rbind()`, as in:


```r
nrow(df1) # check the number of rows first
```

```
## [1] 15
```

```r
nrow(df2)
```

```
## [1] 15
```

```r
df3 <- rbind(df1, df2)
nrow(df3) # number of rows in the combined dataframe
```

```
## [1] 30
```

```r
head(df3, 2)
```

```
##   level sample.date measurement
## 1     A  1981-01-01  -0.1416535
## 2     A  1981-01-02   0.1131049
```

But now how do we know how the portions of the stacked dataframe relate to the experiments that resulted in the data in the first place? There is no label to distinguish one experiment from the other. We can fix this by adding a new column to the stacked dataframe that contains the coding for the two experiments. We can achieve it like this:


```r
df3$exp.no <- rep(c("exp1", "exp2"), each = nrow(df1))
head(df3, 2)
```

```
##   level sample.date measurement exp.no
## 1     A  1981-01-01  -0.1416535   exp1
## 2     A  1981-01-02   0.1131049   exp1
```

```r
tail(df3, 2)
```

```
##    level sample.date measurement exp.no
## 29     C  1981-01-14    1.298716   exp2
## 30     C  1981-01-15    0.703305   exp2
```

\begin{mybox}{}{DIY: Make your own dataframes}
For this task, please create two 'stackable' dataframes, but each with a different number of rows. Then stack them and assign an 'index column' so that the two original dataframes can easily be distinguished from one-another in the combined dataframe.
\end{mybox}

We can combine dataframes in another way --- that is, bind columns side-by-side using the function `cbind()`. We used it before to place vectors of the same length next to each other to create a dataframe. This function is similar to `rbind()`, but where `rbind()` fusses over the names of the columns, `cbind()` does not. What does concern `cbind()`, however, is that the number of rows in the two (or more) dataframes that will be 'glued' side-by-side is the same. Try it yourself with your own dataframes.

## Dataframe indices

Remember that weird `$` symbol we saw a little while ago? That symbol tells R that you want to see a column (vector) within a dataframe. For example, if we wanted to perform an operation on only one column in `intro_data` in order to ascertain the mean depth (m) of sampling:


```r
round(mean(intro_data$depth),2)
```

```
## [1] 1.33
```

If we want to subset only specific values in a dataframe, as we have seen how to do with vectors, we need to consider that we are now working with two dimensions and not one. We still use `[]` but now we must do a little extra. If we want to see how long the time series for Sodwana is we could do this in several ways, here are the three most common in an improving order:


```r
# Subset a dataframe using [,]
intro_data[12,9]
```

```
## [1] 4606
```

```r
# Subset only one column using []
intro_data$length[12]
```

```
## [1] 4606
```

```r
# Subset from one column using logic for another column
intro_data$length[intro_data$site == "Sodwana"]
```

```
## [1] 4606
```

The important thing to remember here is that when one needs to use a comma when subsetting, the row number is always on the left, and the column number is always on the right. Rows then columns! Tattoo that onto your brain. Or fore-arm if you are the adventurous type. We will go into the subsetting and analysis of dataframes in much more detail in the following session.

One must keep in mind that data in R can become substantially more complex than what we have covered, and the software also distinguishes several other kinds of data 'containers': in addition to vectors and dataframes, we also have *lists*, *matrices*, *time series* and *arrays*. The more complex ones, such as arrays, may have more dimensions than the two (rows along dimension 1, columns along dimension 2) that most people are familiar with. We will not delve into these here as they are bit more advanced than the goals of this course.
