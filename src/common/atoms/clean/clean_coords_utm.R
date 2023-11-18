clean_utm_coords <- function(df, long = "decimalLongitude", lat = "decimalLatitude") {
  cat("Some UTM longitude are blank: ", if (any(df[[long]] == "")) red("True") else green("False"), "\n")
  cat("Some UTM latitudes are blank: ", if (any(df[[lat]] == "")) red("True") else green("False"), "\n")

  # Replace commas with period
  df[[long]] <- gsub(",", ".", df[[long]])
  df[[lat]] <- gsub(",", ".", df[[lat]])

  # Change from string to numeric values
  df[[long]] <- as.numeric(df[[long]])
  df[[lat]] <- as.numeric(df[[lat]])

  cat("Some UTM latitude are blank: ", if (any(is.na(df[[lat]]))) red("True") else green("False"), "\n")
  cat("Some UTM longitude are NA: ", if (any(is.na(df[[long]]))) red("True") else green("False"), "\n")
  cat("All are number format: ", if (is.numeric(df[[long]]) && is.numeric(df[[lat]])) green("True") else red("False"), "\n")

  coords_utm <- cbind(df[[long]], df[[lat]])

  points_utm <- vect(coords_utm)

  polygon_utm <- as.polygons(points_utm)

  polygon_utm <- st_as_sf(polygon_utm)

  geom_utm <- st_geometry(polygon_utm)

  wkt_utm <- st_as_text(geom_utm)

  cat("UTM coordinates can be found in outputs/geometry/wkt_utm.txt \n")

  write(wkt_utm, "./outputs/geometry/wkt_utm.txt")

  cat(cc$aquamarine("UTM coordinates fixed \n"))
}
