library(tidyverse)

start_time <- Sys.time()

interests <- c('a','b','c','d','e')

loop_output_df <- tibble()

for (i in interests) {
  
  #sleep so this becomes a longer running job
  Sys.sleep(1)
  
  step_result_v <- paste('Result is: ', i) 
  
  step_result_df <- tibble('sentence' = step_result_v) 
  
  #check that each step is working <- for dev logging
  print(step_result_df$sentence, collapse = " ")
  
  loop_output_df <- bind_rows(loop_output_df, step_result_df)
} 

end_time <- Sys.time()

run_time <- difftime(end_time, start_time, "mins")

print(run_time)
