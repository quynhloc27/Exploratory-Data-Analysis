URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"


download.file(URL,"pm25.zip")
unzip("pm25.zip")

SCC<-readRDS("Source_Classification_Code.rds")
PM25<-readRDS("summarySCC_PM25.rds")

library(ggplot2)

baltimore<- subset(PM25,fips=="24510")

baltimore$type<-factor(baltimore$type)

tt.emissions.baltimore.type<-with(baltimore,tapply(Emissions,list(year,type),sum))


tt.emissions.baltimore.type<-as.data.frame(tt.emissions.baltimore.type)

type<-c("NON.ROAD","NONPOINT","ON.ROAD","POINT","YEAR")
year<-c("1999","2002","2005","2008")
NON.ROAD<-data.frame(year,tt.emissions.baltimore.type[,1],rep(type[1],4))
names(NON.ROAD)<-c("Year","TT.Emission","Type")
NONPOINT<-data.frame(year,tt.emissions.baltimore.type[,2],rep(type[2],4))
names(NONPOINT)<-c("Year","TT.Emission","Type")
ON.ROAD<-data.frame(year,tt.emissions.baltimore.type[,3],rep(type[3],4))
names(ON.ROAD)<-c("Year","TT.Emission","Type")
POINT<-data.frame(year,tt.emissions.baltimore.type[,4],rep(type[4],4))
names(POINT)<-c("Year","TT.Emission","Type")
data<-rbind(NON.ROAD,NONPOINT,ON.ROAD,POINT)

g<-ggplot(data,aes(Year,TT.Emission,group=Type))
g+geom_point(aes(color=Type),size=2,alpha=1,shape=4)+theme_bw(base_family="Times")+geom_line(aes(color=Type),stat="smooth",method="lm",lwd=1,se=TRUE)+ylab("Total Emission of PM 2.5")

dev.copy(png,"Plot3.png",width=480,height=480,units="px")
dev.off()
