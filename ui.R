################################################################################
# Shameer SUkha  - R Shiny project
# ui.R
################################################################################

# Main function to generate dashboard
shinyUI(dashboardPage(title = "CDS Dashboard",
                      # Put the data of the latest data as title
                      dashboardHeader(title = paste("Date",format(as.Date(file1,format="%Y%m%d"), "%d-%b-%Y"), sep=" : ")),
                      dashboardSidebar(
                        sidebarUserPanel("RMG User",image = "CIBC.png"),
                        sidebarMenu(
                          menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")
                                   ),
                          menuItem("Charts", icon = icon("bar-chart-o"),
                                   menuSubItem("Custom Average Charts", tabName = "charts1"),
                                   menuSubItem("Factor Charts", tabName = "charts2"),
                                   menuSubItem("Distribution Charts", tabName = "charts3")
                                   ),
                          menuItem("Data", tabName = "data", icon = icon("database")
                                   )
                          )
                        ),
                      dashboardBody(
                        tabItems(
                          # Use infoBoxes and charts to show the most important information
                          tabItem(tabName = "dashboard",
                                  # Create 4 fluid rows of 4 items each for the 8 most material variables
                                  fluidRow(
                                    infoBoxOutput("infoBox11", width=3),
                                    infoBoxOutput("infoBox12", width=3),
                                    infoBoxOutput("infoBox13", width=3),
                                    infoBoxOutput("infoBox14", width=3)
                                    ),
                                  fluidRow(
                                    infoBoxOutput("infoBox21", width=3),
                                    infoBoxOutput("infoBox22", width=3),
                                    infoBoxOutput("infoBox23", width=3),
                                    infoBoxOutput("infoBox24", width=3)
                                    ),
                                  fluidRow(
                                    box(title = "Cons. Cyclical : BB", status = "primary", 
                                        solidHeader = TRUE, htmlOutput("scat11"), width=3),
                                    box(title = "Cons. Non-Cycl. : BB", status = "primary",
                                        solidHeader = TRUE, htmlOutput("scat12"), width=3),
                                    box(title = "Financials : AA", status = "primary",
                                        solidHeader = TRUE, htmlOutput("scat13"), width=3),
                                    box(title = "Oil & Gas : A", status = "primary",
                                        solidHeader = TRUE, htmlOutput("scat14"), width=3)
                                    ),
                                  fluidRow(
                                    box(title = "Cons. Cyclical : B", status = "primary",
                                        solidHeader = TRUE, htmlOutput("scat21"), width=3),
                                    box(title = "Cons. Non-Cycl. : B", status = "primary",
                                        solidHeader = TRUE, htmlOutput("scat22"), width=3),
                                    box(title = "Financials : A", status = "primary",
                                        solidHeader = TRUE, htmlOutput("scat23"), width=3),
                                    box(title = "Oil & Gas : BBB", status = "primary",
                                        solidHeader = TRUE, htmlOutput("scat24"), width=3)
                                    )
                                  )
                          )
                        )
                      )
)

