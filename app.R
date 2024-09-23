# 필요한 패키지 로드
library(shiny)
library(ggplot2)

# 샘플 데이터 생성
data <- data.frame(
  category = rep(c("A", "B", "C"), each = 50),
  values = c(rnorm(50, mean = 10, sd = 3),
             rnorm(50, mean = 15, sd = 5),
             rnorm(50, mean = 20, sd = 2))
)

# UI 정의
ui <- fluidPage(
  titlePanel("Box Plot Example"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("category", "Select Category:", 
                  choices = unique(data$category), 
                  selected = "A")
    ),
    
    mainPanel(
      plotOutput("boxPlot")
    )
  )
)

# 서버 로직 정의
server <- function(input, output) {
  
  # 박스 플롯 생성
  output$boxPlot <- renderPlot({
    ggplot(subset(data, category == input$category), aes(x = category, y = values)) +
      geom_boxplot() +
      labs(title = paste("Box Plot for Category", input$category),
           x = "Category",
           y = "Values") +
      theme_minimal()
  })
}

# Shiny 앱 실행
shinyApp(ui = ui, server = server)
