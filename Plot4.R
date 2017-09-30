URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"


download.file(URL,"pm25.zip")
unzip("pm25.zip")

SCC<-readRDS("Source_Classification_Code.rds")
PM25<-readRDS("summarySCC_PM25.rds")
library(ggplot2)

coal.combustion<-grep("[Cc]oal",SCC$EI.Sector)
coal.combustion.SCC<-SCC$SCC[coal.combustion]

coal.combustion.data<-subset(PM25,SCC==coal.combustion.SCC)

coal.combustion.tt.emission<-with(coal.combustion.data,tapply(Emissions,year,sum))
coal.combustion.tt.emission<-as.numeric(coal.combustion.tt.emission)
year<-as.Date(c("1999","2002","2005","2008"),"%Y")
coal.combustion.tt.emission.data<-data.frame(year,coal.combustion.tt.emission)

g<-ggplot(coal.combustion.tt.emission.data,aes(year,coal.combustion.tt.emission))
g+geom_point(size=2,color="red")+geom_line(stat = "smooth",method="lm",lwd=1,color="red")+ylab("Total Emissions from Coal Combustion")

dev.copy(png,"Plot4.png",width=480,height=480,units="px") 
dev.off()
