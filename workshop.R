###
# R script with examples of data vis aided by genAI

# writing your first function in R

# see slide on functions

## write a function that prints hello world
hello <- function() {
  print('Hi there')
}

## write a function that multiplies a, b
ab <- function(a, b) {
  a * b
}

ab(1,5)
ab(2,5)

#this will work on R objects now as well
#lets say I have two vectors
a <- c(1, 2, 3, 4, 5)
b <- c(5, 4, 3, 2, 1)

ab(a, b)
#[1] 5 8 9 8 5
#this will multiply each element by each element

ab(a, 5)
#multiply each element in a by 5

#we can also write a funciton that takes data as input and generates a plot

## write a function that multiplies a, b
ab <- function(a, b) {
  result <- a * b
  barplot(result)
}

ab(a, b)

#and so on.

### data exploration with LLM assist ##
## the primary goal of today's session is to learn how to write custom plotting functions in R ##

#let's load an example dataset -- the excellent 'palmer penguins' data set

#load the palmerpenguins dataset
install.packages("palmerpenguins")
library(palmerpenguins)
data(package = 'palmerpenguins')

# this loads two R objects into the R workspace
# they are in Tidyverse tibble format

penguins
penguins_raw

## lets convert them to standard R data frame
penguins_df <- as.data.frame(penguins)

#lets say you have received a data set to analyze and visualize -- 
#First, try providing the LLM a summary of the data structure

#use the structure() function ## -- this is likely one of the most important tricks
str(penguins_df)
# > str(penguins_df)
# 'data.frame':	344 obs. of  8 variables:
#   $ species          : Factor w/ 3 levels "Adelie","Chinstrap",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ island           : Factor w/ 3 levels "Biscoe","Dream",..: 3 3 3 3 3 3 3 3 3 3 ...
# $ bill_length_mm   : num  39.1 39.5 40.3 NA 36.7 39.3 38.9 39.2 34.1 42 ...
# $ bill_depth_mm    : num  18.7 17.4 18 NA 19.3 20.6 17.8 19.6 18.1 20.2 ...
# $ flipper_length_mm: int  181 186 195 NA 193 190 181 195 193 190 ...
# $ body_mass_g      : int  3750 3800 3250 NA 3450 3650 3625 4675 3475 4250 ...
# $ sex              : Factor w/ 2 levels "female","male": 2 1 1 NA 1 2 1 2 NA NA ...
# $ year             : int  2007 2007 2007 2007 2007 2007 2007 2007 2007 2007 ...

#Try pasting prompt into an LLM
"I am working on a new dataset in R. I have an R object with the following data structure. Can you tell me about it? Only summarize the data structure.
> str(penguins_df)
'data.frame':	344 obs. of  8 variables:
  $ species          : Factor w/ 3 levels "Adelie","Chinstrap",..: 1 1 1 1 1 1 1 1 1 1 ...
$ island           : Factor w/ 3 levels "Biscoe","Dream",..: 3 3 3 3 3 3 3 3 3 3 ...
$ bill_length_mm   : num  39.1 39.5 40.3 NA 36.7 39.3 38.9 39.2 34.1 42 ...
$ bill_depth_mm    : num  18.7 17.4 18 NA 19.3 20.6 17.8 19.6 18.1 20.2 ...
$ flipper_length_mm: int  181 186 195 NA 193 190 181 195 193 190 ...
$ body_mass_g      : int  3750 3800 3250 NA 3450 3650 3625 4675 3475 4250 ...
$ sex              : Factor w/ 2 levels "female","male": 2 1 1 NA 1 2 1 2 NA NA ...
$ year             : int  2007 2007 2007 2007 2007 2007 2007 2007 2007 2007 ..."

#ChatGPT 4o output
"The dataset penguins_df is a data frame in R containing 344 observations and 8 variables. Here is a summary of the data structure:

species: Factor with 3 levels - "Adelie", "Chinstrap", and another level. This variable indicates the species of penguins.
island: Factor with 3 levels - "Biscoe", "Dream", and another level. This variable indicates the island where the penguin was found.
bill_length_mm: Numeric variable indicating the bill length in millimeters. There are some missing values (NA).
bill_depth_mm: Numeric variable indicating the bill depth in millimeters. There are some missing values (NA).
flipper_length_mm: Integer variable indicating the flipper length in millimeters. There are some missing values (NA).
body_mass_g: Integer variable indicating the body mass in grams. There are some missing values (NA).
sex: Factor with 2 levels - "female" and "male". This variable indicates the sex of the penguin. There are some missing values (NA).
year: Integer variable indicating the year of observation.
This structure suggests the dataset is well-suited for statistical analysis or machine learning tasks involving categorical and continuous variables related to penguin characteristics."

#OK - 
#now we have a nice description of the data set and how it is organized. What might we want to do with it?

#Step 1 -- clean the data

#Let's assume we don't want to do any kind of missing data estimation and will just want to work with a 'clean' dataset

#How do we achieve this? 
#Let's write a function that will clean the data set (and any data set) for us.

#prompt for ChatGPT
"Considering this data frame, I wold like to produce a cleaned version that excludes rows with NA values. Can you help me write an R function that does this? The input will be a data frame containing NA values, and the desired output is a data frame that excludes NA values. Propose a logical solution to this problem, and wait for my next request."

#Here is the GPT 4o solution (in addition to some description I've ommitted)
clean_data <- function(df) {
  # Remove rows with any NA values
  cleaned_df <- na.omit(df)
  return(cleaned_df)
}

#run the function with the penguins_df, assign to a new variable
penguins_cleaned <- clean_data(penguins_df)

#examine the output
penguins_cleaned

#it appears the the NAs have been removed, but have they really?
any(is.na(penguins_cleaned))
#these are built in R functions- but you could write another function to check the output! 

#lets ask GPT to write one (for the sake of argument)
#prompt for GPT
"Ok, now help me write an R function that will check a data frame for NA values."

#GPT output
check_na <- function(df) {
  # Calculate total number of NA values in the data frame
  total_na <- sum(is.na(df))
  
  # Calculate the number of NA values for each column
  na_per_column <- colSums(is.na(df))
  
  # Create a summary list
  na_summary <- list(
    total_na = total_na,
    na_per_column = na_per_column
  )
  
  return(na_summary)
}
#this function actually counts and reports the number of NA values -- so it will be easy to see if any remain

#and we can run it --
check_na(penguins_cleaned)
#no NA values, confirmed.

############

#Ok -- now we have a clean data set. How do we want to visualize it? 
#prompt to GPT:
"I am interested in how body size varies across different islands, accounting for species and sex. Can you help me come up with some ideas of ways to visualize these patterns? Help me brainstorm."

#gpt 4o output (I have copied two of the ideas here):
"Sure! Here are some ideas for visualizing how body size varies across different islands, accounting for species and sex, using the penguins_df dataset:

Boxplots:

Body Mass by Island and Species: Create a boxplot with body mass on the y-axis, islands on the x-axis, and use different colors to represent species. You can also use facets to separate plots by sex.

Heatmaps:

Heatmap of Body Mass: Create a heatmap where the rows represent islands, columns represent species, and the color intensity represents the average body mass. Use separate heatmaps for each sex.

Density Plot: 

Create density plots for body mass for each island, separated by species and colored by sex."

#lets explore the first option
#Boxplots --
#GPT prompt
"I like the idea of boxplots: Create a boxplot with body mass on the y-axis, islands on the x-axis, and use different colors to represent species. You can also use facets to separate plots by sex. Write an R function (using base R) that will achieve this. The input data will be the cleaned penguins data frame."
#I am specifying base R so that it does not use tidyverse/ggplot code (you can if you want to!)

#custom boxplot function
#output from GPT 4o directly
create_boxplot <- function(cleaned_df) {
  # Ensure the dataset is cleaned and does not contain NA values
  cleaned_df <- na.omit(cleaned_df)
  
  # Define the color palette for species
  species_colors <- c("Adelie" = "red", "Chinstrap" = "blue", "Gentoo" = "green")
  
  # Split data by sex
  sexes <- unique(cleaned_df$sex)
  
  # Create boxplots for each sex
  par(mfrow = c(1, length(sexes)))  # Create a layout for side-by-side plots
  for (sex in sexes) {
    sex_data <- subset(cleaned_df, sex == sex)
    boxplot(body_mass_g ~ island * species, data = sex_data, col = species_colors,
            main = paste("Body Mass by Island and Species (Sex:", sex, ")"),
            xlab = "Island and Species", ylab = "Body Mass (g)", las = 2,
            cex.axis = 0.8, cex.lab = 1.2, cex.main = 1.4)
    legend("topright", legend = names(species_colors), fill = species_colors, title = "Species")
  }
}

#try it out
create_boxplot(penguins_cleaned)
## it generates some output -- but its not really very intuitive - probably requires some tweaking. Its not a bad start though! Maybe let's try something else.

#GPT prompt
#lets think about the object again -- 
#maybe it would be interesting to visualize the distributions of specific traits across different islands, considering year, sex, and species as use specified options.
#lets write a function that asks the user to specify these options?
"I think it would be interesting to visualize the distributions of specific traits across different islands, considering year, sex, and species as use specified options. The input will be the cleaned data frame, and user options for year, sex, and species). The function should use boxplots (base R) to show the trait distributions across islands."

#GPT 4o output (after some minimal prompting and iteration)
#we will want to specify a consistent plotting range for the y axis
create_trait_boxplots <- function(cleaned_df, trait, year = NULL, sex = NULL, species = NULL, ylim = NULL) {
  # Filter data based on user options
  if (!is.null(year)) {
    cleaned_df <- cleaned_df[cleaned_df$year %in% year, ]
  }
  if (!is.null(sex)) {
    cleaned_df <- cleaned_df[cleaned_df$sex %in% sex, ]
  }
  if (!is.null(species)) {
    cleaned_df <- cleaned_df[cleaned_df$species %in% species, ]
  }
  
  # Ensure the dataset is cleaned and does not contain NA values for the selected trait
  cleaned_df <- cleaned_df[!is.na(cleaned_df[[trait]]), ]
  
  # Define unique levels for islands
  islands <- unique(cleaned_df$island)
  
  # Create the boxplot
  boxplot_formula <- as.formula(paste(trait, "~ island"))
  
  # Construct the plot title with user options
  title_text <- paste(trait, "by Island\n",
                      if(!is.null(year)) paste("Year:", paste(year, collapse = ", ")), 
                      if(!is.null(sex)) paste("Sex:", paste(sex, collapse = ", ")),
                      if(!is.null(species)) paste("Species:", paste(species, collapse = ", ")), 
                      sep = " ")
  
  # Create the boxplot with specified y limits
  boxplot(boxplot_formula, data = cleaned_df, col = rainbow(length(islands)),
          main = title_text,
          xlab = "Island", ylab = trait, las = 2,
          cex.axis = 0.8, cex.lab = 1.2, cex.main = 1.4,
          ylim = ylim)
}

# Example usage with the cleaned data frame

#Do body masses change across time?
create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2007), sex = c("female"), species = c("Chinstrap"), ylim=c(2500, 5000))

create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2008), sex = c("female"), species = c("Chinstrap"), ylim=c(2500, 5000))

create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2009), sex = c("female"), species = c("Chinstrap"), ylim=c(2500, 5000))

## this suggest that the variance changes across time, but the median is stable
## what about for males?

create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2007), sex = c("male"), species = c("Chinstrap"), ylim=c(2500, 5000))

create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2008), sex = c("male"), species = c("Chinstrap"), ylim=c(2500, 5000))

create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2009), sex = c("male"), species = c("Chinstrap"), ylim=c(2500, 5000))

## males seem to be larger mass, with slightly more variance across years.

#which penguins occur on all islands?
str(penguins_cleaned)
"I want to know what penguins occur on all islands"

#GPT 4o returned:

# Assuming penguins_cleaned is already created by removing rows with NA values
# Create a contingency table of species and islands
species_island_table <- table(penguins_cleaned$species, penguins_cleaned$island)

# Identify species that occur on all islands
species_on_all_islands <- rownames(species_island_table)[apply(species_island_table, 1, function(x) all(x > 0))]

#This tells me that Adelie penguins are found on all islands. Cool -- now we can go back to our plotting function and specify Adelie:

par(mfrow=c(1,3))

create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2007), sex = c("male"), species = c("Adelie"), ylim=c(2500, 5000))

create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2008), sex = c("male"), species = c("Adelie"), ylim=c(2500, 5000))

create_trait_boxplots(penguins_cleaned, trait = "body_mass_g", year = c(2009), sex = c("male"), species = c("Adelie"), ylim=c(2500, 5000))


## and so on -- 
## you can see how generating a custom plotting function allows us to quickly explore different dimensions of the data

## you could do this with ggplot etc, but with genAI, you dont need to, just write a function to parse and plot the data in the way that is most useful to you.


### section 2 ###

####
#### Lets try another example:
#Recall our dataset
str(penguins_cleaned)
## Ok now, lets try something a bit more sophisticated.
## Let's say, we want to know what the relationship between bill length and flipper length looks like, but we want to compare this across species. In this case, we want to fit linear models for each species, and plot the results. The plot should give us useful information.

## starting from a fresh session

## This time, I will include all of the function iterations to show the process I go through.

#So, let's give GPT the structure of the object, as before, and describe the goal.
"I am working with an R data object that looks like this

> str(penguins_cleaned)
'data.frame':	333 obs. of  8 variables:
 $ species          : Factor w/ 3 levels "Adelie","Chinstrap",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ island           : Factor w/ 3 levels "Biscoe","Dream",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ bill_length_mm   : num  39.1 39.5 40.3 36.7 39.3 38.9 39.2 41.1 38.6 34.6 ...
 $ bill_depth_mm    : num  18.7 17.4 18 19.3 20.6 17.8 19.6 17.6 21.2 21.1 ...
 $ flipper_length_mm: int  181 186 195 193 190 181 195 182 191 198 ...
 $ body_mass_g      : int  3750 3800 3250 3450 3650 3625 4675 3200 3800 4400 ...
 $ sex              : Factor w/ 2 levels "female","male": 2 1 1 1 2 1 2 1 2 2 ...
 $ year             : int  2007 2007 2007 2007 2007 2007 2007 2007 2007 2007 ...
 - attr(*, "na.action")= 'omit' Named int [1:11] 4 9 10 11 12 48 179 219 257 269 ...
  ..- attr(*, "names")= chr [1:11] "4" "9" "10" "11" ...
  
I want to know what the relationship between bill length and flipper length looks like, but I want to compare this across species. I want to write an R function that takes the input data object, and user arguments for pairs of specific traits. The function will filter the dataset by species, and fit linear models to each pair of traits. Then, it will plot a scatterplot of the results, per species, with each species as a different colored poitns. It will lastly add the inferred regression lines.

Ensure you understand the task. Explain it back to me before proceeding and I will check your logic."

## this time, I will use chain of thought prompting to try to get the LLM to follow a multi-step procedure and generate a plotting function that does more than one thing at time. This last sentence really helps to ensure that the model is crystal clear about what you want.

#Here is GPT's response
"Certainly! Here’s a breakdown of the task:

Input: An R data frame (similar to penguins_cleaned) and user-specified pairs of traits (e.g., bill length and flipper length).
Filtering and Modeling:
The function will filter the dataset by species.
For each species, it will fit a linear model to the specified pair of traits (e.g., bill_length_mm and flipper_length_mm).

Plotting:
Create a scatter plot showing the relationship between the two specified traits for each species.
Use different colors for each species.
Add the regression lines inferred from the linear models to the plot.
Here’s the step-by-step plan to achieve this in R:

Function Definition: Create a function that takes the data frame and two trait names as input arguments.
Data Filtering: Within the function, filter the data by species.
Linear Model Fitting: Fit a linear model to the specified traits for each species.

Plotting:
Generate a scatter plot with different colors for each species.
Add regression lines to the plot, one for each species."

## this looks perfectly correct -- so no need to provide additional clarification!
## note, this is likely because I was very specific in my initial request -- if I was not specific enough, this is your  opportunity to provide corrected or more specific instructions!!

#GPT prompt
"OK, this looks, good, go ahead and write the R function. Use base R" 
#Specifically for R, GPT likes to try to use the tidyverse. You can certainly do this! I prefer not to, so it is useful to specify that we want to use base R. 

#GPT response
{
plot_trait_relationship_base <- function(data, trait_x, trait_y) {
  # Ensure the traits are present in the data
  if(!(trait_x %in% names(data)) | !(trait_y %in% names(data))) {
    stop("Specified traits are not found in the data.")
  }
  
  # Define colors for species
  species_colors <- c("Adelie" = "blue", "Chinstrap" = "red", "Gentoo" = "green")
  
  # Set up the plot
  plot(data[[trait_x]], data[[trait_y]], 
       xlab = trait_x, ylab = trait_y, 
       main = paste("Relationship between", trait_x, "and", trait_y, "by species"),
       col = species_colors[data$species], pch = 19)
  
  # Add legend
  legend("topright", legend = levels(data$species), col = species_colors, pch = 19)
  
  # Loop through each species
  for(species in levels(data$species)) {
    # Filter data for the current species
    species_data <- subset(data, species == data$species)
    
    # Fit linear model
    lm_model <- lm(as.formula(paste(trait_y, "~", trait_x)), data = species_data)
    
    # Get predictions for regression line
    pred_x <- seq(min(species_data[[trait_x]]), max(species_data[[trait_x]]), length.out = 100)
    pred_y <- predict(lm_model, newdata = data.frame(trait_x = pred_x))
    
    # Add regression line to the plot
    lines(pred_x, pred_y, col = species_colors[species], lwd = 2)
  }
}

# Example usage
# Assuming penguins_cleaned is already loaded in your environment
plot_trait_relationship_base(penguins_cleaned, "bill_length_mm", "flipper_length_mm")
}
## this generates a plot but throws an error-- it seems to be related to the linear regressions

## upon examining the code, we see it is likely related to the model fitting.
## an easy way to troubleshoot this is to directly give GPT the error message and your hypothesis about the error

#GPT prompt:
"There is an error:

Error in eval(predvars, data, env) : object 'bill_length_mm' not found
Called from: eval(predvars, data, env)

It looks like the error is occurring in the model fitting, because the initial plotting seems to work correctly. Can you check this section? If you see an error, correct it, otherwise, can you add debug statements to help me troubleshoot?"

## I am not showing all of the back and forth troubleshooting -- but this is how you would do it.
## Eventually you get a working function

#GPT response:
plot_trait_relationship_base <- function(data, trait_x, trait_y) {
  # Ensure the traits are present in the data
  if(!(trait_x %in% names(data)) | !(trait_y %in% names(data))) {
    stop("Specified traits are not found in the data.")
  }
  
  # Define colors for species
  species_colors <- c("Adelie" = "blue", "Chinstrap" = "red", "Gentoo" = "green")
  
  # Set up the plot
  plot(data[[trait_x]], data[[trait_y]], 
       xlab = trait_x, ylab = trait_y, 
       main = paste("Relationship between", trait_x, "and", trait_y, "by species"),
       col = species_colors[as.character(data$species)], pch = 19)
  
  # Add legend
  legend("topright", legend = levels(data$species), col = species_colors, pch = 19)
  
  # Loop through each species
  for(species in levels(data$species)) {
    # Filter data for the current species using bracket subsetting
    species_data <- data[data$species == species, ]
    
    # Debug statement to check filtered data
    print(paste("Species:", species))
    print(head(species_data))
    
    # Construct the formula
    formula_str <- paste(trait_y, "~", trait_x)
    print(paste("Formula:", formula_str))
    
    # Fit linear model
    lm_model <- lm(as.formula(formula_str), data = species_data)
    
    # Debug statement to check model summary
    print(summary(lm_model))
    
    # Add regression line to the plot using abline
    abline(lm_model, col = species_colors[species], lwd = 2)
  }
}
plot_trait_relationship_base(penguins_cleaned, "bill_length_mm", "flipper_length_mm")

## cool this works great

## The function returns printed model fit objects, but what if we actually want to return these model fits as objects?

#Lets ask GPT to "optionally plot" and also return the model fits as a list of objects.

#GPT prompt:
"This function works [insert function code]

Modify the function so that plotting is turned on and off with a user flag, that it also returns the model fits as a list of objects"

#GPT response
{
plot_trait_relationship_base <- function(data, trait_x, trait_y, plot = TRUE) {
  # Ensure the traits are present in the data
  if(!(trait_x %in% names(data)) | !(trait_y %in% names(data))) {
    stop("Specified traits are not found in the data.")
  }
  
  # Define colors for species
  species_colors <- c("Adelie" = "blue", "Chinstrap" = "red", "Gentoo" = "green")
  
  # Initialize an empty list to store model fits
  model_fits <- list()
  
  # If plotting is enabled, set up the plot
  if (plot) {
    plot(data[[trait_x]], data[[trait_y]], 
         xlab = trait_x, ylab = trait_y, 
         main = paste("Relationship between", trait_x, "and", trait_y, "by species"),
         col = species_colors[as.character(data$species)], pch = 19)
    
    # Add legend
    legend("topright", legend = levels(data$species), col = species_colors, pch = 19)
  }
  
  # Loop through each species
  for(species in levels(data$species)) {
    # Filter data for the current species using bracket subsetting
    species_data <- data[data$species == species, ]
    
    # Debug statement to check filtered data
    print(paste("Species:", species))
    print(head(species_data))
    
    # Construct the formula
    formula_str <- paste(trait_y, "~", trait_x)
    print(paste("Formula:", formula_str))
    
    # Fit linear model
    lm_model <- lm(as.formula(formula_str), data = species_data)
    
    # Store the model fit in the list
    model_fits[[species]] <- lm_model
    
    # Debug statement to check model summary
    print(summary(lm_model))
    
    # If plotting is enabled, add regression line to the plot using abline
    if (plot) {
      abline(lm_model, col = species_colors[species], lwd = 2)
    }
  }
  
  # Return the list of model fits
  return(model_fits)
}

# Example usage with plotting ## now we also assign the function call to a new variable
# this will store the model fits as a new object
model_fits <- plot_trait_relationship_base(penguins_cleaned, "bill_length_mm", "flipper_length_mm", plot = TRUE)

}

model_fits 
## this object is now useful and contains all of the information about the analysis
# if you want to share this with a collaborator, you can use saveRDS() !

## OK -- now that this is working, lets say that we want to compare the models fits to see if they are statistically different? 
# Anyone know how to do this?

## lets fit a linear model with species as a factor

#GPT prompt
"I would like to know if these relationships are statistically different across the different species, can you help me set up a linear model that includes species as a factor? Id like to write a new function that takes the same input as the previous function: data, trait_x, trait_y"

#GPT response
{
compare_species_relationships <- function(data, trait_x, trait_y) {
    # Ensure the traits are present in the data
    if(!(trait_x %in% names(data)) | !(trait_y %in% names(data))) {
      stop("Specified traits are not found in the data.")
    }
    
    # Construct the formula with factor term
    formula_str <- paste(trait_y, "~", trait_x, "+ species")
    print(paste("Formula:", formula_str))
    
    # Fit the linear model
    lm_model <- lm(as.formula(formula_str), data = data)
    
    # Return the summary of the linear model
    model_summary <- summary(lm_model)
    return(model_summary)
  }
model_summary <- compare_species_relationships(penguins_cleaned, "bill_length_mm", "flipper_length_mm")
print(model_summary)

}

#Here is some of the model output -- 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)      147.5633     4.2234  34.940  < 2e-16 ***
#   bill_length_mm     1.0957     0.1081  10.139  < 2e-16 ***
#   speciesChinstrap  -5.2470     1.3797  -3.803  0.00017 ***
#   speciesGentoo     17.5517     1.1883  14.771  < 2e-16 ***

#If you need help interpreting the output, ask the LLM!
#Copy/paste the entire model output as part of a new prompt.

#GPT prompt:
"Help me interpret the model output:

> print(model_summary)

Call:
lm(formula = as.formula(formula_str), data = data)

Residuals:
     Min       1Q   Median       3Q      Max 
-24.8669  -3.4617  -0.0765   3.7020  15.9944 

Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
(Intercept)      147.5633     4.2234  34.940  < 2e-16 ***
bill_length_mm     1.0957     0.1081  10.139  < 2e-16 ***
speciesChinstrap  -5.2470     1.3797  -3.803  0.00017 ***
speciesGentoo     17.5517     1.1883  14.771  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.833 on 329 degrees of freedom
Multiple R-squared:  0.8283,	Adjusted R-squared:  0.8268 
F-statistic: 529.2 on 3 and 329 DF,  p-value: < 2.2e-16"

#GPT response
{"Call:
This indicates the formula used for the linear model and the dataset.

Residuals:
These are the differences between the observed and predicted values. The five-number summary (Min, 1Q, Median, 3Q, Max) provides a quick snapshot of the distribution of residuals:

Min: -24.8669
1Q (1st Quartile): -3.4617
Median: -0.0765
3Q (3rd Quartile): 3.7020
Max: 15.9944
Coefficients:
This section provides estimates of the model parameters, their standard errors, t-values, and p-values.

Interpreting the Coefficients:
(Intercept):

Estimate: 147.5633
Std. Error: 4.2234
t value: 34.940
Pr(>|t|): < 2e-16
Interpretation: The intercept represents the estimated value of flipper_length_mm for the reference species (Adelie) when bill_length_mm is 0. The intercept is highly significant (p < 2e-16).
bill_length_mm:

Estimate: 1.0957
Std. Error: 0.1081
t value: 10.139
Pr(>|t|): < 2e-16
Interpretation: For each additional millimeter in bill_length_mm, the flipper_length_mm increases by approximately 1.0957 mm for the reference species (Adelie). This effect is highly significant (p < 2e-16).
speciesChinstrap:

Estimate: -5.2470
Std. Error: 1.3797
t value: -3.803
Pr(>|t|): 0.00017
Interpretation: Chinstrap penguins have an average flipper_length_mm that is 5.2470 mm less than Adelie penguins, holding bill_length_mm constant. This difference is statistically significant (p = 0.00017).
speciesGentoo:

Estimate: 17.5517
Std. Error: 1.1883
t value: 14.771
Pr(>|t|): < 2e-16
Interpretation: Gentoo penguins have an average flipper_length_mm that is 17.5517 mm more than Adelie penguins, holding bill_length_mm constant. This difference is highly significant (p < 2e-16).
Significance Codes:
The stars next to the p-values indicate the level of significance:

***: p < 0.001
**: p < 0.01
*: p < 0.05
.: p < 0.1
: p >= 0.1
Residual Standard Error:
5.833 on 329 degrees of freedom: The typical size of the residuals (errors) is 5.833 mm. The degrees of freedom (329) indicates the number of observations minus the number of parameters estimated.
Multiple R-squared and Adjusted R-squared:
Multiple R-squared: 0.8283
Adjusted R-squared: 0.8268
Interpretation: These values indicate that approximately 82.83% of the variability in flipper_length_mm is explained by the model, adjusted for the number of predictors. This suggests a good fit.
F-statistic:
529.2 on 3 and 329 DF
p-value: < 2.2e-16
Interpretation: The overall model is highly significant (p < 2.2e-16), indicating that at least one of the predictors (bill_length_mm or species) significantly predicts flipper_length_mm.
Summary:
The relationships between bill_length_mm and flipper_length_mm differ significantly between the species.
The interaction terms (i.e., species effects) show that both Chinstrap and Gentoo penguins have significantly different flipper_length_mm compared to Adelie penguins, even when controlling for bill_length_mm.
The model explains a large proportion of the variance in flipper_length_mm, suggesting a strong relationship between the traits and species."}

## Now you have all of the tools needed to tackle some data sets on your own, boosted by LLMs

## try another example
## cool illustration using ggridges

#Here is another example using ggplot2 and ggridges

#recall the structure of the data set
str(penguins_cleaned)

#lets say we want to compare the distributions of the different trait values
#for the different species at the same time? 

# lets look at the ggrdiges examples 
# https://cran.r-project.org/web/packages/ggridges/vignettes/gallery.html

# maybe we want to duplicate the style of the 'Height of Australian athletes' plot--

# lets try to give chatGPT the example plot, its code, and then ask it to generalize to our data set

#GPT prompt:
'
Here is an image of a plot I would like to replicate [paste image]

Here is the code used to generate it:
{
ggplot(Aus_athletes, aes(x = height, y = sport, color = sex, point_color = sex, fill = sex)) +
  geom_density_ridges(
    jittered_points = TRUE, scale = .95, rel_min_height = .01,
    point_shape = "|", point_size = 3, size = 0.25,
    position = position_points_jitter(height = 0)
  ) +
  scale_y_discrete(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0), name = "height [cm]") +
  scale_fill_manual(values = c("#D55E0050", "#0072B250"), labels = c("female", "male")) +
scale_color_manual(values = c("#D55E00", "#0072B2"), guide = "none") +
  scale_discrete_manual("point_color", values = c("#D55E00", "#0072B2"), guide = "none") +
  coord_cartesian(clip = "off") +
  guides(fill = guide_legend(
    override.aes = list(
      fill = c("#D55E00A0", "#0072B2A0"),
      color = NA, point_color = NA)
  )
  ) +
  ggtitle("Height in Australian athletes") +
  theme_ridges(center = TRUE)
}

I would like to replicate this plotting style for my dataset called penguins_cleaned.

Recall that my data set has this structure:
> str(penguins_cleaned)
'data.frame':	333 obs. of  8 variables:
 $ species          : Factor w/ 3 levels "Adelie","Chinstrap",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ island           : Factor w/ 3 levels "Biscoe","Dream",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ bill_length_mm   : num  39.1 39.5 40.3 36.7 39.3 38.9 39.2 41.1 38.6 34.6 ...
 $ bill_depth_mm    : num  18.7 17.4 18 19.3 20.6 17.8 19.6 17.6 21.2 21.1 ...
 $ flipper_length_mm: int  181 186 195 193 190 181 195 182 191 198 ...
 $ body_mass_g      : int  3750 3800 3250 3450 3650 3625 4675 3200 3800 4400 ...
 $ sex              : Factor w/ 2 levels "female","male": 2 1 1 1 2 1 2 1 2 2 ...
 $ year             : int  2007 2007 2007 2007 2007 2007 2007 2007 2007 2007 ...
 - attr(*, "na.action")= 'omit' Named int [1:11] 4 9 10 11 12 48 179 219 257 269 ...
  ..- attr(*, "names")= chr [1:11] "4" "9" "10" "11" ...

### Your task

For each row, I would like to visualize three density plots, one for each island, and a user-specified trait. The plots represent the values for all species on each island for the specified trait.

The goal is to write a function that wraps around the ggplot code and allows the user to easily generate the described figure.

Study my instructions, and then describe the task step by step. Then wait for further instructions. 

'

# GPT4o output -- after few-shot prompting to clarify the goals.

{
  require(tidyverse)
  require(ggridges)  
  # Function to generate the density ridge plot for a specified trait
  create_density_ridge_plot <- function(data, trait) {
    ggplot(data, aes_string(x = trait, y = "island", fill = "island")) +
      geom_density_ridges(
        jittered_points = TRUE, scale = .95, rel_min_height = .01,
        point_shape = "|", point_size = 3, size = 0.25,
        position = position_points_jitter(height = 0)
      ) +
      scale_y_discrete(expand = c(0, 0)) +
      scale_x_continuous(expand = c(0, 0), name = paste(trait, "[units]")) +
      scale_fill_manual(values = c("#D55E00", "#0072B2", "#F0E442"), labels = c("Biscoe", "Dream", "Torgersen")) +
      coord_cartesian(clip = "off") +
      guides(fill = guide_legend(
        override.aes = list(
          fill = c("#D55E00", "#0072B2", "#F0E442"),
          color = NA, point_color = NA)
      )) +
      ggtitle(paste(trait, "Distribution across Islands")) +
      theme_ridges(center = TRUE)
  }
  
  # Example usage of the function
  create_density_ridge_plot(penguins_cleaned, "bill_length_mm")

}


#ok this is a nice plot, but now, lets parse out the data by species. each row should have a separate distribution for each species

#GPT prompt
"OK this is good, now, lets parse out the data a bit more. Each row of the plot should have a separate distribution for each species, which we will automatically determine. Here is the prior version of the function:
[Insert function code]

Can you generate a revised funcion that achieves the stated goal?
"

#GPT response
{
  # Function to generate the density ridge plot for a specified trait
  create_density_ridge_plot <- function(data, trait) {
    data$group <- paste(data$island, data$species, sep = " - ")
    
    ggplot(data, aes_string(x = trait, y = "group", fill = "species")) +
      geom_density_ridges(
        jittered_points = TRUE, scale = .95, rel_min_height = .01,
        point_shape = "|", point_size = 3, size = 0.25,
        position = position_points_jitter(height = 0)
      ) +
      scale_y_discrete(expand = c(0, 0)) +
      scale_x_continuous(expand = c(0, 0), name = paste(trait, "[units]")) +
      coord_cartesian(clip = "off") +
      guides(fill = guide_legend(
        override.aes = list(
          fill = c("#D55E00", "#0072B2", "#F0E442"),
          color = NA, point_color = NA)
      )) +
      ggtitle(paste(trait, "Distribution across Islands and Species")) +
      theme_ridges(center = TRUE)
  }
  
  # Example usage of the function
  create_density_ridge_plot(penguins_cleaned, "bill_length_mm")
  
}

#This is cool, but the function put the distributions on separate rows-- what if we want the rows to only show islands? Ask for a revised function.

#GPT prompt: 
"This is close, but not quite what I want -- can you revise the function so that each row represents an island? there can be multiple distributions per row, when there are multiple species on an island. Do you understand?"

#GPT response:
{
"I understand now. Each row should represent an island, and within each row, there should be separate distributions for each species on that island. Here's the revised function to achieve this:"

library(ggplot2)
library(ggridges)

# Load the penguins_cleaned dataset
#penguins_cleaned <- read.csv("/mnt/data/penguins_cleaned.csv")

# Function to generate the density ridge plot for a specified trait
create_density_ridge_plot <- function(data, trait) {
  ggplot(data, aes_string(x = trait, y = "island", fill = "species")) +
    geom_density_ridges(
      jittered_points = TRUE, scale = .95, rel_min_height = .01,
      point_shape = "|", point_size = 3, size = 0.25,
      position = position_points_jitter(height = 0)
    ) +
    scale_y_discrete(expand = c(0, 0)) +
    scale_x_continuous(expand = c(0, 0), name = paste(trait, "[units]")) +
    coord_cartesian(clip = "off") +
    guides(fill = guide_legend(
      override.aes = list(
        fill = c("#D55E00", "#0072B2", "#F0E442"),
        color = NA, point_color = NA)
    )) +
    ggtitle(paste(trait, "Distribution across Islands and Species")) +
    theme_ridges(center = TRUE)
}

# Example usage of the function
create_density_ridge_plot(penguins_cleaned, "bill_length_mm")

}

## and so on -- you can see where this is going.

# now we have a customized funtion that does exactly what we want - 
#eg., I can easily change the trait I want to examine

create_density_ridge_plot(penguins_cleaned, "flipper_length_mm")

create_density_ridge_plot(penguins_cleaned, "bill_depth_mm")

## one last bonus example

## if you end up writing your own functions, ask GPT to write mermaid code to visualize a flowchart
## then go to mermaid.live to visualize it!

## Now go to data challenges depending on how much time is left