clean_wgs_coords <- function(df, long = "decimalLongitude", lat = "decimalLatitude") {
  cat("Some WGS longitude are blank: ", if (any(df[[long]] == "")) red("True") else green("False"), "\n")
  cat("Some WGS latitudes are blank: ", if (any(df[[lat]] == "")) red("True") else green("False"), "\n")

  # Replace commas with periods
  df[[long]] <- gsub(",", ".", df[[long]])
  df[[lat]] <- gsub(",", ".", df[[lat]])

  # Make numeric
  df[[long]] <- as.numeric(df[[long]])
  df[[lat]] <- as.numeric(df[[lat]])

  cat("Some WGS latitude are blank: ", if (any(is.na(df[[lat]]))) red("True") else green("False"), "\n")
  cat("Some WGS longitude are NA: ", if (any(is.na(df[[long]]))) red("True") else green("False"), "\n")
  cat("All are number format: ", if (is.numeric(df[[long]]) && is.numeric(df[[lat]])) green("True") else red("False"), "\n")

  coords_wgs <- cbind(df[[long]], df[[lat]])

  points_wgs <- vect(coords_wgs)

  polygon_wgs <- as.polygons(points_wgs)

  polygon_wgs <- st_as_sf(polygon_wgs)

  geom_wgs <- st_geometry(polygon_wgs)

  wkt_wgs <- st_as_text(geom_wgs)

  cat("WGS coordinates can be found in outputs/region/wkt_wgs.txt \n")

  write(wkt_wgs, "./outputs/setup/region/wkt_wgs.txt")

  cat(cc$aquamarine("WGS coordinates fixed \n"))
}
