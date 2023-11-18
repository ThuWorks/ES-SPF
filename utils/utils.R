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

source("./utils/composites/check_updates.R")
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

cat("Creating custom colors. \n")
source("./utils/composites/custom_colors.R")
cc <- custom_colors()

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

cat("Loading WFO file. \n")
source("./utils/composites/get_wfo_backbone.R")

cat("Creating time tracker. \n")
source("./utils/composites/time_tracker.R")

cat("Creating utf8 function. \n")
source("./utils/composites/set_df_utf8.R")

cat("Creating duplicate logger \n")
source("./utils/composites/log_duplicates.R")
