

saveData <- function(data) {
  
  # data <- as.data.frame(t(data))
  # 
  #   if(exists("responses")){
  #     
  #     data <<-rbind(responses,data)
  #   }
  # else{
  #   
  #   data <<- data
  # }

  #data <- rbind(base_cargada,data)
  file_name <- sprintf("registros.csv")
  file_path <- file.path(tempdir(), file_name)
  write.csv(data, file_path, row.names = FALSE, quote = TRUE)
  drop_upload(file_path, path = "datos_app")
}

loadData <- function() {
  
  # Read all the files into a list
  filesInfo <- drop_dir("datos_app")
  filePaths <- filesInfo$path_display
  data <- lapply(filePaths, drop_read_csv, stringsAsFactors = FALSE)
  # Concatenate all data together into one data.frame
  data <- do.call(rbind, data)
  data
}



