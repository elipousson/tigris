% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metro_areas.R
\name{urban_areas}
\alias{urban_areas}
\title{Download an urban areas shapefile into R}
\usage{
urban_areas(cb = FALSE, year = NULL, criteria = NULL, ...)
}
\arguments{
\item{cb}{If cb is set to \code{TRUE}, download a generalized (1:500k)
cartographic boundary file.  Defaults to \code{FALSE} (the most detailed
TIGER/Line file). year must be a max of 2020 if \code{cb = TRUE}.}

\item{year}{the data year; defaults to 2022}

\item{criteria}{If set to "2020" and the year is 2020, will download the new
2020 urban areas criteria. Not available for cartographic boundary
shapefiles / other years at the moment.}

\item{...}{arguments to be passed to internal function \code{load_tiger}, which is
not exported. See Additional Arguments.}
}
\description{
Urban areas include both "urbanized areas," which are densely developed areas
with a population of at least 50,000, and "urban clusters," which have a
population of greater than 2,500 but less than 50,000.  For more information,
please see the link provided.
}
\section{Additional Arguments}{

Additional arguments that can be passed in \code{...} are:
\itemize{
\item \code{class} Desired class of return object: \code{"sf"} (the default) or \code{"sp"}. sp
classes should be considered deprecated as of tigris version 2.0, but legacy
support is still available.
\item \code{progress_bar} If set to \code{FALSE}, do not display download progress bar
(helpful for R Markdown documents). Defaults to \code{TRUE}.
\item \code{keep_zipped_shapefile} If set to \code{TRUE}, do not delete zipped shapefile
(stored in temporary directory or \code{TIGRIS_CACHE_DIR} depending on the
configuration of global option \code{"tigris_use_cache"}). Defaults to \code{FALSE}.
\item \code{refresh} Whether to re-download cached shapefiles (\code{TRUE} or \code{FALSE}). The
default is either \code{FALSE} or the value of global option \code{"tigris_refresh"}
if it is set. Specifying this argument will override the behavior set in
\code{"tigris_refresh"} global option.
\item \code{filter_by} Geometry used to filter the output returned by the function.
Can be an sf OR sfc object, an object of class \code{bbox}, or a length-4 vector
of format \code{c(xmin, ymin, xmax, ymax)} that can be converted to a bbox.
Geometries that intersect the input to \code{filter_by} will be returned.
\item \code{crs} Output coordinate reference system. All TIGER/Shapefiles use a EPSG
4269 coordinate reference system.
\item \code{query} A SQL query passed to \code{\link[sf:st_read]{sf::st_read()}}.
}
}

\seealso{
\url{https://www.census.gov/programs-surveys/geography/guidance/geo-areas/urban-rural.html}

Other metro area functions: 
\code{\link{combined_statistical_areas}()},
\code{\link{core_based_statistical_areas}()},
\code{\link{metro_divisions}()},
\code{\link{new_england}()}
}
\concept{metro area functions}
