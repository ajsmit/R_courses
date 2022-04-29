---
date: "2021-01-01"
draft: false
excerpt: What you need to know upfront.
subtitle: ""
title: "1. Types of data"
weight: 2
---

<!--- # Types of data --->

> *"The plural of anecdote is not data."*
>
> --- Roger Brinner



In this chapter we will, firstly, recap how to work with data in R. Then we will look at the different kinds of biological and environmental data that are typically encountered by most biologists. The data seen here are not an exhaustive list of all the various types of data out there, but it should represent the bulk of our needs.

After we have become familiar with the different kinds of data, we will look at summaries of these data, which is generally required as the starting point for our analyses. After summarising the data in tables and so forth, we may want to produce graphical summaries to see broad patterns and trends; visual data representations, which complement the tabulated data, will be covered in a later chapter (Chapter 4). Both of these approaches form the basis of 'exploratory data analysis.'

## Recap: working with data

We revisit the process for reading data into R. R will read in many types of data, including spreadsheets, text files, binary files, and files from other statistical packages.

### Preparing data

For R to be able to analyse your data, it needs to be in a consistent format, with each variable in its own column and each sample in its own row. This is called tidy data. The format within each variable (column) needs to be consistent and is commonly one of the following types: a continuous `numeric` variable (e.g., fish length (say in m): 0.133, 0.145); a `factor` or categorical variable (e.g., algal colour: red, green, brown); a `logical` variable (i.e., `TRUE` or `FALSE`), or a `date` (e.g. `1981-09-01` or some other accepted date or time format). You can also use other more specific general text (`string`) formats.

### Naming variables

R has pedantic requirements for naming variables. It is safest to not use spaces, special characters (e.g., commas, semicolons, any of the shift characters above the numbers), or function names (e.g., mean). In fact, I strongly suggest never to use spaces in variables, filenames, etc.

### Dataframes

Generally, the best way to store your data is to put all your biological and environmental data into one dataframe so that you can analyse them together. This requires having the first few variables (columns) as descriptors of each of your samples (e.g., `Site`, `Species`, `Sex`, `flush.dist`, etc). Each column has the same number of rows, so that it resembles a matrix. In essence, each row contains a data point (an observation; this will often reflect the response variable in your analysis), plus as many descriptors for that data point as is available (these are generally the explanatory variables in an analysis). In this module we will rely on the **tidyverse** approach for handling data, and in this context a dataframe is called a `tibble`.


```
R>   Site       Species    Sex flush.dist land.dist
R> 1    1 Oystercatcher Female       12.8     150.9
R> 2    1 Oystercatcher   Male        4.4     114.1
R> 3    1 Oystercatcher Female        9.5     153.7
R> 4    1 Oystercatcher Female       12.2     137.7
R> 5    1 Oystercatcher Female       10.1     143.3
R> 6    1 Oystercatcher   Male        6.6     142.8
```

### Setting the R Project

An important aspect of any program is its working directory (or folder). This is where R will read files from and write files to. RStudio displays the current working directory within the title region of the Console. The recommended way to deal with working directories is to use the RStudio Project feature: click on the File menu, select New Project, and give it an appropriate name (again, don't use spaces). A new RStudio window will then open and the File pane within RStudio will then show all the files associated with this particular set of analysis (typically a Project is associated with a suite of analyses, e.g., you'd want one for all the analyses that will contribute towards your Hons project). All your data files will also be within the Project folder. The Project will reflect an actual place in your computer's file system -- know how to navigate there using the Windows Explorer (Windows) or Finder (Mac).

Once the Project has been set up correctly, you'll see the name of the project reflected in the top right corner of the RStudio window (from there you can also select other projects that you have set up previously).

### Read in data

We are going to read in the Beach Birds dataset provided. These data reflect results of an experiment on beaches designed to measure the influence of off-road vehicles (ORVs) on shorebirds. Some colleagues visited five different beaches on the Sunshine Coast (`Sites`), Queensland, Australia, and at each site, drove along the shoreline in an ORV. As they drove along, they identified birds in the distance, and drove at them until they took flight. They recorded the species (`Species`) and sex (`Sex`) of the bird, the distance of the ORV from the bird at which it took flight (`flush.dist`), as well as the distance the bird flew before settling again (`land.dist`). In instances where sex could not be determined, or where birds flew out of sight before landing, they marked observations NA.

Often the first task is to convert an Excel file into a .csv file, which is my recommended format for getting data into R. I have already done this, but you would open the Excel file (e.g. BeachBirds.xlsx), then select "Save As" from the File menu. In the Format drop-down menu, select the option called "Comma Separated Values", then hit Save. You'll get a warning that formatting will be removed and that only one sheet will be exported; simply Continue. When saving this new file, be sure to select a folder that you can find. Look in that folder (directory) and make sure that you see BeachBirds.csv. Sometimes this file might not actually have commas inbetween the fileds (columns), but semi-colons ";" instead -- use a text editor and see what's inside. Set up the `read.csv()` function appropriately to deal with commas or semi-colons (i.e. by using the `sep = ""` argument.

Now let's start writing the script by clicking on the New Document Button (in the top-left corner of the RStudio window, and selecting R Script). It is recommended to start a script with some basic information for you to refer back to later. Start with a comment line (the line begins with a \#) that tells you the name of the script, something about the script, who created it, and the date it was created. In the Source Editor enter:


```r
# Beachbirds.R. Reads in and manipulates bird data
# <YourName> <CurrentDate>
```

> **TIP: Comments** The hash (`#`) tells R not to run any of the text on that line to right of the symbol. This is the standard way of commenting/annotating R code; it is VERY good practice to comment in detail so that you can understand later what you have done. Note that you can comment out entire blocks of code by highlighting it in the Source Editor and going to the menu Code and then choosing Comment/Uncomment Lines.

> **TIP: Splitting lines of code** If you have long lines of code, then you can spread them over multiple lines. You just have to make sure that R knows something is coming, either by leaving a bracket open, or ending the line with an operator.

So now we can save our script Choose File/Save As/ and type in "BeachBirds". It will automatically add a ".r" extension. But where will it save it? Yes, that's right, the Working Directory specified by the Project we set up initially.

### Importing data

Now we have the Project set, and R will know where to look for the files we read. The function `read.csv()` is the most convenient way to read in most biological data. There are several other ways to read in data, but `.csv` is usually the easiest. To find out what it does, we will read its help entry:


```r
?read.csv
```

All R Help items are in the same format. A short Description (of what it does), Usage, Arguments (the different inputs it requires), Details (of what it does), Value (what it returns) and Examples. Arguments (the parameters that are passed to the function) are the lifeblood of any function, as this is how you provide information to R. You do not need to specify all arguments, as many have appropriate default values, and others might not be needed for your particular case.

There are many arguments that you can use to customize reading of your data, but most important are:

1.  file: the name of the data file to be read (this needs to include its path if it is not in your specified working directory); note that file names must be placed within quotation marks

2.  header: is a logical argument (TRUE/FALSE) that specifies whether R reads the first line of your file as the names of the variables it contains

3.  quote: By default, character strings can be quoted by either single ' or double " quotes and usually do not need to be changed when exporting data as .csv from Excel. Let's assign the data in the file BeachBirds.csv to a variable called `birds`:


```r
birds <- read.csv("../../../../static/data/BeachBirds.csv", header = TRUE)
```

Remember that specifying `header = TRUE` indicates to R that the first row in the spreadsheet contains variable (column) names (headers). Note, also, that you can omit this argument, as `header = TRUE` is the default argument in `read.csv()`.

We can see that we have an object called `birds`. We can find out what sort of object `birds` is by typing:


```r
class(birds)
```

```
R> [1] "data.frame"
```

In this case, `birds` is a dataframe.

> **TIP: Stick with .csv files** There are packages in R to read in Excel spreadsheets (e.g., xlsx), but remember there are likely to be problems reading in formulae, graphs, macros and multiple worksheets. We recommend exporting data deliberately to .csv files (which are also commonly used in other programs). This not only avoids complications, but also allows you to unambiguously identify the data you based your analysis on. This last statement should give you the hint that it is good practice to name your .csv slightly differently each time you export it from Excel, perhaps by appending a reference to the date it was exported. Also, for those of you who use commas in Excel as the decimal separator, or to separate 1000s, undo these features now.

> **TIP: Dealing with missing data** The .csv file format is usually the most robust for reading data into R. Where you have missing data (blanks), the .csv format separates these by commas. However, there can be problems with blanks if you read in a space-delimited format file. If you are having trouble reading in missing data as blanks, try replacing them in your spreadsheet with NA, the missing data code in R. In Excel, highlight the area of the spreadsheet that includes all the cells you need to fill with NA. Do an Edit/Replace... and leave the "Find what:" textbox blank and in the "Replace with:" textbox enter NA, the missing value code. Once imported into R, the NA values will be recognised as missing data.

### Viewing our data

There are many ways of finding broad views of our data in R. The first few functions that we will look at were designed to simply scrutinise the contents of the tibbles, which is the 'tidyverse' name for the general 'container' that holds our data in the software's environment (i.e. in a block of the computer's memory dedicated to the R software). Whatever data are in R's environment will be seen in the 'Environment' tab in the top right of RStudio's four panes.

#### From the Environment pane

The first way to see what's in the tibble is not really a function at all, but a convenient (and lazy) way of quickly seeing a few basic things about our data. Let us look at the `BeachBirds` data. Load it like so (you'll remember from the Intro R Workshop):


```r
# Load the data
birds <- read.csv("../../../../static/data/BeachBirds.csv")
```

In the Environment pane, the object named `birds` will now appear under the panel named Data. To the left of it is a small white arrow in a blue circular background. By default the arrow points to the right. Clicking on it causes it to point down, which denotes that the data contained within the tibble have become expanded. The names of the columns (more correctly called 'variables') can now be seen. There you can see the variables `Site`, `Species`, `Sex`, `flush.dist`, and `land.dist`. The class of data they represent can be seen too: there's continuous data of class `num`, a variable of `chr`, and a one of class `int`. Beneath these there's a lot of attributes that denote some meta-data, which you may safely ignore for now.

#### `head()` and `tail()`

The `head()` and `tail()` functions simply display top and bottom portions of the tibble, and you may add the `n` argument and an integer to request that only a certain number of rows are returned; by default the top or bottom six rows are displayed.

There are various bits of additional information printed out. The display will change somewhat if there are many more variables than that which can comfortably fit within the width of the output window (typically the Console). The same kinds of information as was returned with the Environment pane expansion arrow are displayed, but the data class is now accompanied by an angle bracket (i.e. `<...>`) notation. For example, `num` in the Environment pane and `<dbl>` as per the `head()` or `tail()` methods are exactly the same: both denote continuous (or 'double precision') data.


```r
head(birds)
```

```
R>   Site       Species    Sex flush.dist land.dist
R> 1    1 Oystercatcher Female       12.8     150.9
R> 2    1 Oystercatcher   Male        4.4     114.1
R> 3    1 Oystercatcher Female        9.5     153.7
R> 4    1 Oystercatcher Female       12.2     137.7
R> 5    1 Oystercatcher Female       10.1     143.3
R> 6    1 Oystercatcher   Male        6.6     142.8
```

```r
tail(birds, n = 2)
```

```
R>     Site Species    Sex flush.dist land.dist
R> 398    5    Gull Female        9.4      50.5
R> 399    5    Gull Female       10.1      52.1
```

As an alternative to `head()`, you may also simply type the name of the object (here `birds`) in the Console (or write it in the Source Editor if it is necessary to retain the function for future use) and the top portion of the tibble will be displayed, again trimmed to account for the width of the display.

#### `colnames()`

This function simply returns a listing of the variable (column) names.


```r
colnames(birds)
```

```
R> [1] "Site"       "Species"    "Sex"        "flush.dist" "land.dist"
```

There is an equivalent function called `rownames()` that may be used to show the names of rows in your tibble, if these are present. Row names are generally discouraged, and we will refrain from using them here.

#### `summary()`

The next way to see the contents of the tibble is to apply the `summary()` function. Here we see something else. Some descriptive statistics that describe properties of the full set of data are now visible. These summary statistics condense each of the variables into numbers that describe some properties of the data within each column. You will already know the concepts of the 'minimum,' 'median,' 'mean,' and 'maximum.' These are displayed here.


```r
summary(birds)
```

```
R>       Site        Species              Sex              flush.dist   
R>  Min.   :1.00   Length:399         Length:399         Min.   : 0.00  
R>  1st Qu.:2.00   Class :character   Class :character   1st Qu.: 5.30  
R>  Median :3.00   Mode  :character   Mode  :character   Median : 8.30  
R>  Mean   :2.89                                         Mean   : 8.14  
R>  3rd Qu.:4.00                                         3rd Qu.:10.90  
R>  Max.   :5.00                                         Max.   :20.00  
R>    land.dist     
R>  Min.   :  5.60  
R>  1st Qu.: 42.50  
R>  Median : 64.40  
R>  Mean   : 73.12  
R>  3rd Qu.: 90.10  
R>  Max.   :199.90
```

This will serve well as an introduction to the next chapter, which is about descriptive statistics. What are they, and how do we calculate them?

> **Task 1:** Now that we have refreshed our memory you should start to remember how to work with our data. In a new R script, list a few other approaches available for interrogating our dataframe and finding some more details about it.

> **Task 2:** The next thing we want to do is to subset and filter our data. In the newly created R script, write down some lines of code that will subset and filter the beach birds data in interesitng and useful ways. Always provide ample comments to indicate what it you are doing, and why you're doing it. Hint: you'll want to use the **tidyverse** package.

This will show you what the data for Sex and for flush.dist look like.

## Data classes

In biology we will encounter many kinds of data, and depending on which kind, the type of statistical analysis will be decided.

### Numerical data

Numerical data are quantitative in nature. They represent things that can be objectively counted, measured or claculated.

#### Nominal (discrete) data

Integer data (discrete numbers or whole numbers), such as counts. For example, family A may have 3 children and family B may have 1 child, neither may have 2.3 children. Integer data usually answer the question, "how many?" In R integer data are called `int` or `<int>`.

#### Continuous data

These usually represent measured 'things,' such as something's heat content (temperature, measured in degrees Celsius) or distance (measured in metres or similar), etc. They can be rational numbers including integers and fractions, but typically they have an infinite number of 'steps' that depends on rounding (they can even be rounded to whole integers) or considerations such as measurement precision and accuracy. Often, continuous data have upper and lower bounds that depend on the characteristics of the phenomenon being studied or the measurement being taken. In R, continuous data are denoted `num` or `<dbl>`.

The kinds of summaries that lend themselves to continuous data are:

-   Frequency distributions
-   Relative frequency distributions
-   Cumulative frequency distributions
-   Bar graphs
-   Box plots
-   Scatter plots

#### Dates

![Dates](/workshops/biostats/chapters/02-data_files/deglet-noor-dates.jpeg)

Dates are a special class of continuous data, and there are many different representations of the date classes. This is a complex group of data, and we will not cover much of it in this course.

### Qualitative data

Qualitative data may be well-defined categories or they may be subjective, and generally include descriptive words for classes (e.g. mineral, animal , plant) or rankings (e.g. good, better, best).

#### Categorical data

Because there are categories, the number of members belonging to each of the categories can be counted. For example, there are three red flowers, 66 purple flowers, and 13 yellow flowers. The categories cannot be ranked relative to each other; in the example just provided, for instance, no value judgement can be assigned to the different colours. It is not better to be red than it is to be purple. There are just fewer red flowers than purple ones. Contrast this to another kind of categorical data called 'ordinal data' (see next). This class of data in an R dataframe (or in a 'tibble') is indicated by `Factor` or `<fctr>`.

The kinds of summaries that lend themselves to categorical data are:

-   Frequency distributions
-   Relative frequency distributions
-   Bar graphs
-   Pie graphs (!!!)
-   Category statistics

#### Ordinal data

This is a type of categorical data where the classes are ordered (a synonym is "ranked"), typically from low to high (or *vice versa*), but where the magnitude between the ordered classes cannot be precisely measured or quantified. In other words, the difference between them is somewhat subjective (i.e. it is qualitative rather than quantitative). These data are on an ordinal scale. The data may be entered as descriptive character strings (i.e. as words), or they may have been translated to an ordered vector of integers; for example, "1" for terrible, "2" for so-so, "3" for average, "4" for good and "5" for brilliant. Irrespective of how the data are present in the dataframe, computationally (for some calculations) they are treated as an ordered sequence of integers, but they are simultaneously treated as categories (say, where the number of responses that report "so-so" can be counted). Ordinal data usually answer questions such as, "how many categories can the phenomenon be divided into, and how does each category rank with respect to the others?" Columns containing this kind of data are named `Ord.factor` or `<ord>`.

### Binary data

Right or wrong? True or false? Accept or reject? Black or white? Positive or negative? Good or bad? You get the idea... In other words, these are observations or responses that can take only one of two mutually exclusive outcomes. In R these are treated as 'Logical' data that take the values of `TRUE` or `FALSE` (note the case). In R, and computing generally, logical data are often denoted with 1 for `TRUE` and 0 for `FALSE`. This class of data is indicated by `logi` or `<lgl>`.

### Character values

As the name implies, these are not numbers. Rather, they are human words that have found their way into R for one reason or another. In biology we most commonly encounter character values when we have a list of things, such as sites or species. These values will often be used as categorical or ordinal data.

### Missing values

Unfortunately, one of the most reliable aspects of any biological dataset is that it will contain some missing data. But how can something contain missing data? One could be forgiven for assuming that if the data are missing, then they obviously aren't contained in the dataset. To better understand this concept we must think back to the principles of tidy data. Every observation must be in a row, and every column in that row must contain a value. The combination of multiple observations then makes up our matrix of data. Because data are therefore presented in a two-dimensional format, any missing values from an observation will need to have an empty place-holder to ensure the consistency of the matrix. These are what we are referring to when we speak of "missing values". In R these appear as a `NA` in a dataframe and are slighlty lighter than the other values. These data are indicated in the Environment as `NA` and if a column contains only missing values it will be denoted as `<NA>`.

### Complex numbers

> *"And if you gaze long enough into an abyss, the abyss will gaze back into you."*
>
> --- Friedrich Nietzsche

In an attempt to allow the shreds of our sanity to remain stitched together we will end here with data types. But be warned, ye who enter, that below countless rocks, and around a legion of corners, lay in wait a myriad of complex data types. We will encounter many of these at the end of this course when we encounter modeling, but by then we will have learned a few techniques that will prepare us for the encounter.
