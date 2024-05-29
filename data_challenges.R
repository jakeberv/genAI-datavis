### MIDAS workshop data challenges

#R has many built in data sets to play with
data()

# Data sets in package ‘datasets’:
#   
# AirPassengers                    Monthly Airline Passenger Numbers 1949-1960
# BJsales                          Sales Data with Leading Indicator
# BJsales.lead (BJsales)           Sales Data with Leading Indicator
# BOD                              Biochemical Oxygen Demand
# CO2                              Carbon Dioxide Uptake in Grass Plants
# ChickWeight                      Weight versus age of chicks on different diets
# DNase                            Elisa assay of DNase
# EuStockMarkets                   Daily Closing Prices of Major European Stock Indices, 1991-1998
# Formaldehyde                     Determination of Formaldehyde
# HairEyeColor                     Hair and Eye Color of Statistics Students
# Harman23.cor                     Harman Example 2.3
# Harman74.cor                     Harman Example 7.4
# Indometh                         Pharmacokinetics of Indomethacin
# InsectSprays                     Effectiveness of Insect Sprays
# JohnsonJohnson                   Quarterly Earnings per Johnson & Johnson Share
# LakeHuron                        Level of Lake Huron 1875-1972
# LifeCycleSavings                 Intercountry Life-Cycle Savings Data
# Loblolly                         Growth of Loblolly pine trees
# Nile                             Flow of the River Nile
# Orange                           Growth of Orange Trees
# OrchardSprays                    Potency of Orchard Sprays
# PlantGrowth                      Results from an Experiment on Plant Growth
# Puromycin                        Reaction Velocity of an Enzymatic Reaction
# Seatbelts                        Road Casualties in Great Britain 1969-84
# Theoph                           Pharmacokinetics of Theophylline
# Titanic                          Survival of passengers on the Titanic
# ToothGrowth                      The Effect of Vitamin C on Tooth Growth in Guinea Pigs
# UCBAdmissions                    Student Admissions at UC Berkeley
# UKDriverDeaths                   Road Casualties in Great Britain 1969-84
# UKgas                            UK Quarterly Gas Consumption
# USAccDeaths                      Accidental Deaths in the US 1973-1978
# USArrests                        Violent Crime Rates by US State
# USJudgeRatings                   Lawyers' Ratings of State Judges in the US Superior Court
# USPersonalExpenditure            Personal Expenditure Data
# UScitiesD                        Distances Between European Cities and Between US Cities
# VADeaths                         Death Rates in Virginia (1940)
# WWWusage                         Internet Usage per Minute
# WorldPhones                      The World's Telephones
# ability.cov                      Ability and Intelligence Tests
# airmiles                         Passenger Miles on Commercial US Airlines, 1937-1960
# airquality                       New York Air Quality Measurements
# anscombe                         Anscombe's Quartet of 'Identical' Simple Linear Regressions
# attenu                           The Joyner-Boore Attenuation Data
# attitude                         The Chatterjee-Price Attitude Data
# austres                          Quarterly Time Series of the Number of Australian Residents
# beaver1 (beavers)                Body Temperature Series of Two Beavers
# beaver2 (beavers)                Body Temperature Series of Two Beavers
# cars                             Speed and Stopping Distances of Cars
# chickwts                         Chicken Weights by Feed Type
# co2                              Mauna Loa Atmospheric CO2 Concentration
# crimtab                          Student's 3000 Criminals Data
# discoveries                      Yearly Numbers of Important Discoveries
# esoph                            Smoking, Alcohol and (O)esophageal Cancer
# euro                             Conversion Rates of Euro Currencies
# euro.cross (euro)                Conversion Rates of Euro Currencies
# eurodist                         Distances Between European Cities and Between US Cities
# faithful                         Old Faithful Geyser Data
# fdeaths (UKLungDeaths)           Monthly Deaths from Lung Diseases in the UK
# freeny                           Freeny's Revenue Data
# freeny.x (freeny)                Freeny's Revenue Data
# freeny.y (freeny)                Freeny's Revenue Data
# infert                           Infertility after Spontaneous and Induced Abortion
# iris                             Edgar Anderson's Iris Data
# iris3                            Edgar Anderson's Iris Data
# islands                          Areas of the World's Major Landmasses
# ldeaths (UKLungDeaths)           Monthly Deaths from Lung Diseases in the UK
# lh                               Luteinizing Hormone in Blood Samples
# longley                          Longley's Economic Regression Data
# lynx                             Annual Canadian Lynx trappings 1821-1934
# mdeaths (UKLungDeaths)           Monthly Deaths from Lung Diseases in the UK
# morley                           Michelson Speed of Light Data
# mtcars                           Motor Trend Car Road Tests
# nhtemp                           Average Yearly Temperatures in New Haven
# nottem                           Average Monthly Temperatures at Nottingham, 1920-1939
# npk                              Classical N, P, K Factorial Experiment
# occupationalStatus               Occupational Status of Fathers and their Sons
# precip                           Annual Precipitation in US Cities
# presidents                       Quarterly Approval Ratings of US Presidents
# pressure                         Vapor Pressure of Mercury as a Function of Temperature
# quakes                           Locations of Earthquakes off Fiji
# randu                            Random Numbers from Congruential Generator RANDU
# rivers                           Lengths of Major North American Rivers
# rock                             Measurements on Petroleum Rock Samples
# sleep                            Student's Sleep Data
# stack.loss (stackloss)           Brownlee's Stack Loss Plant Data
# stack.x (stackloss)              Brownlee's Stack Loss Plant Data
# stackloss                        Brownlee's Stack Loss Plant Data
# state.abb (state)                US State Facts and Figures
# state.area (state)               US State Facts and Figures
# state.center (state)             US State Facts and Figures
# state.division (state)           US State Facts and Figures
# state.name (state)               US State Facts and Figures
# state.region (state)             US State Facts and Figures
# state.x77 (state)                US State Facts and Figures
# sunspot.month                    Monthly Sunspot Data, from 1749 to "Present"
# sunspot.year                     Yearly Sunspot Data, 1700-1988
# sunspots                         Monthly Sunspot Numbers, 1749-1983
# swiss                            Swiss Fertility and Socioeconomic Indicators (1888) Data
# treering                         Yearly Treering Data, -6000-1979
# trees                            Diameter, Height and Volume for Black Cherry Trees
# uspop                            Populations Recorded by the US Census
# volcano                          Topographic Information on Auckland's Maunga Whau Volcano
# warpbreaks                       The Number of Breaks in Yarn during Weaving
# women                            Average Heights and Weights for American Women
# 
# Data sets in package ‘palmerpenguins’:
#   
# penguins                         Size measurements for adult foraging penguins near Palmer Station,
# Antarctica
# penguins_raw (penguins)          Penguin size, clutch, and blood isotope data for foraging adults
# near Palmer Station, Antarctica


####################################

#Challenges using the mtcars data set

# Beginner: 
{
# Fuel Efficiency Analysis:
#   
# Challenge: Write a function to visualize the relationship between the number of cylinders (cyl) and miles per gallon (mpg). Provide insights on which cylinder configuration offers the best fuel efficiency.
# Requirements: The function should create a boxplot or violin plot to show the distribution of mpg for each cyl category.
}

# Intermediate:
{
# Correlation Heatmap:
# 
# Challenge: Write a function to compute and visualize the correlation matrix of the dataset. Identify which variables are most strongly correlated with each other.
# Requirements: The function should create a heatmap of the correlation matrix, with appropriate labels and a color legend.
}
  
# Advanced:
{
# Car Performance Segmentation:
# 
# Challenge: Write a function or series of functions to classify cars into performance segments based on your choice of the available attributes. Visualize these segments in a scatter plot.
# Requirements: The function should use clustering (e.g., k-means) to segment the cars and then visualize the clusters in a 2D scatter plot (even if using more than 2 dimensions)
}

#Challenges using the Spotify music data set
#This data set is in the supplementary folder. Read it in like this
spotify <- read.csv('./supplementary/top10s.csv')
#Source: https://www.kaggle.com/datasets/leonardopena/top-spotify-songs-from-20102019-by-year

#Some details about the data set

#title: Song's title
#artist: Song's artist
#top genre: the genre of the track
#year: Song's year in the Billboard
#bpm: Beats Per Minute - The tempo of the song.
#nrgy: Energy- The energy of a song - the higher the value, the more energtic.
#dnce: Danceability - The higher the value, the easier it is to dance to this song.
#dB: Loudness..dB.. - The higher the value, the louder the song
#live: Liveness - The higher the value, the more likely the song is a live recording
#val: Valence - The higher the value, the more positive mood for the song.
#dur: Length - The duration of the song.
#acous: Acousticness.. - The higher the value the more acoustic the song is.
#spch: Speechiness - The higher the value the more spoken word the song contains.
#pop: Popularity- The higher the value the more popular the song is.

# Beginner:
{
#   Energy Levels Across Artists:
#   
#   Challenge: Write a function to analyze the energy levels (nrgy) of songs from different artists. Identify which artists consistently produce high-energy songs.
# Requirements: The function should create a bar plot or boxplot showing the average nrgy for songs by each artist, highlighting those with consistently high energy.
}

# Intermediate:
{
#   Genre Popularity Over Time:
#   
#   Challenge: Write a function to analyze how the popularity of different genres has changed over the years.
# Requirements: The function should create a stacked area chart or line plot showing the average popularity of each genre by year, highlighting trends.
}

#Advanced
{
# Clustering Songs by Attributes:
#   
#   Challenge: Write a function to cluster songs based on their attributes (bpm, nrgy, dnce, dB, live, val, dur, acous, spch, pop) using k-means or hierarchical clustering.
# Requirements: The function should create a scatter plot or pair plot showing the clusters of songs, and provide insights into the characteristics of each cluster.
}



##########

#put any new function definitions in this file
#then load them into your analysis script with source()
#this keeps things nicely organized
source('./functions.R')

## your analysis script goes here.
