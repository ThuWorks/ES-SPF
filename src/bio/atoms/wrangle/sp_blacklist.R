wrangle_sp_blacklist = function(df = "./resources/wrangle/sp_status/blacklist_no_2023.csv", column = "scientificName") {
  cat(cc$aquamarine("Wrangling Blacklisted species \n"))
  
  bl_preformatted <- fread(df)
  
  bl_formatted <- bl_preformatted %>%
    select(
      `Vitenskapelig navn`,
      Autor,
      Populærnavn,
      Etableringsklasse,
      Fremmedartsstatus,
      `Risikokategori 2023`
    )
  
  colnames(bl_formatted) <- c("species", "author", "popularNameNO", "establishmentClass", "alienStatus", "riskCategory")
  
  bl_formatted[[column]] <- paste0(bl_formatted$species," ", bl_formatted$author)
  
  return(bl_formatted)
}
