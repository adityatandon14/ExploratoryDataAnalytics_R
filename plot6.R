## read in emissions data and classification code
emissions_data <- readRDS("summarySCC_PM25.rds")
class_code <- readRDS("Source_Classification_Code.rds")

## subset data from Baltimore City, LA county and from type "on road"
baltLA_car_data <- subset(emissions_data, emissions_data$fips=="24510" |
                                  emissions_data$fips=="06037" &
                                  emissions_data$type=="ON-ROAD")
baltLA_car_year <- aggregate(baltLA_car_data$Emissions, 
                             by=list(baltLA_car_data$fips, baltLA_car_data$year),
                             FUN=sum)
colnames(baltLA_car_year) <- c("City", "Year", "Emissions")

## create plot comparing emissions from motor vehicles in Baltimore and LA from 1999-2008
library(ggplot2)
png(filename = "plot6.png")
qplot(Year, Emissions, data = baltLA_car_year, color = City, geom = "line") +
        ggtitle("Emissions of PM2.5 in Baltimore City (24510) and LA County (06037)") + 
        ylab("Total Emissions from motor vehicles (tons)") + 
        xlab("Year") 
dev.off()
