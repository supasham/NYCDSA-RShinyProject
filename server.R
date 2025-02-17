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
  
  
  # Server functions for first Charts item
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
  #############################################################################
  
  
  # Server functions for second Charts item
  #########################################
  
  # Create own color palettes for heatmaps, red as negative and blue as positive
  redpal <- c('#fff5f0','#fee0d2','#fcbba1','#fc9272','#fb6a4a','#ef3b2c','#cb181d','#a50f15','#67000d')
  redpal <- rev(redpal)
  bluepal <- c('#f7fbff','#deebf7','#c6dbef','#9ecae1','#6baed6','#4292c6','#2171b5','#08519c','#08306b')
  colors <- c(redpal, bluepal)
  
  # Create helper function to creat ggplot heatmaps for factors
  makefactorplots <- function(df, yvar, colorpalette) {
    ggplot(df, aes(x = reorder(as.character(Tenor), Tenor, FUN = max),
                   y = reorder(Category, Factor, FUN = mean))) +
      geom_tile(aes(fill = Factor)) +
      scale_fill_gradientn(colors = colorpalette,
                           breaks = seq(minfactor / 100, maxfactor / 100, by = 0.01),
                           labels = paste0(as.character(c(minfactor:maxfactor)), "%"),
                           limits = c(minfactor / 100, maxfactor / 100)
                           ) +
      labs(x = "Tenor", y = yvar) +
      theme_light() +
      facet_grid(. ~ Class)
  }
  
  # Create heatmaps for all factors
  output$ggall <- renderPlot({
    ggall <- makefactorplots(classdf, "All Factors", colors)
    ggall
  })

  output$ggregion <- renderPlot({
    ggregion <- makefactorplots(regiondf, "Region", colors)
    ggregion
  })

  output$ggsector <- renderPlot({
    ggsec <- makefactorplots(sectordf, "Sector", colors)
    ggsec
  })
  
  output$ggrating <- renderPlot({
    ggrating <- makefactorplots(ratingdf, "Rating", colors)
    ggrating
  })
  #############################################################################
  
  
  # Server functions for third Charts item
  #########################################
  output$ggdistbox <- renderPlot({
    bvar1 = input$radio31
    bvar2 = input$radio32
    
    ggdistbox <- avgdata %>%
      filter(., (Rating != "No Rating") & (Rating != "CCC")) %>%
      filter(., Tenor == bvar2) %>%
      ggplot(., aes(x = reorder(get(bvar1), ParSpreadMid.t, FUN = mean),
                    y = ParSpreadMid.t, fill = get(bvar1))) +
      geom_boxplot(alpha = 0.5) + 
      coord_flip() +
      labs(x = bvar1, y = "CDS spread") +
      theme_light() +
      theme(legend.position = "none")
    
    ggdistbox
  })
  
  output$ggdistdensity <- renderPlot({
    dvar1 = input$radio33
    dvar2 = input$radio34
    
    ggdistdensity <- avgdata %>%
      filter(., (Rating != "No Rating") & (Rating != "CCC")) %>%
      filter(., Tenor == dvar2) %>%
      ggplot(., aes(x = ParSpreadMid.t, fill = get(dvar1))) +
      geom_density(alpha = 0.25) +
      labs(x = "CDS Spread", y = "Frequency", fill = dvar1) +
      theme_light()
    
    ggdistdensity
  })
  #############################################################################
  
  
  # Server functions for data table item
  #########################################
  output$table <- DT::renderDataTable({
    datatable(factortbl, rownames = FALSE, filter = "top") %>%
      formatPercentage(3:13, digits = 2) %>%
      formatStyle("5", background = "skyblue", fontWeight = 'bold')
  })
  #############################################################################
  
  
})