################################################################################
# Shameer SUkha  - R Shiny project
# server.R
################################################################################

# Main function
shinyServer(function(input, output){
  
  # Server functions for Dashboard item
  #####################################
  
  # Helper function to create text for InfoBoxes
  get_infobox_text <- function(sectori, ratingi, regioni, tenori) {
    boxval <- avgdata %>%
      filter(.,(Sector == sectori) &
               (Rating == ratingi) & 
               (Region == regioni) & 
               (Tenor == tenori)) %>%
      select(., sprdchanges)
    
    if (boxval < 0) {
      boxval <- paste0(as.character(round(boxval[1, 1], 1)), "bps")
    } else{
      boxval <- paste0("+", as.character(round(boxval[1, 1], 1)), "bps")
    }
    
    boxtext = paste(ratingi, paste0(as.character(tenori), "y"), sep = " : ")
    boxsub = sectori
    return(list(boxtext, boxval, boxsub))
  }
  
  
  
  # First 4 Infoboxes 
  #############################################################################
  output$infoBox11 <- renderInfoBox({
    box11 <- get_infobox_text("Consumer Cycl.", "BB", "North America", 5)
    
    infoBox(box11[1], value = box11[2], subtitle = box11[3],
            icon = icon("user-circle"), fill = FALSE,
            color = "light-blue", width = 3
            )
  })
    
  
  output$infoBox12 <- renderInfoBox({
    box12 <- get_infobox_text("Consumer Non-Cycl.", "BB", "North America", 5)
    
    infoBox(box12[1], value = box12[2], subtitle = box12[3],
            icon = icon("users"), fill = FALSE,
            color = "light-blue", width = 3
            )
  })
  
  output$infoBox13 <- renderInfoBox({
    box13 <- get_infobox_text("Financials", "AA", "North America", 5)
    
    infoBox(box13[1], value = box13[2], subtitle = box13[3],
            icon = icon("coins"), fill = FALSE,
            color = "olive", width = 3
            )
  })
  
  output$infoBox14 <- renderInfoBox({
    box14 <- get_infobox_text("Oil & Gas", "A", "North America", 5)
    
    infoBox(box14[1], value = box14[2], subtitle = box14[3],
            icon = icon("burn"), fill = FALSE,
            color = "yellow", width = 3
            )
  })
  #############################################################################
  
  # Second 4 Infoboxes
  #############################################################################
  output$infoBox21 <- renderInfoBox({
    box21 <- get_infobox_text("Consumer Cycl.", "B", "North America", 5)
    
    infoBox(box21[1], value = box21[2], subtitle = box21[3],
            icon = icon("user-circle"), fill = FALSE,
            color = "blue", width = 3
            )
  })
  
  output$infoBox22 <- renderInfoBox({
    box22 <- get_infobox_text("Consumer Non-Cycl.", "B", "North America", 5)
    
    infoBox(box22[1], value = box22[2], subtitle = box22[3],
            icon = icon("users"), fill = FALSE,
            color = "blue", width = 3
            )
  })
  
  output$infoBox23 <- renderInfoBox({
    box23 <- get_infobox_text("Financials", "A", "North America", 5)
    
    infoBox(box23[1], value = box23[2], subtitle = box23[3],
            icon = icon("coins"), fill = FALSE,
            color = "green", width = 3
            )
  })
  
  output$infoBox24 <- renderInfoBox({
    box24 <- get_infobox_text("Oil & Gas", "BBB", "North America", 5)
    
    infoBox(box24[1], value = box24[2], subtitle = box24[3],
            icon = icon("burn"), fill = FALSE,
            color = "orange", width = 3
            )
  })
  #############################################################################
  
  
  # Create helper functions to set options for Google charts 
  #############################################################################
  set_my_options = function(maxtenor){
    list(
      legend = "none",
      seriesType = "bars",
      series = "[{targetAxisIndex: 0},{targetAxisIndex: 1, type:'scatter'}]",
      vAxes = "[{title:'delta'}, {title:'CDS level'}]",
      hAxis.gridlines = "{color: '#333'}",
      hAxis = paste0("{title:'tenor(yrs)', minValue:1, maxValue:",
                     as.character(maxtenor),
                     ",ticks: [",
                     paste(as.character(c(1:maxtenor)), collapse=","),
                     "]}"),
      chartArea = "{height: 'automatic'}",
      explorer = "{actions:['dragToZoom','rightClickToReset']}"
      )
  }
  
  # First 4 Infoboxes 
  #############################################################################
  output$scat11 <- renderGvis({
    cht11 <- avgdata %>% 
      filter(., (Sector == "Consumer Cycl.") & 
               (Rating == "BB") & 
               (Region == "North America") & 
               (Tenor<=10)) %>%
      transmute(., Tenor, 
                CDS.change = round(sprdchanges,1), 
                CDS.today = round(ParSpreadMid.t,1))
    
    gvisComboChart(cht11, xvar="Tenor",
                   yvar=c("CDS.change", "CDS.today"),
                   options=set_my_options(10))
  })
  
  output$scat12 <- renderGvis({
    cht12 <- avgdata %>% 
      filter(., (Sector == "Consumer Non-Cycl.") & 
               (Rating == "BB") & 
               (Region == "North America") & 
               (Tenor<=10)) %>% 
      transmute(., Tenor,
                CDS.change = round(sprdchanges,1),
                CDS.today = round(ParSpreadMid.t,1))
    
    gvisComboChart(cht12, xvar="Tenor",
                   yvar=c("CDS.change", "CDS.today"),
                   options=set_my_options(10))
  })
  
  output$scat13 <- renderGvis({
    cht13 <- avgdata %>% 
      filter(., (Sector == "Financials") &
               (Rating == "AA") &
               (Region == "North America") &
               (Tenor<=10)) %>%
      transmute(., Tenor,
                CDS.change = round(sprdchanges,1),
                CDS.today = round(ParSpreadMid.t,1))
    
    gvisComboChart(cht13, xvar="Tenor",
                   yvar=c("CDS.change", "CDS.today"),
                   options=set_my_options(10))
  })
  
  output$scat14 <- renderGvis({
    cht14 <- avgdata %>% 
      filter(., (Sector == "Oil & Gas") & 
               (Rating == "A") & 
               (Region == "North America") & 
               (Tenor<=10)) %>%
      transmute(., Tenor,
                CDS.change = round(sprdchanges,1),
                CDS.today = round(ParSpreadMid.t,1))
    
    gvisComboChart(cht14, xvar="Tenor",
                   yvar=c("CDS.change", "CDS.today"),
                   options=set_my_options(10))
  })
  #############################################################################
  
  # Second 4 Infoboxes 
  #############################################################################
  output$scat21 <- renderGvis({
    cht21 <- avgdata %>% 
      filter(., (Sector == "Consumer Cycl.") &
               (Rating == "B") &
               (Region == "North America") &
               (Tenor<=10)) %>% 
      transmute(., Tenor,
                CDS.change = round(sprdchanges,1),
                CDS.today = round(ParSpreadMid.t,1))
    
    gvisComboChart(cht21, xvar="Tenor",
                   yvar=c("CDS.change", "CDS.today"),
                   options=set_my_options(10))
  })
  
  output$scat22 <- renderGvis({
    cht22 <- avgdata %>% 
      filter(., (Sector == "Consumer Non-Cycl.") &
               (Rating == "B") &
               (Region == "North America") &
               (Tenor<=10)) %>% 
      transmute(., Tenor, 
                CDS.change = round(sprdchanges,1), 
                CDS.today = round(ParSpreadMid.t,1))
    
    gvisComboChart(cht22, xvar="Tenor",
                   yvar=c("CDS.change", "CDS.today"),
                   options=set_my_options(10))
  })
  
  output$scat23 <- renderGvis({
    cht23 <- avgdata %>% 
      filter(., (Sector == "Financials") &
               (Rating == "A") &
               (Region == "North America") &
               (Tenor<=10)) %>% 
      transmute(., Tenor,
                CDS.change = round(sprdchanges,1),
                CDS.today = round(ParSpreadMid.t,1))
    
    gvisComboChart(cht23, xvar="Tenor",
                   yvar=c("CDS.change", "CDS.today"),
                   options=set_my_options(10))
  })
  
  output$scat24 <- renderGvis({
    cht24 <- avgdata %>% 
      filter(., (Sector == "Oil & Gas") &
               (Rating == "BBB") &
               (Region == "North America") &
               (Tenor<=10)) %>% 
      transmute(., Tenor,
                CDS.change = round(sprdchanges,1),
                CDS.today = round(ParSpreadMid.t,1))
    
    gvisComboChart(cht24, xvar="Tenor",
                   yvar=c("CDS.change", "CDS.today"),
                   options=set_my_options(10))
  })
  #############################################################################
  
  # Server functions for First Charts item
  ########################################
  output$chart11 <- renderGvis({
    chtdata11 <- avgdata %>%
      filter(., (Sector == input$sectorselected1) &
               (Rating == input$ratingselected1) &
               (Region == input$regionselected1)) %>%
      transmute(., Tenor,
                CDS.change = round(sprdchanges, 1),
                CDS.today = round(ParSpreadMid.t, 1))
    
    gvisComboChart(chtdata11, xvar = "Tenor", yvar = c("CDS.change", "CDS.today"),
                   options = set_my_options(30))
  })
  
  output$chart12 <- renderGvis({
    chtdata12 <- avgdata %>%
      filter(., (Sector == input$sectorselected2) &
               (Rating == input$ratingselected2) &
               (Region == input$regionselected2)) %>%
      transmute(., Tenor,
                CDS.change = round(sprdchanges, 1),
                CDS.today = round(ParSpreadMid.t, 1))
    
    gvisComboChart(chtdata12, xvar = "Tenor", yvar = c("CDS.change", "CDS.today"),
                   options = set_my_options(30))
  })
  
  
  
  
})