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
                                  )
                          )
                        )
                      )
)

