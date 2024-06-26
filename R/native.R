#' Download an American Indian / Alaska Native / Native Hawaiian Areas shapefile into R.
#'
#' Description from the Census Bureau: "This shapefile contain both legal and statistical
#' American Indian, Alaska Native, and Native Hawaiian
#' entities for which the Census Bureau publishes data. The legal entities consist of federally recognized
#' American Indian reservations and off-reservation trust land areas, state-recognized American Indian
#' reservations, and Hawaiian home lands (HHLs)." For more information, please see the link provided.
#'
#' @param cb If cb is set to TRUE, download a generalized (1:500k)
#'        file.  Defaults to FALSE (the most detailed TIGER/Line file)
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family native/tribal geometries functions
#' @seealso <https://www2.census.gov/geo/pdfs/reference/GARM/Ch5GARM.pdf>
#' @export
#' @examples \dontrun{
#' library(tigris)
#' library(ggplot2)
#' library(ggthemes)
#'
#' nat <- native_areas(cb = TRUE)
#'
#' gg <- ggplot()
#' gg <- gg + geom_sf(data = nat, color="black", fill="white", size=0.25)
#' gg <- gg + coord_sf(xlim=c(-179.1506, -129.9795),  # alaska
#'                      ylim=c(51.2097, 71.4410))
#' gg <- gg + theme_map()
#' gg
#' }
native_areas <- function(cb = FALSE, year = NULL, ...) {

  if (cb) {
    year <- set_tigris_year(year)
    url <- url_tiger("GENZ%s/shp/cb_%s_us_aiannh_500k", year, year)
  } else {

    year <- set_tigris_year(year, min_year = 2000)
    check_not_year(year, error_year = c(2001:2009))

    if (year > 2010) {
      url <- url_tiger("TIGER%s/AIANNH/tl_%s_us_aiannh", year, year)
    } else if (year %in% c(2000, 2010)) {
      url <- url_tiger("TIGER2010/AIANNH/%s/tl_2010_us_aiannh%s", year, year_suf(year))
    }
  }

  return(load_tiger(url, tigris_type = "native areas", ...))

}

#' Download an American Indian Tribal Subdivision National shapefile into R.
#'
#' Definition from the US Census Bureau: "American Indian Tribal Subdivisions (AITS) are legally defined
#' administrative subdivisions of federally
#' recognized American Indian reservations and/or off-reservation trust lands or Oklahoma tribal statistical
#' areas (OTSAs)."  For more information, please see the link provided.
#'
#' @param cb If cb is set to TRUE, download a generalized (1:500k)
#'        file.  Defaults to FALSE (the most detailed TIGER/Line file)
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family native/tribal geometries functions
#' @seealso <https://www2.census.gov/geo/pdfs/reference/GARM/Ch5GARM.pdf>
#' @export
#' @examples \dontrun{
#' library(tigris)
#' library(leaflet)
#'
#' trib <- tribal_subdivisions_national()
#' leaflet(trib) %>%
#'   addProviderTiles("CartoDB.Positron") %>%
#'   addPolygons(fillColor = "white",
#'               color = "black",
#'               weight = 0.5)
#' }
tribal_subdivisions_national <- function(cb = FALSE, year = NULL, ...) {

  if (cb) {
    year <- set_tigris_year(year)
    url <- url_tiger("GENZ%s/shp/cb_%s_us_aitsn_500k", year, year)
  } else {
    year <- set_tigris_year(year, min_year = 2000)
    check_not_year(year, error_year = c(2001:2009))

    if (year > 2015) {
      url <- url_tiger("TIGER%s/AITSN/tl_%s_us_aitsn", year, year)
    } else if (year > 2010 && year < 2015) {
      url <- url_tiger("TIGER%s/AITS/tl_%s_us_aitsn", year, year)
    } else if (year %in% c(2000, 2010)) {
      url <- url_tiger("TIGER2010/AITS/%s/tl_2010_us_aitsn%s", year, year_suf(year))
    }
  }

  return(load_tiger(url, tigris_type = "tribal subdivisions", ...))

}

#' Download an Alaska Native Regional Corporation shapefile into R.
#'
#' From the US Census Bureau: "ANRCs are corporations created according to the Alaska Native Claims Settlement Act.
#' They are organized under the laws of the State of
#' Alaska as "Regional Corporations," to conduct both the for-profit and non-profit affairs of Alaska Natives
#' within defined regions of Alaska."  For more information, please see the Census technical documentation at the
#' link provided.
#'
#' @param cb If cb is set to TRUE, download a generalized (1:500k)
#'        file.  Defaults to FALSE (the most detailed TIGER/Line file)
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family native/tribal geometries functions
#' @seealso <https://www2.census.gov/geo/pdfs/reference/GARM/Ch5GARM.pdf>
#' @export
alaska_native_regional_corporations <- function(cb = FALSE, year = NULL, ...) {


  if (cb) {
    year <- set_tigris_year(year)
    url <- url_tiger("GENZ%s/shp/cb_%s_02_anrc_500k", year, year)
  } else {
    year <- set_tigris_year(year, min_year = 2000)
    check_not_year(year, error_year = c(2001:2009))

    if (year > 2010) {
      url <- url_tiger("TIGER%s/ANRC/tl_%s_02_anrc", year, year)
    } else if (year %in% c(2000, 2010)) {
      url <- url_tiger("TIGER2010/ANRC/%s/tl_2010_02_anrc%s", year, year_suf(year))
    }
  }

  return(load_tiger(url, tigris_type = "ANRCs", ...))

}

#' Download a Tribal block groups shapefile into R.
#'
#' From the US Census Bureau: "Tribal block groups are subdivisions of a tribal
#' census tract. Tribal block groups were defined by federally
#' recognized tribal government officials in the Census Bureau's
#' Tribal Statistical Areas Program (TSAP) for
#' the 2010 Census. If a tribal government declined to participate in TSAP, the Census Bureau delineated
#' tribal block groups on the American Indian reservation and/or off-reservation trust land (ORTL). Tribal
#' block groups are intended to generally contain between 600 and 3000 persons or between 240 and
#' 1200 housing units. Many American Indian reservations and ORTLs have less than the minimum
#' population thresholds for more than one tribal block group and in those cases one tribal block group was
#' delineated that covers the entire American Indian reservation and/or ORTL. Unlike standard block
#' groups, the cluster of blocks that comprises each tribal block group will not necessarily begin with the
#' same first number of their 4-character census block number,
#' but may contain blocks from several different
#' standard census block groups."  For more information, please see the link provided.
#'
#' @param cb If cb is set to TRUE, download a generalized (1:500k)
#'        file.  Defaults to FALSE (the most detailed TIGER/Line file)
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family native/tribal geometries functions
#' @seealso <https://www2.census.gov/geo/pdfs/reference/GARM/Ch5GARM.pdf>
#' @export
#' @examples \dontrun{
#' library(tigris)
#' library(leaflet)
#'
#' trib <- tribal_block_groups()
#' leaflet(trib) %>%
#'   addProviderTiles("CartoDB.Positron") %>%
#'   addPolygons(fillColor = "white",
#'               color = "black",
#'               weight = 0.5)
#' }
tribal_block_groups <- function(cb = FALSE, year = NULL, ...) {

  if (cb) {
    year <- set_tigris_year(year)
    url <- url_tiger("GENZ%s/shp/cb_%s_us_tbg_500k", year, year)
  } else {
    year <- set_tigris_year(year, min_year = 2010)

    if (year > 2010) {
      url <- url_tiger("TIGER%s/TBG/tl_%s_us_tbg", year, year)
    } else if (year == 2010) {
      url <- url_tiger("TIGER%s/TBG/%s/tl_%s_us_tbg%s", year, year, year, year_suf(year))
    }
  }

  return(load_tiger(url, tigris_type = "tribal block groups", ...))

}

#' Download a Tribal Census tract shapefile into R.
#'
#' From the US Census Bureau: "Tribal census tracts are relatively small statistical
#' subdivisions of an American Indian reservation and/or
#' off-reservation trust land (ORTL) and were defined by
#' federally recognized tribal government officials in
#' the Census Bureau's Tribal Statistical Areas Program (TSAP) for the 2010 Census. If a tribal government
#' declined to participate in TSAP, the Census Bureau delineated tribal census tracts on the American
#' Indian reservation and/or ORTL. Tribal census tracts are conceptually similar and equivalent to standard
#' census tracts. Unlike standard census tracts, however, tribal census tracts may cross state, county, and
#' standard census tract boundaries." For more information, please view the link provided.
#'
#' @param cb If cb is set to TRUE, download a generalized (1:500k)
#'        file.  Defaults to FALSE (the most detailed TIGER/Line file)
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family native/tribal geometries functions
#' @seealso <https://www2.census.gov/geo/pdfs/reference/GARM/Ch5GARM.pdf>
#' @export
#' @examples \dontrun{
#' library(tigris)
#' library(leaflet)
#'
#' trib <- tribal_census_tracts()
#' leaflet(trib) %>%
#'   addProviderTiles("CartoDB.Positron") %>%
#'   addPolygons(fillColor = "white",
#'               color = "black",
#'               weight = 0.5)
#' }
tribal_census_tracts <- function(cb = FALSE, year = NULL, ...) {

  if (cb) {
    year <- set_tigris_year(year)
    url <- url_tiger("GENZ%s/shp/cb_%s_us_ttract_500k", year, year)
  } else {
    year <- set_tigris_year(year, min_year = 2010)
    if (year > 2010) {
      url <- url_tiger("TIGER%s/TTRACT/tl_%s_us_ttract", year, year)
    } else if (year == 2010) {
      url <- url_tiger("TIGER%s/TTRACT/%s/tl_%s_us_ttract%s", year, year, year, year_suf(year))
    }
  }

  return(load_tiger(url, tigris_type = "tribal tracts", ...))

}
