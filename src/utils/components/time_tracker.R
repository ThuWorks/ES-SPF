# Create a list to store the timers
timers <- list()

start_timer <- function(id) {
  timers[[id]] <- list(start_time = Sys.time())
  cat(magenta(paste("Time tracking started for timer", id, "...\n")))
}

end_timer <- function(id) {
  if(is.null(timers[[id]])) {
    cat(magenta(paste("Error: Timer", id, "was not started.\n")))
  } else {
    end_time <- Sys.time()
    time_diff <- as.numeric(difftime(end_time, timers[[id]]$start_time, units = "secs"))
    
    days <- floor(time_diff / (24*60*60))
    time_diff <- time_diff - (days*24*60*60)
    
    hours <- floor(time_diff / (60*60))
    time_diff <- time_diff - (hours*60*60)
    
    minutes <- floor(time_diff / 60)
    seconds <- time_diff - (minutes*60)
    
    cat(magenta(paste("Time elapsed for timer", id, ": ", days, "days", hours, "hours", minutes, "minutes", round(seconds, 2), "seconds\n")))
  }
}