#### Plot 4 ####

##Reading, naming and subsetting power consumption data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1",
                  "Sub_metering_2","Sub_metering_3")
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

## Format the time vector
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")
subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"],
                                  "2007-02-01 %H:%M:%S")
subpower[1441:2880,"Time"] <- format(subpower[1441:2880,"Time"],
                                     "2007-02-02 %H:%M:%S")

## Basic Plot Functions 
plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",
     ylab="Energy sub metering")
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Code to plot numberous graphs on one page 
par(mfrow=c(2,2))

##  Basic Plot for the 4 plots to from a graph 
with(subpower,{
  plot(subpower$Time,as.numeric(as.character(subpower$Global_active_power)),
       type="l",  xlab="",ylab="Global Active Power")  
  plot(subpower$Time,as.numeric(as.character(subpower$Voltage)), type="l",
       xlab="datetime",ylab="Voltage")
  plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",
       ylab="Energy sub metering")
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         cex = 0.6)
  plot(subpower$Time,as.numeric(as.character(subpower$Global_reactive_power)),
       type="l",xlab="datetime",ylab="Global_reactive_power")
})

##PNG file
dev.copy(png, file = "Plot4")
dev.off()
