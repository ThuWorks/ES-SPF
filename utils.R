pkgs = c(
  "RefManageR",
  "rgbif",
  "dplyr",
  "crayon",
  "stringr",
  "terra",
  "sf",
  "st",
  "data.table",
  "WorldFlora",
  "progressr"
)

source("./utils/check_updates.R")
updated <- check_updates(pkgs)

if (updated) {
  cat("Session needs to be restarted due to package updates or installations.\n")
  
  # Check if rstudioapi is available
  if ("package:rstudioapi" %in% search()) {
    rstudioapi::restartSession()
  } else {
    message("Please restart your R session manually.\n")
  }
}

cat("Creating reference list. \n")
pkg_citations <- lapply(pkgs, function(x) {
  tryCatch({
    cit <- citation(x)
    bib <- toBibtex(cit)
    return(bib)
  }, error = function(e) {
    return(NA)
  })
})

base_citation <- citation("base")
base_bibtex <- toBibtex(base_citation)

pkg_citations[["base"]] <- base_bibtex

# Write all citations to a file
writeLines(unlist(pkg_citations), "./outputs/references/citations.bib")

cat("Getting WFO file. \n")
# Download and remember WFO data if already downloaded, load file
if (!file.exists("./resources/classification.csv")) {
  cat(yeellow("A progress window pops up here, check your taskbar"))
  WFO.download(save.dir = "./resources/", WFO.remember = TRUE)
  WFO_file = "./resources/classification.csv"
  
  cat(yellow("Ignore Error code and rerun the utility script"))
} else {
  WFO_file = "./resources/classification.csv"
}

cat("Creating time tracker. \n")
# Time tracker
format_elapsed_time = function(start_time, end_time) {
  ### Calculate elapsed time in hours, minutes and seconds
  elapsed_time_hours = as.numeric(difftime(end_time, start_time, units = "hours"))
  elapsed_time_minutes = as.numeric(difftime(end_time, start_time, units = "mins"))
  elapsed_time_seconds = as.numeric(difftime(end_time, start_time, units = "secs"))
  
  ### Format elapsed time
  formatted_elapsed_time = paste(floor(elapsed_time_hours), "h", floor(elapsed_time_minutes) %% 60, "m", round(elapsed_time_seconds) %% 60, "s")
  
  return(formatted_elapsed_time)
}

cat("Creating utf8 function. \n")
# Set encoding to UTF8
set_df_utf8 <- function(df) {
  
  for (name in names(df)[sapply(df, is.character)]) {
    df[[name]] <- enc2utf8(df[[name]])
  }
  
  return(df)
}

cat("creating duplicate logger \n")
source("./utils/log_duplicates.R")


source("./utils/custom_colors.R")
cc <- custom_colors()
