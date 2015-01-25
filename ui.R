shinyUI(fluidPage(
    titlePanel(em("Which Hospital Should I Go to In an Emergency?")),
    
    sidebarLayout(
        sidebarPanel(
            helpText("The nearest emergency room may not be the place where you get treated most quickly. This app lets you see
                     the mean time to diagnosis for various emergency rooms in the United States over a one year period."),
            helpText("It might make sense to drive an extra five minutes to a hospital slightly further away."),
            helpText(em("Note that if you have a serious emergency it's likely you will be treated promptly. But what if it's
                     just a sprain?")),
            selectInput("state", label = h6("Pick a state"), 
                        choices = state.name, selected = "Maryland"),
            helpText(""),
            helpText(h5("----------------- or ----------------")),
            textInput("zip",label=h6("Enter the first few numbers of the desired zip code (up to five digits). 
                                     Please note that many full zip codes have no associated hospitals and that
                                     the nearest hospital may be in an adjacent county. Erase
                                     zip code entry to return to state selection."), value = '    '),
            tags$style(type='text/css',"#zip{width:40px}"),
            helpText(h4("Notes")),
            p("Data for this app was downloaded from:",
              a("Data.Medicare.gov", target="_blank",
                href="https://data.medicare.gov/Hospital-Compare/Timely-and-Effective-Care-Hospital/yv7e-xc69"),
              "selecting for Measure.ID = OP_20,",em(" Door to diagnostic eval.")),
            helpText("The data covers one year starting April 2013."),
            helpText("There may be some variance in reporting practices between hospitals."),
            helpText("In order to help you locate the nearest hospital, the table to the right is sorted by county
                     and then by minutes to evaluation."),
            helpText("Note that zip codes are not a perfect proxy for closeness in all parts of the United States.")
                 ),
        mainPanel(
            plotOutput("box"),
            tableOutput("seltab")
    ))
))