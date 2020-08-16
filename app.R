library(shiny)
data("mtcars")
library(ggplot2)

wdayvec <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
colors <- c("red", "blue")

ui <- fluidPage(
  textInput("Text", "Please insert some text", value = "text here"), 
  textAreaInput("textarea", "Insert a paragraph", value = ""), 
  numericInput("a number", "insert a number", value = 0, min =  0, max = 10, step = 1),
  sliderInput("slider1", "Insert a number",
              min = 0, max = 10, value = c(5, 7), animate = TRUE),
  dateInput("adate", "insert a date please"),
  dateRangeInput("drange", "insert a date range"),
  selectInput("dayofweek", "What day is it", choices = wdayvec),
  radioButtons("dayofweek2", "what day is it?", choices = wdayvec),
  checkboxGroupInput("dayofweek3", "What day were you born", choices = wdayvec, inline = TRUE),
  varSelectInput("varname", "Which Column", data = mtcars),
  checkboxInput("checkbox", "Do you like star trek", value = TRUE),
  fileInput("filename", "what file"),
  actionButton("button", "Click Me!"),
  textInput("tex", "add a to ..."),
  textOutput("aadded"),
  plotOutput("plot"),
  varSelectInput("var1", "Variable 1", data = mtcars),
  varSelectInput("var2", "Variable 2", data = mtcars),
  plotOutput("plotz"),
  radioButtons("redorblue", "pick point color", choices = colors),
  
  
  
  
  
  
)

server <- function(input, output, session) {
  output$aadded <- renderText({
    input$tex
  })
  output$plot <- renderPlot({
    ggplot(mpg, aes(x = displ, y = hwy)) +
      geom_point() +
      theme_bw() +
      xlab("Displacement") +
      ylab("Highway MPG")
  })
  output$plotz <- renderPlot({
    ggplot(mtcars, aes(x = !!input$var1, y = !!input$var2, color = input$redorblue)) +
      geom_point(color = input$redorblue) +
      xlab("Plot 2 Variables")
      
  })
}

shinyApp(ui, server)


