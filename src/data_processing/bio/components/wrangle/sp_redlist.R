wrangle_sp_redlist <- function(df = "./resources/data_raw/sp_status/redlist_no_2021.csv", column = "scientificName") {
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

  rl_formatted[[column]] <- paste0(rl_formatted$species, " ", rl_formatted$author)
  
  rl_formatted <- set_df_utf8(rl_formatted)

  return(rl_formatted)
}
