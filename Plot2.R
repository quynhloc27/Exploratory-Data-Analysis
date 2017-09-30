URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"


download.file(URL,"pm25.zip")
unzip("pm25.zip")

SCC<-readRDS("Source_Classification_Code.rds")
PM25<-readRDS("summarySCC_PM25.rds")
baltimore<- subset(PM25,fips=="24510")

tt.emissions.baltimore<-with(baltimore,tapply(Emissions,year,sum))
year.emissions.baltimore<-as.Date(unique(as.character(baltimore$year)),"%Y")

plot(year.emissions.baltimore,tt.emissions.baltimore,xlab="Year",ylab="Total Emissions of PM 2.5 in Baltimore",col="Blue",lwd=2,pch=19)
abline(lm(tt.emissions.baltimore~year.emissions.baltimore),col="Blue",lwd=2)

dev.copy(png,file="Plot2.png",width=480,height=480,units="px")
dev.off()
