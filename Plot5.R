URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"


download.file(URL,"pm25.zip")
unzip("pm25.zip")

SCC<-readRDS("Source_Classification_Code.rds")
PM25<-readRDS("summarySCC_PM25.rds")
library(ggplot2)

motor.vehicle.baltimore<-subset(PM25,type=="ON-ROAD" & fips == "24510")

motor.vehicle.baltimore.tt.emission<-with(motor.vehicle.baltimore,tapply(Emissions,year, sum))
motor.vehicle.baltimore.tt.emission<-as.numeric(motor.vehicle.baltimore.tt.emission)
year<-as.Date(c("1999","2002","2005","2008"),"%Y")

motor.vehicle.baltimore.tt.emission.data<-data.frame(year,city=rep("Baltimore",4),motor.vehicle.baltimore.tt.emission)
names(motor.vehicle.baltimore.tt.emission.data)<-c("year","city","Total.Emission")
g<-ggplot(motor.vehicle.baltimore.tt.emission.data,aes(year,Total.Emission))
g+geom_point(size=2,color="blue")+geom_line(stat="smooth",method="lm",lwd=1,color="blue")+ylab("Total Emission from Motor Vehicle from Baltimore")

dev.copy(png,"Plot5.png",width=480,height=480,units="px")
dev.off()