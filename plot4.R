# Plot4.R
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

# Plot 4
png(filename = 'plot4.png', width = 480, height = 480)
par(mfrow = c(2, 2))
plot(power$Time, power$GlobalActivePower, type = 'l', ylab = 'Global Active Power', xlab = "Days")

plot(power$Time, power$Voltage, type = 'l', ylab = 'Voltage', xlab = "Days")

plot(power$Time, power$SubMetering_1, type = 'l', xlab = "Days", ylab = "Energy Submetering")
points(power$Time, power$SubMetering_2, type = 'l', col = "red")
points(power$Time, power$SubMetering_3, type = 'l', col = "blue")
names = c("SubMetering 1", "SubMetering 2", "SubMetering 3")
legend("topright", names, lty = c(1, 1, 1), col = c("black", "red", "blue"), seg.len = 1, adj = 0, box.lty = 0)

plot(power$Time, power$GlobalReactivePower, type = 'l', ylab = 'Global Reactive Power', xlab = "Days")
dev.off()