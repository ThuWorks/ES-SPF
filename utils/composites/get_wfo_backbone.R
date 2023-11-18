# Download and remember WFO data if already downloaded, load file
if (!file.exists("./resources/classification.csv")) {
  tryCatch({
    cat(yellow("A progress window pops up here, check your taskbar \n"))
    WFO.download(save.dir = "./resources/", WFO.remember = TRUE)
    
  }, error = function(e) {
    cat("Error in download: ", e$message, "\n")
    cat("Opening download page \n")
    
    browseURL("https://www.worldfloraonline.org/downloadData;jsessionid=D1501051E49AE20AB4B7297D021D6324")
    
  },   warning = function(w) {
    cat("Warning in download: ", w$message, "\n")
    cat("Opening download page \n")
    browseURL("https://www.worldfloraonline.org/downloadData;jsessionid=D1501051E49AE20AB4B7297D021D6324")
    
  }, finally = {
    WFO_file = "./resources/classification.csv"
  }
  )
} else {
  WFO_file = "./resources/classification.csv"
}