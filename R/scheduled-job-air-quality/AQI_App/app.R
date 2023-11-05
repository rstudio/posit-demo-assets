library(shiny)
library(shinydashboard)
library(ggplot2)
library(glue)
library(dplyr)
library(leaflet)


# ////////////////////////////////////////////////////////////////////////////
# Setup
# ////////////////////////////////////////////////////////////////////////////
board <- pins::board_rsconnect(
  server = "https://colorado.posit.co/rsc",
  key = Sys.getenv("CONNECT_API_KEY"),
)

aqi_info <- pins::pin_read(
  board,
  "katie.masiello/aqi_readings"
)


# ////////////////////////////////////////////////////////////////////////////
# UI
# ////////////////////////////////////////////////////////////////////////////
ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "Seattle Area Air Quality"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    box(title = "Site Name",
        leafletOutput("map"),
        width = 12
    ),
    box("Click a site to show AQI plot",
        width = 12,
        plotOutput("plot")
    )
  )
)

# ////////////////////////////////////////////////////////////////////////////
# Server
# ////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {
  
  # Draw Site Map ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  output$map <- renderLeaflet({
    aqi_info |> 
      leaflet()  |> 
      addTiles() |> 
      setView(
        lng = median(aqi_info$Longitude),
        lat = median(aqi_info$Latitude),
        zoom = 8
      ) %>%
      addAwesomeMarkers(
        lng = ~Longitude,
        lat = ~Latitude,
        layerId = ~Site_Name,
        icon = awesomeIcons(
          "circle",
          library = "fa",
          iconColor = "white",
          markerColor = "cadetblue"
        ),
        label = ~paste0(Site_Name)
      )
  })
  
  

  
  # Create plot of AQI ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  output$plot <- renderPlot({
    req(input$map_marker_click)
    
    selected_site_info <-
      aqi_info |> 
      filter(Site_Name == input$map_marker_click$id) |> 
      head(1)
  
    aqi_info |>
      filter(Pollutant == "PM2.5") |> 
      filter(Site_Name == selected_site_info$Site_Name) |>
      ggplot(aes(x = UTC, y = AQI)) +
      ggtitle(glue::glue("Air Quality at {selected_site_info$Site_Name}")) +
      geom_line() +
      theme_minimal() +
      labs(x = "Date Time", y = "Air Quality Index (AQI)") +
      geom_hline(yintercept = 50, linetype = 2)
  
  })
  
}

# ////////////////////////////////////////////////////////////////////////////
# Run the app
# ////////////////////////////////////////////////////////////////////////////
shinyApp(ui = ui, server = server)