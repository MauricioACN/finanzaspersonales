# app modificada

source("global.R", encoding = "UTF-8")
source("functions.R", encoding = "UTF-8")

#
ui <- navbarPage("Finanzas Personales",
                 tabPanel("Registra",fluidPage(theme = shinytheme("flatly")),
                          tags$head(
                              tags$style(HTML(".shiny-output-error-validation{color: red;}"))),
                          pageWithSidebar(
                              headerPanel('Datos de Ingreso'),
                              sidebarPanel(width = 4,
                                           textInput('nombre', 'Dime quien eres?',""),
                                           dateInput('fecha',label = "Fecha de transacción"),
                                           selectInput('modelo', 'Selecciona un modelo de informe:',categorias$Modelo,selected = ""),
                                           p("Recuerda que debe seleccionar siempre el mismo modelo de informe, lee los detalles de cada informe en la pestaña Información.",style = "font-family: 'times'; font-si16pt"),
                                           hr(),
                                           selectInput('rubro', 'Selecciona un rubro:',categorias$Rubro,selected = ""),
                                           selectInput('categoria', 'Selecciona una categoria:',categorias$Categoria,selected = ""),
                                           selectInput('subcategoria', 'Selecciona una subcategoria:',categorias$SubCategoria,selected = ""),
                                           numericInput("valor","Agrega el valor correspondiente:",value = 0),
                                           submitButton("Agregar Registro")
                              ),
                              mainPanel()#uiOutput(outputId = "grafica"))
                          )),
                 tabPanel("Presupuesto",p("Aquí puedes ver la nube de palabras según los filtros de la página anterior", ":",style = "font-size:25px"),
                          hr(),
                          mainPanel()#uiOutput(outputId = "grafica1"),width = "1200px")
                 ),
                 tabPanel("Tabla de Resumen",p("Aquí puedes ver los mensjaes según los filtros de la página anterior", ":",style = "font-size:25px"),
                          hr(),
                          mainPanel()#uiOutput(outputId = "tabla"),width = "1200px")
                 ),
                 tabPanel("Proyecciones",p("Aquí puedes ver los mensjaes por sentimiento según los filtros de la página anterior", ":",style = "font-size:25px"),
                          hr(),
                          mainPanel()#uiOutput(outputId = "tabla2"),width = "1200px")
                 ),
                 tabPanel("Información",
                          p(a("Mauricio Cano", href="https://www.linkedin.com/in/mauricioacano/", target="_blank"),style = "font-size:25px"),
                          p("e-mail: alejandrocanomn@gmail.com",style = "font-size:20px"))
                 
)



server <- function(input, output, session) {
    
}

shinyApp(ui = ui,server = server)
