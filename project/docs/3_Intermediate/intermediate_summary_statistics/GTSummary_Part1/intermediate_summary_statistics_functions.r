

get_dataset <- function(API_KEY){
library(cancensus)
library(dplyr)
library(sf)

    options(cancensus.api_key=API_KEY)
    options(cancensus.cache_path = "/cache")

    census_data <- get_census(dataset='CA16', regions=list(CSD="5915022"), vectors=c("v_CA16_5799","v_CA16_5802","v_CA16_5805","v_CA16_5808","v_CA16_5811", "v_CA16_5801","v_CA16_5795", "v_CA16_5794", "v_CA16_5793", "v_CA16_548","v_CA16_5792", "v_CA16_379", "v_CA16_406","v_CA16_2396", "v_CA16_5078", "v_CA16_2397"), labels="detailed", geo_format="sf", level='DA')

    census_data_clean <- census_data |>
        rename(
            name = 'GeoUID',
            population_density = 'v_CA16_406: Population density per square kilometre', 
            region = `Region Name`, 
            age = `v_CA16_379: Average age`, 
            income = `v_CA16_2397: Median total income of households in 2015 ($)`,
            education = `v_CA16_5078: University certificate, diploma or degree at bachelor level or above`,
            car_commute_driver = `v_CA16_5795: Car, truck, van - as a driver`,
            car_commute_driven = `v_CA16_5799: Car, truck, van - as a passenger`,         
            pt_commute = `v_CA16_5802: Public transit`,
            walk_commute = `v_CA16_5805: Walked`,
            bike_commute = `v_CA16_5808: Bicycle`,
            other_commute = `v_CA16_5811: Other method`, 
            total_reported_commute = `v_CA16_5793: Total - Main mode of commuting for the employed labour force aged 15 years and over in private households with a usual place of work or no fixed workplace address - 25% sample data`           
        ) |>
        filter(region == "Vancouver") |>
        mutate(income = income / 100000) |>
        select(population_density, age, income, education, car_commute_driver, car_commute_driven, pt_commute, walk_commute, bike_commute, other_commute, total_reported_commute)

    return(census_data_clean)
}


get_bikes <- function(API_KEY) {
library(cancensus)
library(dplyr)
library(sf)
library(VancouvR)

  options(cancensus.api_key = API_KEY)
  options(cancensus.cache_path = "/cache")

  
  census_data <- get_census(
    dataset = "CA16",
    regions = list(CSD = "5915022"), 
    vectors = c(
      "v_CA16_5799","v_CA16_5802","v_CA16_5805","v_CA16_5808","v_CA16_5811",
      "v_CA16_5801","v_CA16_5795","v_CA16_5794","v_CA16_5793","v_CA16_548",
      "v_CA16_5792","v_CA16_379","v_CA16_406","v_CA16_2396","v_CA16_5078","v_CA16_2397"
    ),
    labels = "detailed",
    geo_format = "sf",
    level = "DA"
  )

  bikes <- get_cov_data("bikeways") |>
    st_as_sf()
  
  census_data_clean <- census_data |>
    rename(
            name = 'GeoUID',
            population_density = 'v_CA16_406: Population density per square kilometre', 
            region = `Region Name`, 
            age = `v_CA16_379: Average age`, 
            income = `v_CA16_2397: Median total income of households in 2015 ($)`,
            education = `v_CA16_5078: University certificate, diploma or degree at bachelor level or above`,
            car_commute_driver = `v_CA16_5795: Car, truck, van - as a driver`,
            car_commute_driven = `v_CA16_5799: Car, truck, van - as a passenger`,         
            pt_commute = `v_CA16_5802: Public transit`,
            walk_commute = `v_CA16_5805: Walked`,
            bike_commute = `v_CA16_5808: Bicycle`,
            other_commute = `v_CA16_5811: Other method`, 
            total_reported_commute = `v_CA16_5793: Total - Main mode of commuting for the employed labour force aged 15 years and over in private households with a usual place of work or no fixed workplace address - 25% sample data`           
        ) |>
    filter(region == "Vancouver") |>
    mutate(income = income / 100000) |>
    select(
      name,
      population_density, age, income, education,
      car_commute_driver, car_commute_driven, pt_commute,
      walk_commute, bike_commute, other_commute, total_reported_commute,
      geometry
    )
  
  census_data_clean <- st_transform(census_data_clean, st_crs(bikes))
  
  census_data_clean <- st_join(census_data_clean, bikes, left = TRUE) |>
    mutate(has_bike_lane = if_else(!is.na(object_id), 1, 0)) |>
    group_by(name) |>
    summarize(
      across(population_density:total_reported_commute, first),
      has_bike_lane = max(has_bike_lane),
      geometry = st_union(geometry)
    )

  census_data_clean <- census_data_clean |>
    select(
      population_density, age, income, education, 
      bike_commute, total_reported_commute, has_bike_lane, geometry
    ) |>
    mutate(bike_prop = bike_commute / total_reported_commute) |>  
    as_tibble() |>
    select(
      -bike_commute, 
      -total_reported_commute, 
      -geometry
    ) |>
    drop_na() |>
    distinct()

  return(census_data_clean)
}

