# Network visualization of social networks in movies 

## Introduction

A R shiny application to select a movie from the Moviegalaxies dataset and visualize its social graph. The user can also download the network data (in a weighted edge list format) for additional analysis. Please see https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/T4HBA3 for additional details about how the dataset was created. We would like to acknowledge the creators of the dataset. 

Kaminski, Jermain; Schober, Michael; Albaladejo, Raymond; Zastupailo, Oleksandr; Hidalgo, César, 2018, "Moviegalaxies - Social Networks in Movies", https://doi.org/10.7910/DVN/T4HBA3, Harvard Dataverse, V3 

## Purpose 

I teach a class on network analysis in psychological science and the original [Moviegalaxies website](https://moviegalaxies.com/) has been very useful to help illustrate several network concepts to my students. However, the website is no longer working, and I wanted to have a way for my students to explore the movie data without relying on the website being available. 

Because my students are learning how to use R and RStudio to conduct network analyses it makes sense to implement it as a R Shiny app. It can be easily hosted on a website (see http://r-serer.csqsiew.xyz/movie-networks) to see application in action), but one can also easily download all of the files in this repo and load the Shiny application locally. 

## How to Use  

### local deployment

Assumes you have R and RStudio installed and know your way around it.

The following packages are needed: `shiny, igraph, tidyverse, rgexf` - install via `install.packages('PackageName')`

Download the files in this repository by clicking on 'Code', 'Download ZIP'.

Open the `app.R` file in Rstudio, make sure your working directory is pointed to wherever the app files are at, and then click on 'Run App'.

### online app

A demo of this application can be found here: http://r-server.csqsiew.xyz/movie-networks

## Final notes

last updated: 30th April 2023  

Please feel free to adapt for your own use.

If you found this useful, feel free to tip me here: https://ko-fi.com/csqsiew or check out my work here: http://hello.csqsiew.xyz/

Thanks! :)
