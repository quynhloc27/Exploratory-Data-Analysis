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

motor.vehicle.LA<-subset(PM25,type=="ON-ROAD" & fips == "06037")
motor.vehicle.LA.tt.emission<-with(motor.vehicle.LA,tapply(Emissions,year,sum))
motor.vehicle.LA.tt.emission<-as.numeric(motor.vehicle.LA.tt.emission)

motor.vehicle.LA.tt.emission.data<-data.frame(year,city=rep("L.A",4),motor.vehicle.LA.tt.emission)
names(motor.vehicle.LA.tt.emission.data)<-names(motor.vehicle.baltimore.tt.emission.data)

motor.vehicle.LA.baltimore.tt.emission.data<-rbind(motor.vehicle.baltimore.tt.emission.data,motor.vehicle.LA.tt.emission.data)

g<-ggplot(motor.vehicle.LA.baltimore.tt.emission.data,aes(year,Total.Emission,group=city))
g+geom_point(aes(color=city))+geom_line(aes(color=city),stat="smooth",method="lm")

dev.copy(png,"Plot6.png",width=480,height=480,units="px")             
dev.off()
