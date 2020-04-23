

saveData <- function(data) {
  
  data = as.data.frame(t(data))
  datos_prev = loadData()
  datos_prev = prepocesing(datos_prev)
  data <- rbind(data,datos_prev)
  file_name <- sprintf("registros.csv")
  file_path <- file.path(tempdir(), file_name)
  datos = write.csv(data, file_path, row.names = FALSE, quote = TRUE)
  drop_upload(file_path, path = "datos_app")
}

loadData <- function() {
  
  # Read all the files into a list
  filesInfo <- drop_dir("datos_app")
  filePaths <- filesInfo$path_display
  data <- lapply(filePaths, drop_read_csv, stringsAsFactors = FALSE)
  # Concatenate all data together into one data.frame
  data <- do.call(rbind, data)
  data = prepocesing(data)
  data
  
}


prepocesing = function(data){
  
  data = data %>% mutate(fecha = as.Date(fecha, "%Y-%m-%d", origin ="1970-01-01"),
                         valor = as.numeric(valor))
  data 
    
}
