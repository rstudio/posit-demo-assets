#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)

#* @apiTitle Palmer Penguins API
#* @apiDescription An API to access the palmerspenguins data.


#* Get the penguins data.
#* 
#* Includes measurements for penguin species, island in Palmer Archipelago, 
#* size (flipper length, body mass, bill dimensions), and sex. This is a subset 
#* of penguins_raw.
#* @get /penguins
#* @param sample_size:int The number of rows to sample (optional). If no sample size is provided the entire data will be returned.
function(sample_size = NULL) {
  palmerpenguins::penguins_raw |> 
    sample_data(sample_size)
}


#* Get the raw penguins data.
#* 
#* Includes nesting observations, penguin size data, and isotope measurements 
#* from blood samples for adult Adélie, Chinstrap, and Gentoo penguins.
#* @get /penguins_raw
#* @param sample_size:int The number of rows to sample (optional). If no sample size is provided the entire data will be returned.
function(sample_size = NULL) {
  palmerpenguins::penguins_raw |> 
    sample_data(sample_size)
}


#' Sample data
#' 
#' @description A helper function to sample data.
#'
#' @param data 
#' @param sample_size 
#'
#' @return
sample_data <- function(data, sample_size) {
  if (is.null(sample_size)) {
    data
  } else {
    sample_size <- as.integer(sample_size)
    data |> 
      dplyr::slice_sample(n = sample_size)
  }
}


