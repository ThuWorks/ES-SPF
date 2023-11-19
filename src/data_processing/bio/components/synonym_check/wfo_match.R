check_syn_wfo <- function(checklist, column, folder) {
  
  if (!"data.table" %in% class(checklist) && !"data.frame" %in% class(checklist)) {
    stop("The input data is not in the 'data.table' or 'data.frame' format.", print(class(checklist)))
  }
  
  cat("Running the WFO synonym check with column:", cc$aquamarine(column), "for table: \n")
  print(head(checklist, 3))
  cat("Number of species to analyse: ", yellow(nrow(checklist)), "\n")
  cat(yellow("Expected waiting time in hours: ", round((((nrow(checklist) * 3.63) / 60) / 60), digits = 2), "hours \n"))
  cat(yellow("Expected waiting time in minutes: ", round(((nrow(checklist) * 3.63) / 60), digits = 2), "minutes \n"))
  
  startTime <- Sys.time()
  wfo_checklist <- WFO.match(spec.data = checklist, spec.name = column, WFO.file = WFO_file, verbose = T, counter = 1)

  for (name in names(wfo_checklist)[sapply(wfo_checklist, is.character)]) {
    wfo_checklist[[name]] <- enc2utf8(wfo_checklist[[name]])
  }

  if (!dir.exists(paste0("./outputs/", folder))) dir.create(paste0("./outputs/", folder))

  fwrite(wfo_checklist, paste0("./outputs/", folder, "/wfo_checklist.csv"), bom = T)

  endTime <- Sys.time()
  cat("WFO completed the match for the checklist in: ", format_elapsed_time(startTime, endTime), "\n")

  cat(cc$aquamarine("WFO synonym check completed \n"))

  return(wfo_checklist)
}
