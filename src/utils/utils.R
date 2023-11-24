pkgs <- c(
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

source("./src/utils/components/check_updates.R")
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
source("./src/utils/components/custom_colors.R")
cc <- custom_colors()

cat("Creating reference list. \n")
source("./src/utils/components/cite_packages.R")
cite_packages(pkgs, formats = "bibtex")

cat("Loading WFO file. \n")
source("./src/utils/components/wfo_backbone.R")

cat("Creating time tracker. \n")
source("./src/utils/components/time_tracker.R")

cat("Creating utf8 function. \n")
source("./src/utils/components/set_df_utf8.R")

cat("Creating duplicate logger. \n")
source("./src/utils/components/log_duplicates.R")

cat("Creating source all function. \n")
source("./src/utils/components/source_all.R")
