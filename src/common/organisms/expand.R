source("./molecules/clean/wkt.R")
source("./atoms/region/expand_vect.R")
source("./atoms/calculate/calc_wkt_size.R")

expand_region <- function(wkt = NULL, shape = NULL, exp_distance = 0) {
  
  if (!is.null(wkt)) {
    cat("Using WKT to expand region \n")
    print(wkt)
    # First clean the wkt
    cleaned_wkt <- clean_wkt(wkt)
    # Then expand
    exp_wkt <- expand_vect(cleaned_wkt, exp_distance)
  } 
  else if (!is.null(shape)) {
    cat("Using shape to expand region \n")
    
    exp_wkt <- expand_vect(shape, exp_distance)
    
  } else {
    cat(red("Error: missing or invalid shapefile or WKT string \n"))
  }
  
  # clean wkt again
  cleaned_wkt_check <- clean_wkt(exp_wkt)
  
  calc_wkt_size(exp_wkt)
  
  return(exp_wkt)
}