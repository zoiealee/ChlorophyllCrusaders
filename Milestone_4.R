# Downloads gcc data from NEON ecoforecast

gcc_90 = readr::read_csv("https://data.ecoforecast.org/neon4cast-targets/phenology/phenology-targets.csv.gz", skip = 488, col_names = c("Date", "Siteid", "Variable", "Observation"))
harv = na.omit(gcc_90[gcc_90$Siteid == "HARV",]) # filter by Harvard Forest site
harv = harv[harv$Variable == "gcc_90",] # filter by gcc variable
time = as.Date(harv$Date)
plot(time, harv$Observation, type='l', xlab = "Time", ylab = "gcc_90", main = "Harvard Forest Phenocam data")