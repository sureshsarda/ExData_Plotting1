# Plot2.R
#
# Since the file is too large and it takes time to load it in memory,
# I decided to laod only part of file.
# First to find the line numbers on which the dates: 2/1/2007 and 2/2/2007
# occur, I grep-ed it.
#
# grep -nE "^(2|1)/2/2007" household_power_consumption.txt | wc -l
# This gives the line count as 2880
# Start: 66638, End: 69517

# Loading
fobj = file('household_power_consumption.txt')
open(fobj)
tbl = read.table(fobj, skip = 66637, nrows = 2880, sep = ';', na.strings = '?', col.names = c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering_1", "SubMetering_2", "SubMetering_3"))
close(fobj)
power = tbl

#Preprocessing
power$Date = as.Date(power$Date, "%d/%m/%Y")
power$Time = strptime(paste(power$Date, tbl$Time), "%Y-%m-%d %H:%M:%S")

# Plot 2
png(filename = 'plot2.png', width = 480, height = 480)
plot(power$Time, power$GlobalActivePower, type = 'l')
dev.off()