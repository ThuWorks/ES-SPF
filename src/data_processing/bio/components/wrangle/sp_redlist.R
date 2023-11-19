wrangle_sp_redlist = function(df = "./resources/wrangle/sp_status/redlist_no_2021.csv", column = "scientificName") {
  cat(cc$aquamarine("Wrangling Redlisted species \n"))
  
  rl_preformatted <- fread(df)
  
  rl_formatted <- rl_preformatted %>%
    select(
      `Vitenskapelig navn`,
      Autor,
      Populærnavn,
      `Kategori 2021`,
    )
  
  colnames(rl_formatted) <- c("species", "author", "popularName", "riskCategory")
  
  rl_formatted[[column]] <- paste0(rl_formatted$species," ", rl_formatted$author)
  
  return(rl_formatted)
}