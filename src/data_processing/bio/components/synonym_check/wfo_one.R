check_syn_wfo_one <- function(wfo_checklist, column, folder) {
  cat(cc$aquamarine("Starting the WFO.one synonym filtering \n"))

  wfo_one_checklist <- WFO.one(WFO.result = wfo_checklist, priority = "Accepted", spec.name = column, verbose = T, counter = 1)

  wfo_one_checklist <- set_df_utf8(wfo_one_checklist)

  if (!dir.exists(paste0("./outputs/data_processing/", folder))) dir.create(paste0("./outputs/data_processing/", folder), recursive = T)

  fwrite(wfo_one_checklist, paste0("./outputs/data_processing/", folder, "/wfo_one_checklist.csv"), bom = T)

  cat(cc$aquamarine("WFO_one results recieved \n"))

  return(wfo_one_checklist)
}
