# ui.R

shinyUI(fluidPage(
    titlePanel("Predicting Word"),
    
    fluidRow(
        column(12,
            br(),
            h4("1. Type a phrase in the box below."),
            br(),
            h4("2. The shiny app run to predict the next word."),
            br(),
            h4("3. A sugguested word appears in the text box."),
            br(),
            br()
        )
    ),
    
    fluidRow(
        column(6,
            textInput("input_str", 
                label = "Enter text without punctuation:", 
                value = " "
            )             
        )    
    ),
    fluidRow(
        column(12,
            br(),
            br(),
            h4("The predicted word:"), 
            verbatimTextOutput("text2")            
        )
    )
))