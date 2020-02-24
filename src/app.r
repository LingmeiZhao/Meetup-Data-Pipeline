library(shiny)
library(shinydashboard)
library(tidyverse)
library(cowplot)


top_ten_group <- read_csv("/home/zhaolingmei/Documents/Hadoop/data/joinedGroup.csv")
top_ten_group_selected <- top_ten_group %>% rename(
  groupID = joinedgroup.groupid,
  count = joinedgroup.count,
  groupName = joinedgroup.groupname
) %>% select(groupName, count) %>% slice(1:10)



top_ten_category <- read_csv("/home/zhaolingmei/Documents/Hadoop/data/joinedCategory.csv")

top_ten_category_selected <- top_ten_category %>% rename(
  categoryID = joinedcategory.categoryid,
  count = joinedcategory.count,
  categoryName = joinedcategory.categoryname
) %>% select(categoryName, count)

top_ten_city <- read_csv("/home/zhaolingmei/Documents/Hadoop/data/groupByCity.csv")

top_ten_city_selected <- top_ten_city %>% rename(
  cityName = groupbycity.city,
  count = groupbycity.count
) %>% slice(1:10)

top_ten_country <- read_csv("/home/zhaolingmei/Documents/Hadoop/data/groupByCountry.csv")

top_ten_country_selected <- top_ten_country %>% rename(
  countryName = groupbycountry.country,
  count = groupbycountry.count
)

ui <- dashboardPage(
  dashboardHeader(title = "Meetup Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(strong("Hot List"), tabName = "ranking")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("ranking",
              fluidRow(
               valueBoxOutput("users", width = 2),
               valueBoxOutput("comments", width = 2),
               valueBoxOutput("groups", width = 2),
               valueBoxOutput("categories", width = 2),
               valueBoxOutput("cities", width = 2),
               valueBoxOutput("countries", width = 2)
              ),
              
              fluidRow(
                box(
                  width = 4,status = "info", solidHeader = FALSE, background = "blue",
                  title = "Top Ten Hot Meetup Groups From Last 24 Hours", height = 500,
                  tableOutput("topTenGroups")
                ),
                box(
                  width = 5, status = "info", solidHeader = TRUE,
                  title = "Top Ten Hot Meetup Categories/Cities From Last 24 Hours", height = 900,
                  plotOutput("topTenCategories", width = "100%", height = 400),
                  plotOutput("topTenCities", width = "100%", height = 400)
                ),
                box(
                  width = 3,status = "info", solidHeader = FALSE, background = "blue",
                  title = "Top Ten Counries with Hottest Meetup Discussion From Last 24 Hours", height = 500,
                  tableOutput("topTenCountries")
                )
              )
      )
    )
  )
)

server <- function(input, output) {
  
  output$users <- renderValueBox({
    valueBox(
      value = "6000",
      subtitle = "Users",
      color = "olive"
    )
  })
  
  output$comments <- renderValueBox({
    valueBox(
      value = "16789",
      subtitle = "Comments",
      color = "olive"
    )
  })
  
  output$groups <- renderValueBox({
    valueBox(
      value = "3000",
      subtitle = "Groups",
      color = "olive"
    )
  })
  
  output$categories <- renderValueBox({
    valueBox(
      value = 35,
      subtitle = "Categories",
      color = "olive"
    )
  })
  
  output$countries <- renderValueBox({
    valueBox(
      value = "10",
      subtitle = "Countries",
      color = "olive"
    )
  })
  
  output$cities <- renderValueBox({
    valueBox(
      value = "100",
      subtitle = "Cities",
      color = "olive"
    )
  })
  
  output$topTenGroups <- renderTable(top_ten_group_selected, spacing = "m")
  
  output$topTenCategories <- renderPlot({
    top_ten_category_selected %>% mutate(
      categoryName = fct_reorder(categoryName, count)
    ) %>% ggplot(aes(x = categoryName, y = count)) + 
      geom_col(fill = "steelblue", width = 0.7, alpha = 0.8)+ coord_flip() + theme_minimal_vgrid() +
      labs(y = "Number of Comments Belong to the Category",
           x = "Category Name")
    }) 
  
    output$topTenCities <- renderPlot({
      top_ten_city_selected %>% mutate(
        cityName = fct_reorder(cityName, count)
      ) %>% ggplot(aes(x = cityName, y = count)) + 
        geom_col(fill = "steelblue", width = 0.7, alpha = 0.8)+ coord_flip() + theme_minimal_vgrid() +
        labs(x = "City Name",
             y = "Number of Comments of Meetup in the City")
    })
    
    output$topTenCountries <- renderTable(top_ten_country_selected, spacing = "m")
  
}


options(shiny.port=8888)
shinyApp(ui, server)
