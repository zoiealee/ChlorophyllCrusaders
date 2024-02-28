# Load libraries
remotes::install_github("eco4cast/neon4cast")
library(dplyr)

# Downloads PhenoCam data from NEON ecoforecast

URL = "https://data.ecoforecast.org/neon4cast-targets/phenology/phenology-targets.csv.gz"
data = readr::read_csv(URL, col_names = c("Date", "Siteid", "Variable", "Observation"))

# HARV site
harv = na.omit(data[data$Siteid == "HARV",]) # filter by Harvard Forest site
time = as.Date(harv$Date)

# Green chromatic coordinate: ratio of the green DN : sum of red, green, blue DN from a digital camera. 
# gcc_90 is the 90th percentile of the gcc within a ROI
gcc_90 = harv[harv$Variable == "gcc_90",] # filter by gcc variable
plot(as.Date(gcc_90$Date), gcc_90$Observation, 
     type='l', 
     xlab = "Time", 
     ylab = "gcc_90", 
     main = "HARV green chromatic coordinate")

# Red chromatic coordinate (rcc_90)
rcc_90 = harv[harv$Variable == "rcc_90",] # filter by rcc variable
plot(as.Date(rcc_90$Date), rcc_90$Observation, 
     type='l', 
     xlab = "Time", 
     ylab = "rcc_90", 
     main = "HARV red chromatic coordinate")

# Download covariate data: NOAA meteorological data

weather_stage3 <- neon4cast::noaa_stage3()
ds1 <- weather_stage3 |> 
  dplyr::filter(site_id == "HARV") |>
  dplyr::collect()

# Make plots of covariate data

TMP = ds1[ds1$variable == "air_temperature",]
PRES = ds1[ds1$variable == "air_pressure",]
RH  = ds1[ds1$variable == "relative_humidity",]
PCP  = ds1[ds1$variable == "preciptation_flux",]

plot(TMP$datetime, TMP$prediction, type='l',
     main = "HARV Temperature (K)",
     xlab = "Date",
     ylab = "Temperature (K)")

plot(PRES$datetime, PRES$prediction, type='l',
     main = "HARV Pressure (Pa)",
     xlab = "Date",
     ylab = "Pressure (Pa)")

plot(RH$datetime, RH$prediction, type='l',
     main = "HARV Relative Humidity (proportion)",
     xlab = "Date",
     ylab = "relative humidity")

#plot(PCP$datetime, PCP$prediction, type='l',
#     main = "HARV Precipitaiton flux (kg/(m^2 s))",
#     xlab = "Date",
#     ylab = "Precipitaiton flux (kg/(m^2 s))")

