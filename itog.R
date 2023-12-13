install.packages("shiny")
install.packages("flexdashboard")
install.packages("dplyr")
install.packages("readxl")

# Загрузка необходимых библиотек
library(shiny)
library(flexdashboard)
library(dplyr)

# Загрузка данных
transaction_data <- read.csv("data/transaction_data.csv")
campaign_desc <- read.csv("data/campaign_desc.csv")
campaign_table <- read.csv("data/campaign_table.csv")
causal_data <- read.csv("data/causal_data.csv")
coupon <- read.csv("data/coupon.csv")
coupon_redempt <- read.csv("data/coupon_redempt.csv")
hh_demographic <- read.csv("data/hh_demographic.csv")
product <- read.csv("data/product.csv")

# UI для Shiny-приложения
ui <- fluidPage(
  titlePanel("Дашборд анализа транзакций"),

  # Sidebar layout with a input and output definitions
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
      # Выбор периода дня для анализа активности
      selectInput("time_period", "Выберите период дня:",
                  choices = c("До обеда", "После обеда"),
                  selected = "До обеда"),
    ),

    # Main panel for displaying outputs
    mainPanel(
      # Вывод графика или других результатов
      plotOutput("activity_plot")
    )
  )
)

# Server для Shiny-приложения
server <- function(input, output) {
  # Анализ активности в зависимости от выбранного периода дня
  output$activity_plot <- renderPlot({
    # Фильтрация данных в зависимости от выбранного периода дня
    filtered_data <- if (input$time_period == "До обеда") {
      filter(transaction_data, hour(timestamp) < 12)
    } else {
      filter(transaction_data, hour(timestamp) >= 12)
    }

    # Построение графика
    hist(filtered_data$amount, main = "Активность покупателей",
         xlab = "Сумма покупок", col = "skyblue", border = "black")
  })
}

# Запуск Shiny-приложения
shinyApp(ui = ui, server = server)
                                                                                    