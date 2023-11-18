check_synonyms = function(checklist, column, taxon_name) {
  # Run synonym check on the species
  source("./atoms/check/wfo_match.R")
  sp_synonyms = check_syn_wfo(checklist, column, taxon_name)
  
  # Select best match and remove duplications
  source("./atoms/check/wfo_one.R")
  sp_checked = check_syn_wfo_one(sp_synonyms, column, taxon_name)
  
  return(sp_checked)
}