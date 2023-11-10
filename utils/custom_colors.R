custom_colors = function() {
  cat("Creating custom colors. \n")
  
  paleTurquoise = make_style("#AFEEEE")
  aquamarine = make_style("#7FFFD4")
  lightSteelBlue = make_style("#B0C4DE")
  
  
  return(
    list(
      paleTurquoise = paleTurquoise,
      aquamarine = aquamarine,
      lightSteelBlue = lightSteelBlue
    )
  )
}