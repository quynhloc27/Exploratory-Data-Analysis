URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"


download.file(URL,"pm25.zip")
unzip("pm25.zip")

SCC<-readRDS("Source_Classification_Code.rds")
PM25<-readRDS("summarySCC_PM25.rds")

PM25$year<-factor(PM25$year)

tt.emissions<-with(PM25,tapply(Emissions,year,sum))
year.emissions<-as.Date(unique(as.character(PM25$year)),"%Y")

plot(year.emissions,tt.emissions,xlab="Year",ylab="Total emissions of PM 2.5",col="red",lwd=2,pch=19)
abline(lm(tt.emissions~year.emissions),col="Red",lwd=2)

dev.copy(png,file="Plot1.png",width = 480,height = 480,units="px")
dev.off()
