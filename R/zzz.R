# via: http://www.epa.gov/envirofw/html/codes/state.html
#
# this somewhat duplicates "state_codes" but it's primarily intended
# to validate_state. A TODO might be to refactor the code to eliminate this
# but put "state_codes" to all lowercase for utility functions and then
# use string transformations when presenting messages to the user

fips_state_table <- structure(list(abb = c("ak", "al", "ar", "as", "az", "ca", "co",
"ct", "dc", "de", "fl", "ga", "gu", "hi", "ia", "id", "il", "in",
"ks", "ky", "la", "ma", "md", "me", "mi", "mn", "mo", "ms", "mt",
"nc", "nd", "ne", "nh", "nj", "nm", "nv", "ny", "oh", "ok", "or",
"pa", "pr", "ri", "sc", "sd", "tn", "tx", "ut", "va", "vi", "vt",
"wa", "wi", "wv", "wy", "mp"), fips = c("02", "01", "05", "60", "04",
"06", "08", "09", "11", "10", "12", "13", "66", "15", "19", "16",
"17", "18", "20", "21", "22", "25", "24", "23", "26", "27", "29",
"28", "30", "37", "38", "31", "33", "34", "35", "32", "36", "39",
"40", "41", "42", "72", "44", "45", "46", "47", "48", "49", "51",
"78", "50", "53", "55", "54", "56", "69"), name = c("alaska", "alabama",
"arkansas", "american samoa", "arizona", "california", "colorado",
"connecticut", "district of columbia", "delaware", "florida",
"georgia", "guam", "hawaii", "iowa", "idaho", "illinois", "indiana",
"kansas", "kentucky", "louisiana", "massachusetts", "maryland",
"maine", "michigan", "minnesota", "missouri", "mississippi",
"montana", "north carolina", "north dakota", "nebraska", "new hampshire",
"new jersey", "new mexico", "nevada", "new york", "ohio", "oklahoma",
"oregon", "pennsylvania", "puerto rico", "rhode island", "south carolina",
"south dakota", "tennessee", "texas", "utah", "virginia", "virgin islands",
"vermont", "washington", "wisconsin", "west virginia", "wyoming", "northern mariana islands"
)), .Names = c("abb", "fips", "name"), row.names = c(NA, -56L
), class = "data.frame")

.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    paste0(
      "To enable caching of data, set `options(tigris_use_cache = TRUE)`", "\n",
      "in your R script or .Rprofile."
    )
  )
}

utils::globalVariables(c(".data", "geoid", "GEOID", "state_fips", "AWATER"))
