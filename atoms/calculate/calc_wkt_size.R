calc_wkt_size <- function(wkt_string, return = FALSE) {
    
  coords <- strsplit(gsub("POLYGON\\(\\((.*)\\)\\)", "\\1", wkt_string), ",")[[1]]

  polygon <- matrix(as.numeric(unlist(strsplit(coords, " "))), ncol = 2, byrow = TRUE)

  sfg <- st_sfc(st_polygon(list(polygon)), crs = 4326)

  sfg_meters <- st_transform(sfg, crs = 3857)
  
  bbox <- st_bbox(sfg_meters)
  width_m <- round(bbox["xmax"] - bbox["xmin"], 2)
  width_km <- round(width_m / 1000, 2)
  
  length_m <- round(bbox["ymax"] - bbox["ymin"], 2)
  length_km <- round(length_m / 1000, 2)

  area_m <- round(width_m * length_m, 2)
  area_km <- round(area_m / 1000000, 2)

  radius_m <- round(sqrt(area_m / pi), 2)
  radius_km <- round(radius_m / 1000, 2)
  

  if (return == F) {
    
    cat("Width of area", cc$aquamarine(width_m), "m", green(" | "), cc$aquamarine(width_km), "km \n")
    cat("Length of area", cc$aquamarine(length_m), "m", green(" | "), cc$aquamarine(length_km), "km \n")
    cat("Radius of area", cc$aquamarine(radius_m), "m", green(" | "), cc$aquamarine(radius_km), "km \n")
    cat("Size of area", cc$aquamarine(area_m), "m^2", green(" | "), cc$aquamarine(area_km), "km^2 \n")
    
  } else {
    
    return(list(
      area_m,
      area_km,
      radius_m,
      radius_km,
      width_m,
      length_m,
      width_km,
      length_km
    ))
    
  }
}
