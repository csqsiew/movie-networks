# shiny application to visualize social networks of movies 
# raw data from: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/T4HBA3
# Author: CSQSiew
# last updated: 2023-05-20 

# set up 
library(shiny)
library(igraph)
library(rgexf) # for converting from gexf to igraph 
library(tidyverse)

data <- read_tsv('network_metadata.tab')
list_of_movies <- data$Title

# front matter 
ui <- fluidPage(

    pageWithSidebar(
      headerPanel('Movie Networks'),
      sidebarPanel(
       # input a movie 
        tags$h4('Select a movie from the list to visualize its social network.'),
       selectizeInput(
          'foo', label = NULL, choices = list_of_movies, multiple = FALSE, 
          options = list(maxItems = 1, placeholder = 'search for a movie!')
        ),
       br(),
       # Button to download data 
       tags$h5('Download network data'),
       downloadButton("downloadData", "Download"), 
        br(),
       br(),
       tags$h6("Movie data from:", tags$a(href="https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/T4HBA3", "https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/T4HBA3"), align="left"),
       tags$h6("Created by", tags$a(href="https://hello.csqsiew.xyz/", "CS"), align="left"),
      ),
      mainPanel(
       fluidRow(
          column(9,
                 plotOutput("distPlot", height = '1000') # to display the network plot 
          ),
        )
      )
  )
)
      

server <- function(input, output, session) {
  updateSelectizeInput(session, 'foo', choices = list_of_movies, server = TRUE)
 
  # reactive function to get the filename to retrieve the gexf file  
  the_filename <- reactive({
    paste0('gexf/', data$GexfID[which(data$Title == input$foo)], '.gexf')
  })
  
  # reaction function to get the graph object for plot and download 
  g <- reactive({  
    read.gexf(the_filename()) |>  gexf.to.igraph() 
    })
      
    output$distPlot <- renderPlot({
       
      comm_output <- cluster_louvain(g()) # use louvain method to discover clusters 
        
      par(mar=c(1,1,1,1))
      
      # note that all the g objects are reactive functions now and require `g()`  
      plot(g(), vertex.color = comm_output$membership, layout = layout_with_fr, 
              margin = c(0.1,0.1,0.1,0.1), frame = TRUE, vertex.frame.color = 'white',
              vertex.label.color = 'black', vertex.label.family = 'Helvetica',
              main = input$foo, # print movie title 
              edge.width = E(g())$weight/max(E(g())$weight)*10) # the most frequent pairing will always have a max edge size of 10 

    })
    
    # Downloadable csv of visualized network ----
    output$downloadData <- downloadHandler(
      filename = function() {
        paste('output', ".csv", sep = "")
      },
      content = function(file) {
        out_graph <- get.data.frame(g()) # edge list with weights, note g() as the network to be downloaded depends on the plot shown  
        write.csv(out_graph, file, row.names = FALSE)
      }
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
