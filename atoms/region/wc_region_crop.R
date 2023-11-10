wc_to_region = function(region, scope, plot = T) {
  #Load worldClim data
  bioVars = worldclim_global(var="bio", scope, "resources", version="2.1")
  
  #Check bioVars properties 
  bioVars
  crs(bioVars, proj = T, describe = T)
  units(bioVars)
  
  #Crop WorldClim data to Arctic CAVM
  crop = crop(bioVars, region)
  #plot(crop)
  bioVarsMask = mask(crop, region)
  
  if (plot == T) plot(bioVarsMask) else {cat("Plotting skipped")}
  
  
  return(bioVarsMask)
}