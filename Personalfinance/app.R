# app modificada

source("global.R")
source("functions.R")
#source("drop_access.R")

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
                                           selectInput('modelo', 'Selecciona un modelo de informe:',unique(categorias$Modelo)),
                                           p("Recuerda que debe seleccionar siempre el mismo modelo de informe, lee los detalles de cada informe en la pestaña Información.",style = "font-family: 'times'; font-si16pt"),
                                           selectInput('rubro', 'Selecciona un rubro:',choices = NULL),
                                           selectInput('categoria', 'Selecciona una categoria:',choices = NULL),
                                           selectInput('subcategoria', 'Selecciona una subcategoria:',choices = NULL),
                                           numericInput("valor","Agrega el valor correspondiente:",value = 0),
                                           actionButton(inputId = "button","Agregar Registro")
                              ),
                              mainPanel(textOutput("mensjae"), tags$hr())
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
    

  observeEvent(input$modelo,{
    
    updateSelectInput(session,inputId = "rubro", 
                      choices = unique(categorias$Rubro[categorias$Modelo==input$modelo]))
    
  })
  
  observeEvent(input$rubro,{
    
    updateSelectInput(session,inputId = "categoria", choices = unique(categorias$Categoria[categorias$Rubro==input$rubro&categorias$Modelo==input$modelo]))
    
  })
  
  observeEvent(input$categoria,{
    
    updateSelectInput(session,inputId = "subcategoria", choices = unique(categorias$SubCategoria[categorias$Categoria==input$categoria&categorias$Rubro==input$rubro&categorias$Modelo==input$modelo]))
    
  })
  
  
  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })
  
  # Show the previous responses
  # (update with current response when Submit is clicked)
  
    # When the Submit button is clicked, save the form data
  
  
  observeEvent(input$button, {
    
    saveData(formData())
  })
  
  
  datos_me = reactive({
    
    datos = loadData()
    datos = datos %>% filter(nombre==input$nombre)
    datos
    
  }) 
  
  output$mensjae <- renderText({
    
    if(input$nombre==""){
      
      print(paste("¡Hola! dejame saber quien eres"))
      
    }
    else if(nrow(datos_me())==0&input$nombre!=""){
      
      print(paste(input$nombre, "aún no tengo registros tuyos por favor completa la información para empezar el seguimiento de tus finanzas."))
      
    }
    else{
      print(paste("Hola",input$nombre,"es un gusto tenerte aquí. Por favor ingresa la información solicitada. Tu última actualización se realizó el",max(datos_me()$fecha))) 
    }
    
  })
    
}

shinyApp(ui = ui,server = server)
