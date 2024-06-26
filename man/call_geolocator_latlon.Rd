% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geocode.R
\name{call_geolocator_latlon}
\alias{call_geolocator_latlon}
\title{Call geolocator for one address with lat/lon, adds option to set benchmark and vintage if not provided it will default to the most recent.}
\usage{
call_geolocator_latlon(lat, lon, benchmark = NULL, vintage = NULL)
}
\arguments{
\item{lat}{A numeric value}

\item{lon}{A numeric value}

\item{benchmark}{time period when a snapshot of address ranges was taken. As
of early 2024, supported values include "Public_AR_Current",
"Public_AR_Census2020", "Public_AR_ACS2023".}

\item{vintage}{census or survey that the address range relates to. See the
\href{https://geocoding.geo.census.gov/geocoder/geographies/coordinates}{Find Geographic Coordinates form}
for supported values for each benchmark.}
}
\value{
A character string representing the Census block of the supplied
lat/lon.
}
\description{
Call geolocator for one address with lat/lon, adds option to set benchmark and vintage if not provided it will default to the most recent.
}
\author{
Josie Kressner, \email{josie@transportfoundry.com}

Mark Richards, \email{Mark.Richards.002@gmail.com}
}
