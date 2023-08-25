library(plumber)
library(plumbertableau)

#* @apiTitle Demo Penguins
#* @apiDescription A demo showing how to combine R and Tableau

#* Capitalize incoming text
#* @tableauArg str_value:[character] Strings to be capitalized
#* @tableauReturn [character] A capitalized string(s)
#* @post /capitalize
function(str_value) {
  toupper(str_value)
}

#* Identify outliers
#* @tableauArg x:[numeric] A numeric vector
#* @tableauReturn [logical] A boolean vector, will be True for outlier values
#* @post /is_outlier
function(x) {
  rstatix::is_outlier(x, coef = 0.8)
}

# The Plumber router modifier tableau_extension is required. This object is a
# function that acts as a plumber router modifier. For more details, see the
# Plumber documentation:
# https://www.rplumber.io/articles/annotations.html#plumber-router-modifier
#* @plumber
tableau_extension
