library(shiny)
raw <- read.csv("data/timelycare.csv", strip.white = TRUE, na.strings = c("Not Available",""))
raw <- raw[order(raw$Score),]
raw$Minutes <- raw$Score
dispcols <- c("Minutes","Sample","Hospital.Name","Address","City","State","ZIP.Code","County.Name")
selected <- rep(TRUE,nrow(raw))

# returns string w/o leading whitespace
trim.leading <- function (x)  sub("^\\s+", "", x)

# returns string w/o trailing whitespace
trim.trailing <- function (x) sub("\\s+$", "", x)

# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)


myxlab <- function(sel){
    paste(sum(sel)," hospitals selected \n"," distribution of average times in selected sample")
}

# Define server logic required to draw box plot
shinyServer(function(input, output) {
    
 
    output$box <- renderPlot({
        
        abb <- state.abb[which(state.name==input$state)]
        selected <- raw$State==abb
        
        zip <- trim(input$zip)
        if (0 != nchar(zip)) {
            selected <- as.numeric(zip)==raw$ZIP.Code %/% (10^(5-nchar(zip)))
        }        

        boxplot(raw$Minutes[selected],ylab="minutes to diagnosis",col="red")
        title(myxlab(selected))
    })
    
    output$seltab <- renderTable({
        
        abb <- state.abb[which(state.name==input$state)]
        selected <- raw$State==abb
        
        zip <- trim(input$zip)
        if (0 != nchar(zip)) {
            selected <- as.numeric(zip)==raw$ZIP.Code %/% (10^(5-nchar(zip)))
        }   
        
        out <- raw[selected,dispcols]
        out[order(out$County.Name,out$Minutes),]
    })
})