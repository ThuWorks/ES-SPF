check_syn_wfo_one = function(wfo_checklist, column, folder) {
  
  cat(cc$aquamarine("Starting the WFO.one synonym filtering \n"))
  
  wfo_one_checklist = WFO.one(WFO.result = wfo_checklist, priority = "Accepted", spec.name = column, verbose = T, counter = 1)
  
  for (name in names(wfo_one_checklist)[sapply(wfo_one_checklist, is.character)]) {
    wfo_one_checklist[[name]] = enc2utf8(wfo_one_checklist[[name]])
  }
  
  if (!dir.exists(paste0("./outputs/", folder))) dir.create(paste0("./outputs/", folder))
  
  fwrite(wfo_one_checklist, paste0("./outputs/", folder, "/wfo_one_checklist.csv"), bom = T)
  
  cat(cc$aquamarine("WFO_one results recieved \n"))
  
  return(wfo_one_checklist)
}