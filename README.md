
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tigris <img src="tools/readme/tigris_sticker.png" width="250"/>

<!-- badges: start -->

[![R build
status](https://github.com/walkerke/tigris/workflows/R-CMD-check/badge.svg)](https://github.com/walkerke/tigris/actions)
![CRAN Badge](http://www.r-pkg.org/badges/version/tigris) ![CRAN
Downloads](http://cranlogs.r-pkg.org/badges/tigris) [![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
<!-- badges: end -->

`{tigris}` is an R package that allows users to directly download and
use [TIGER/Line
shapefiles](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
from the US Census Bureau. Find more background on this data in the
[TIGER/Line Shapefiles and TIGER/Line Files Technical
Documentation](https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.html).

## Installation

To install the package from CRAN, issue the following command in R:

``` r
install.packages('tigris')
```

Or, get the development version from GitHub:

``` r
# install.packages("devtools")
devtools::install_github('walkerke/tigris')
```

## Usage

tigris functions return [simple features
objects](https://r-spatial.github.io/sf/) with a default year of 2022.
To get started, load the library:

``` r
library(tigris)
#> To enable caching of data, set `options(tigris_use_cache = TRUE)`
#> in your R script or .Rprofile.
library(ggplot2)

options(tigris_use_cache = TRUE)
```

Then choose a function from the table below and use it with a state
and/or county if required. You’ll get back an sf object for use in your
mapping and spatial analysis projects:

``` r
manhattan_roads <- roads("NY", "New York", progress_bar = FALSE)
#> Retrieving data for the year 2022

ggplot(manhattan_roads) + 
  geom_sf(linewidth = 0.25) + 
  theme_void()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

tigris returns feature geometries for US Census data which default to
the coordinate reference system NAD 1983 (EPSG: 4269). This output
coordinate reference system can be changed by passing a `crs` parameter
to any function.

For US Census demographic data (optionally pre-joined to tigris
geometries), try the [tidycensus
package](https://walker-data.com/tidycensus/). For help deciding on an
appropriate coordinate reference system for your project, take a look at
the [crsuggest package](https://github.com/walkerke/crsuggest).

To learn more about how to use tigris, read [Chapter 5 of the book
*Analyzing US Census Data: Methods, Maps, and Models in
R*](https://walker-data.com/census-r/census-geographic-data-and-applications-in-r.html).

Python users may also be interested in [**pygris**, a Python port of the
tigris package](https://walker-data.com/pygris/).

## Data

Please note: cartographic boundary files in **tigris** are not available
for 2011 and 2012.

| Function | Datasets available | Years available |
|----|----|----|
| `nation()` | cartographic (1:5m; 1:20m) | 2013-2022 |
| `divisions()` | cartographic (1:500k; 1:5m; 1:20m) | 2013-2022 |
| `regions()` | cartographic (1:500k; 1:5m; 1:20m) | 2013-2022 |
| `states()` | TIGER/Line; cartographic (1:500k; 1:5m; 1:20m) | 1990, 2000, 2010-2022 |
| `counties()` | TIGER/Line; cartographic (1:500k; 1:5m; 1:20m) | 1990, 2000, 2010-2022 |
| `tracts()` | TIGER/Line; cartographic (1:500k) | 1990, 2000, 2010-2022 |
| `block_groups()` | TIGER/Line; cartographic (1:500k) | 1990, 2000, 2010-2022 |
| `blocks()` | TIGER/Line | 2000, 2010-2022 |
| `places()` | TIGER/Line; cartographic (1:500k) | 2000, 2010-2022 |
| `pumas()` | TIGER/Line; cartographic (1:500k) | 2012-2022 |
| `school_districts()` | TIGER/Line; cartographic | 2011-2022 |
| `zctas()` | TIGER/Line; cartographic (1:500k) | 2000, 2010, 2012-2022 |
| `congressional_districts()` | TIGER/Line; cartographic (1:500k; 1:5m; 1:20m) | 2011-2023 |
| `state_legislative_districts()` | TIGER/Line; cartographic (1:500k) | 2011-2022 |
| `voting_districts()` | TIGER/Line | 2012, 2020 |
| `area_water()` | TIGER/Line | 2010-2022 |
| `linear_water()` | TIGER/Line | 2010-2022 |
| `coastline` | TIGER/Line | 2013-2022 |
| `core_based_statistical_areas()` | TIGER/Line; cartographic (1:500k; 1:5m; 1:20m) | 2011-2022 |
| `combined_statistical_areas()` | TIGER/Line; cartographic (1:500k; 1:5m; 1:20m) | 2011-2022 |
| `metro_divisions()` | TIGER/Line | 2011-2022 |
| `new_england()` | TIGER/Line; cartographic (1:500k) | 2011-2022 |
| `county_subdivisions()` | TIGER/Line; cartographic (1:500k) | 2010-2022 |
| `urban_areas()` | TIGER/Line; cartographic (1:500k) | 2012-2022 |
| `primary_roads()` | TIGER/Line | 2010-2022 |
| `primary_secondary_roads()` | TIGER/Line | 2010-2022 |
| `roads()` | TIGER/Line | 2010-2022 |
| `rails()` | TIGER/Line | 2010-2022 |
| `native_areas()` | TIGER/Line; cartographic (1:500k) | 2000, 2010-2022 |
| `alaska_native_regional_corporations()` | TIGER/Line; cartographic (1:500k) | 2000, 2010-2022 |
| `tribal_block_groups()` | TIGER/Line | 2010-2022 |
| `tribal_census_tracts()` | TIGER/Line | 2010-2022 |
| `tribal_subdivisions_national()` | TIGER/Line | 2000, 2010-2022 |
| `landmarks()` | TIGER/Line | 2010-2022 |
| `military()` | TIGER/Line | 2010-2022 |
