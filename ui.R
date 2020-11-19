################################################################################
# Shameer SUkha  - R Shiny project
# ui.R
################################################################################

# Main function to generate dashboard
shinyUI(dashboardPage(title = "CDS Dashboard",
                      dashboardHeader(title = "CDS Dashboard"),
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
                        )
                      )
)

