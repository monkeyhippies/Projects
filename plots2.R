summary=readRDS("summarySCC_PM25.rds")
codes=readRDS("Source_Classification_Code.rds")
total_emmisions=tapply(summary$Emissions,summary$year,sum,na.rm=TRUE)
png("plot2_1.png")
plot(names(total_emmisions),total_emmisions,xlab="YEAR",ylab="Total emmisions",main="Total Emmissions versus Year")
model=lm(total_emmisions~c(1999,2002,2005,2008))
abline(model,lwd=2)
dev.off()

baltimore=subset(summary,summary$fips=="24510")
baltimore_emmisions=with(baltimore,tapply(Emissions,year,sum,na.rm=TRUE))
png("plot2_2.png")
plot(names(baltimore_emmisions),baltimore_emmisions,xlab="YEAR",ylab="Total emmisions",main="Baltimore Emmissions versus Year")
model=lm(baltimore_emmisions~c(1999,2002,2005,2008))
abline(model,lwd=2)
dev.off()

library(reshape)

baltimore_emmisions=with(baltimore,tapply(Emissions,list(year,type),sum,na.rm=TRUE))
baltimore_emmisions=data.frame(baltimore_emmisions)
baltimore_emmisions=cbind(rownames(baltimore_emmisions),baltimore_emmisions)
rownames(baltimore_emmisions)=NULL
names(baltimore_emmisions)[1]="year"
baltimore_emmisions=melt(baltimore_emmisions,id.var="year")
colnames(baltimore_emmisions)[2:3]=c("type","means")

g=ggplot(baltimore_emmisions, aes(x=year,y=means,group=type,color=type)) + geom_point() +stat_smooth(method = "lm", formula = y ~ x, se = FALSE)+ggtitle("Baltimore Total Emmisions")
ggsave("plot2_3.png",plot=g)

coal_combTF=grepl("Comb",codes$Short.Name)&grepl("Coal",codes$Short.Name)
coal_codes=codes[coal_combTF,"SCC"]

coal=subset(summary,summary$SCC %in% coal_codes)

coal_emmisions=with(coal,tapply(Emissions,year,sum,na.rm=TRUE))
png("plot2_4.png")
plot(names(coal_emmisions),coal_emmisions,xlab="YEAR",ylab="Total emmisions",main="Coal Emmissions versus Year")
model=lm(coal_emmisions~c(1999,2002,2005,2008))
abline(model,lwd=2)
dev.off()

Veh_combTF=grepl("Veh",codes$Short.Name)
Veh_codes=codes[Veh_combTF,"SCC"]
Veh=subset(baltimore,baltimore$SCC %in% coal_codes)

Veh_emmisions=with(Veh,tapply(Emissions,year,sum,na.rm=TRUE))
png("plot2_4.png")
plot(names(Veh_emmisions),Veh_emmisions,xlab="YEAR",ylab="Total emmisions",main="Motor Vehicle Emmissions versus Year in Baltimore")
model=lm(Veh_emmisions~c(1999,2002,2005,2008))
abline(model,lwd=2)
dev.off()

los_angeles=subset(summary,summary$fips=="06037")
VehLA=subset(los_angeles,los_angeles$SCC %in% coal_codes)

VehLA_emmisions=with(VehLA,tapply(Emissions,year,sum,na.rm=TRUE))
png("plot2_6.png")
rng=range(cbind(VehLA_emmisions,Veh_emmisions))
plot(names(VehLA_emmisions),VehLA_emmisions,xlab="YEAR",ylab="Total emmisions",col="red",pch=1,ylim=rng,main="Motor Vehicle Emmissions versus Year in Los Angeles and Baltimore")
lines(c(1999,2002,2005,2008),VehLA_emmisions,col="red")
points(c(1999,2002,2005,2008),Veh_emmisions,col="blue")
lines(c(1999,2002,2005,2008),Veh_emmisions,col="blue")
legend("topright",lty=1,col=c("red","blue"),legend=c("Los Angeles","Baltimore"))

dev.off()
