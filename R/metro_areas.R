#' Download a core-based statistical area shapefile into R
#'
#' Core-based statistical areas include both metropolitan areas and micropolitan
#' areas. The US Census Bureau defines these areas as follows: "A metro area
#' contains a core urban area of 50,000 or more population, and a micro area
#' contains an urban core of at least 10,000 (but less than 50,000) population.
#' Each metro or micro area consists of one or more counties and includes the
#' counties containing the core urban area, as well as any adjacent counties
#' that have a high degree of social and economic integration (as measured by
#' commuting to work) with the urban core." Please see the link provided for
#' more information
#'
#' @param cb If cb is set to `TRUE`, download a generalized (1:500k)
#'   cartographic boundary file.  Defaults to `FALSE` (the most detailed
#'   TIGER/Line file).
#' @param resolution The resolution of the cartographic boundary file (if `cb =
#'   TRUE`). Defaults to "500k"; options include "5m" (1:5 million) and "20m"
#'   (1:20 million).
#' @param year year of data to return. As of Jan. 2024,
#'   `core_based_statistical_areas` has a maximum year of 2021, a minimum of
#'   2010, and defaults to 2021 if no option is set.
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family metro area functions
#' @seealso <https://www.census.gov/programs-surveys/metro-micro.html>
#' @export
core_based_statistical_areas <- function(cb = FALSE, resolution = "500k", year = NULL, ...) {

  # Override standard default year per: https://github.com/walkerke/tigris/issues/184
  year <- set_tigris_year(year, default = 2021, min_year = 2010)

  check_not_year(
    year,
    message = "Core-based statistical area boundaries are not available for 2022.",
    error_year = 2022
  )

  if (cb) {
    if (year == 2010) {
      check_tigris_resolution(resolution, values = c("500k", "20m"))

      url <- url_tiger("GENZ2010/gz_2010_us_310_m1_%s", resolution)

    } else {
      check_tigris_resolution(resolution)

      url <- url_tiger("GENZ%s/shp/cb_%s_us_cbsa_%s", year, year, resolution)

      if (year == 2013) url <- remove_shp(url)
    }


  } else if (year == 2010) {
    url <- url_tiger("TIGER2010/CBSA/2010/tl_2010_us_cbsa10")
  } else {
    url <- url_tiger("TIGER%s/CBSA/tl_%s_us_cbsa", year, year)
  }

  return(load_tiger(url, tigris_type = "cbsa", ...))

}

#' Download an urban areas shapefile into R
#'
#' Urban areas include both "urbanized areas," which are densely developed areas
#' with a population of at least 50,000, and "urban clusters," which have a
#' population of greater than 2,500 but less than 50,000.  For more information,
#' please see the link provided.
#'
#' @param cb If cb is set to `TRUE`, download a generalized (1:500k)
#'   cartographic boundary file.  Defaults to `FALSE` (the most detailed
#'   TIGER/Line file). year must be a max of 2020 if `cb = TRUE`.
#' @param criteria If set to "2020" and the year is 2020, will download the new
#'   2020 urban areas criteria. Not available for cartographic boundary
#'   shapefiles / other years at the moment.
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family metro area functions
#' @seealso <https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural.html>
#' @export
urban_areas <- function(cb = FALSE, year = NULL, criteria = NULL, ...) {

  if (cb) {
    year <- set_tigris_year(year, default = 2020, max_year = 2020)

    if (!is.null(criteria)) {
      cli_abort(
        "The `criteria` argument is not supported
        for cartographic boundary files"
      )
    }

    if (year == 2020) {
      url <- url_tiger("GENZ%s/shp/cb_%s_us_ua20_corrected_500k", year, year)
    } else {
      url <- url_tiger("GENZ%s/shp/cb_%s_us_ua10_500k", year, year)

    }

    if (year == 2013) url <- remove_shp(url)

  } else {

    year <- set_tigris_year(year)

    if (year >= 2023) {
      url <- url_tiger("TIGER%s/UAC/tl_%s_us_uac20", year, year)

    } else if (!is.null(criteria) && criteria == 2020) {

      if (year != 2020) {
        cli_abort("{.arg year} must be 2020 to use 2020 criteria.")
      }

      url <- url_tiger("TIGER%s/UAC/tl_%s_us_uac20", year, year)
    } else {
      url <- url_tiger("TIGER%s/UAC/tl_%s_us_uac10", year, year)
    }

  }

  return(load_tiger(url, tigris_type = "urban", ...))

}

#' Download a combined statistical areas shapefile into R
#'
#' Combined statistical areas are "two or more adjacent CBSAs that have
#' significant employment interchanges."  In turn, CSAs are composed of multiple
#' metropolitan and/or micropolitan areas, and should not be compared with
#' individual core-based statistical areas.
#'
#' @param cb If cb is set to `TRUE`, download a generalized (1:500k)
#'   cartographic boundary file.  Defaults to `FALSE` (the most detailed
#'   TIGER/Line file).
#' @param resolution The resolution of the cartographic boundary file (if `cb =
#'   TRUE`). Defaults to "500k"; options include "5m" (1:5 million) and "20m"
#'   (1:20 million).
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family metro area functions
#' @seealso <https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2020/TGRSHP2020_TechDoc.pdf>
#' @export
combined_statistical_areas <- function(cb = FALSE, resolution = "500k", year = NULL, ...) {

  year <- set_tigris_year(year, default = 2021)

  check_not_year(
    year,
    message = "Combined statistical area boundaries are unavailable for 2022.",
    error_year = 2022
  )

  check_tigris_resolution(resolution)

  if (cb) {
    url <- url_tiger("GENZ%s/shp/cb_%s_us_csa_%s", year, year, resolution)

    if (year == 2013) url <- remove_shp(url)

  } else {
    url <- url_tiger("TIGER%s/CSA/tl_%s_us_csa", year, year)
  }

  return(load_tiger(url, tigris_type = "csa", ...))

}

#' Download a metropolitan divisions shapefile into R.
#'
#' Metropolitan divisions are subdivisions of metropolitan areas with population
#' of at least 2.5 million.  Please note: not all metropolitan areas have
#' metropolitan divisions.
#'
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family metro area functions
#' @seealso <https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2020/TGRSHP2020_TechDoc.pdf>
#' @export
metro_divisions <- function(year = NULL, ...) {

  year <- set_tigris_year(year, default = 2021)

  url <- url_tiger("TIGER%s/METDIV/tl_%s_us_metdiv", year, year)

  return(load_tiger(url, tigris_type = "metro", ...))

}

#' Download a New England City and Town Area shapefile into R
#'
#' From the US Census Bureau (see link for source): "In New England
#' (Connecticut, Maine, Massachusetts, New Hampshire, Rhode Island,
#' and Vermont), the OMB has defined an alternative county subdivision
#' (generally city and town) based definition of CBSAs
#' known as New England city and town areas (NECTAs). NECTAs are defined using the same criteria as
#' metropolitan and micropolitan statistical areas and are identified as either metropolitan or micropolitan,
#' based, respectively, on the presence of either an urbanized area of 50,000 or more inhabitants or an
#' urban cluster of at least 10,000 and less than 50,000 inhabitants."  Combined NECTAs, or CNECTAs, are two or more
#' NECTAs that have significant employment interchange, like Combined Statistical Areas;
#' NECTA divisions are subdivisions of NECTAs.
#'
#' @param type Specify whether to download the New England City and Town Areas
#'   file (`'necta'`, the default), the combined NECTA file (`'combined'`), or
#'   the NECTA divisions file (`'divisions'`).
#' @param cb If cb is set to `TRUE`, download a generalized (1:500k)
#'   cartographic boundary file.  Defaults to `FALSE` (the most detailed
#'   TIGER/Line file). Only available when `type = 'necta'`.
#' @inheritParams load_tiger_doc_template
#' @inheritSection load_tiger_doc_template Additional Arguments
#' @family metro area functions
#' @seealso <https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2020/TGRSHP2020_TechDoc.pdf>
#' @export
#' @examples \dontrun{
#' library(tigris)
#'
#' ne <- new_england(cb = TRUE)
#'
#' plot(ne$geometry)
#'
#' }
new_england <- function(type = "necta", cb = FALSE, year = NULL, ...) {

  year <- set_tigris_year(year, default = 2021, max_year = 2021)

  type <- arg_match0(type, c("necta", "combined", "divisions"))

  if (type == 'necta') {

    if (cb) {

      url <- url_tiger("GENZ%s/shp/cb_%s_us_necta_500k", year, year)

    } else {

      url <- url_tiger("TIGER%s/NECTA/tl_%s_us_necta", year, year)

    }

    tigris_type <- type

  } else if (type == "combined") {

    url <- url_tiger("TIGER%s/CNECTA/tl_%s_us_cnecta", year, year)

    tigris_type <- "cnecta"

  } else if (type == "divisions") {

    url <- url_tiger("TIGER%s/NECTADIV/tl_%s_us_nectadiv", year, year)

    tigris_type <- "nectadiv"

  }

  return(load_tiger(url, tigris_type = tigris_type, ...))
}
