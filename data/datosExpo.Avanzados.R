# First Data Analysis in R
# Author: Ali Adame
# Date: 2018-10-13T15:37:00\
# Modified: 2022-04-31T15:37:00\

# Antes que nada te felicito por estar aqui y te deseo exito al poner a prueba tus habilidades de extraccion de datos
runif(10)
rnorm(200)
# Recuerda que en R Studio puedes usar el operador ? antes de una funcion
# ejemplo la funcion mean(args) que calcula el promedio
# puedes escribir ?mean y R Studio te va a mostrar ayudas sobre lo que hace un paquete o funcion

# Importing data
# Algunos de los comentarios en el codigo estan en ingles pues me gusta alternar entre lenguajes y no solo hablo respecto a programación
# Si la ruta R-intro-data-science no existe en tu disco D o la carpeta no existe puedes crearla o adapartar la ruta
myVar <- read.csv("D://R-intro-data-science/1987.csv")
head(myVar)
# Obtiene primeros datos del conjunto de datos
head(myVar$Origin)
# Obtie ultimos registros de la columna de destino de la variable myVar que contiene la info de 1987
tail(myVar$Dest)
# Es importante mencionar que en el archivo de airports.csv se tiene el mapeo de aeropuertos y aerodromos de EEUU el cual se puede cargar también en R
# y usar el comando de viewtable de R Studio para obtener datos relevantes
# Mas info en: https://support.rstudio.com/hc/en-us/articles/205175388-Using-the-Data-Viewer-in-the-RStudio-IDE

head(myVar$Origin == 'SAN')
# Total flights from San Diego airport according to IATA code
sum(myVar$Origin == 'SAN')
sum(myVar$Dest == 'SAN')
sum(myVar$Origin == 'ORD')

myVar2008 <- read.csv("D://R-intro-data-science/2008.csv.bz2")
head(myVar2008)
#flights departed from O'Hare Airport
sum(myVar2008$Origin == 'ORD')
#flights arrived at O'Hare Airport
sum(myVar2008$Dest == 'ORD')
#flights in the data set departed from the Indianapolis Airport (IND) and arrived at the O'Hare Airport (ORD)
sum(myVar2008$Origin == 'IND' & myVar2008$Dest == 'ORD')
sum(myVar2008$Origin == 'SAN' & myVar2008$Dest == 'MEX')
# flights departed from TUP in 2008
sum(myVar2008$Origin == 'TUP')
sum(myVar2008$Dest == 'LGA')
sum(myVar2008$Dest == 'ORD')
sum(myVar2008$Origin == 'JFK' & myVar2008$Dest == 'SAN')

MySANorigins <- subset(myVar2008, myVar2008$Origin == 'SAN')
head(MySANorigins)
# Creation subset from existent data
SanDiegoDestinations <- subset(myVar2008, myVar2008$Dest == 'SAN')
# Testing data from the subset
head(SanDiegoDestinations)
table(SanDiegoDestinations$Month)
# Using plot to create a graphic about number of flight 
# on which SAN where the destination by month
plot(table(SanDiegoDestinations$Month))
plot(table(MySANorigins$Month))

sum(myVar2008$Origin == 'TUP')
head(myVar2008$DepDelay == 'TUP')
# average departure delay of the flights that depart from TUP in 2008
mean(myVar2008$DepDelay == 'TUP')
?mean
mean(myVar2008$DepDelay == 'TUP', na.rm = TRUE)
# Flights that departed from SD before 6 AM
sum(MySANorigins$DepTime  < 600, na.rm = TRUE)
MyDFTUPdelay <- subset(myVar2008, myVar2008$Origin == 'TUP')
mean(MyDFTUPdelay$DepDelay)
# flights arrived at LAX in 2008
sum(myVar2008$Dest  == 'LAX', na.rm = TRUE)

LAXarrivals2008 <- subset(myVar2008, myVar2008$Dest  == 'LAX')
head(LAXarrivals2008)
# Getting the number of flights from Atlanta to Los Angeles 2008
sum(myVar2008$Origin == 'ATL' & myVar2008$Dest == 'LAX')
flightsFromATLtoLAX2008 <- subset(myVar2008, myVar2008$Origin == 'ATL' & myVar2008$Dest == 'LAX')
sum(flightsFromATLtoLAX2008$DepTime <1200)
head(flightsFromATLtoLAX2008)
# departed from ATL and landed at LAX in 2008, cleaned
sum(flightsFromATLtoLAX2008$DepTime  < 1200, na.rm = TRUE)

plot(table(floor(flightsFromATLtoLAX2008$DepTime/100)),main="Flights from ATL to LAX grouped by hours",xlab="Flight Departure Hour",ylab="Number of departures")

table(myVar2008$Origin)
sort(table(myVar2008$Origin))
head(myVar2008$DepTime)
seq(0, 2400, by=100)
table(cut(myVar2008$DepTime, breaks = seq(0, 2400, by=100)))

plot(table(cut(myVar2008$DepTime, breaks = seq(0, 2400, by=100))))


#usamos paste para juntar dos conjuntos
head(paste(myVar2008$Origin, "a", myVar2008$Dest))
table(paste(myVar2008$Origin, "a", myVar2008$Dest))
# se ordenan y se muestran los primeros origenes y destinos
head(sort(table(paste(myVar2008$Origin, "a", myVar2008$Dest))))
# verifica si realmente hubo solo 185 viajes que tuvieron frencuencia de uno en todo el año al conectar con otro destino
head(sort(table(paste(myVar2008$Origin, "a", myVar2008$Dest))), 286)
#comprobacion
#origin-to-destination paths were only flown one time (each) in 2008
sum(table(paste(myVar2008$Origin, "a", myVar2008$Dest)) == 1)

tapply(myVar2008$DepDelay, myVar2008$Origin, mean, na.rm=TRUE)
plot(tapply(myVar2008$DepDelay, myVar2008$Origin, mean, na.rm=TRUE))

# mean distance to destinations
tapply(myVar2008$Distance, myVar2008$Origin, mean, na.rm=TRUE)
sort(tapply(myVar2008$Distance, myVar2008$Origin, mean, na.rm=TRUE))

# mean time by day of week, all destinations
tapply(myVar2008$ArrDelay, myVar2008$DayOfWeek, mean, na.rm=TRUE)

# the previous situation but considering only San Diego
tapply(myVar2008$ArrDelay[myVar2008$Dest == "SAN"]
       , myVar2008$DayOfWeek[myVar2008$Dest == "SAN"], mean, na.rm=TRUE)


# aerolineas con el mejor tiempo en llegada
tapply(myVar2008$ArrDelay, myVar2008$UniqueCarrier, mean, na.rm=TRUE)

#cuentos vuelos ocurrieron por mes
table(myVar2008$Month)
tapply(myVar2008$Month, myVar2008$Month, length)

# Worsr departure delay
tapply(myVar2008$DepDelay, myVar2008$UniqueCarrier, mean, na.rm=TRUE)

# crea variable de las fechas
myDates <- paste(myVar2008$DayofMonth, myVar2008$Month, myVar2008$Year, sep = "/");
length(myVar2008$DepDelay)
length(myDates)

# el vector de fechas se utiliza para usarlo en los retrasos de fecha
sort(tapply(myVar2008$ArrDelay, myDates, mean, na.rm=TRUE))
plot(tapply(myVar2008$ArrDelay, myDates, mean, na.rm=TRUE))

#day of the year were the average departure delays the worst
sort(tapply(myVar2008$DepDelay, myDates, mean, na.rm=TRUE))
#average departure times the worst for flights departing from O'Hare (ORD)
sort(tapply(myVar2008$DepDelay[myVar2008$Origin=="ORD"], myDates[myVar2008$Origin=="ORD"], mean, na.rm=TRUE))

# entend example especifying destination and origin
pdxToSan <- myVar2008$Dest=="SAN" & myVar2008$Origin == "PDX"
length(pdxToSan == TRUE)
head(pdxToSan)

# find especific arrival delay according one route
#find expected arrival delay for flights from Portland to San Diego
sort(tapply(myVar2008$ArrDelay[pdxToSan], myDates[pdxToSan], mean, na.rm = TRUE))

atlToLax <- myVar2008$Dest=="LAX" & myVar2008$Origin == "ATL"
sort(tapply(myVar2008$DepDelay[atlToLax], myDates[atlToLax], mean, na.rm = TRUE))

# Identifying the most popular airports
?sort
sort(table(myVar2008$Origin)) #least popular at beginning
sort(table(myVar2008$Origin), decreasing = TRUE)[20] #numer 20 at top
mostPopular20 <- names(sort(table(myVar2008$Origin), decreasing = T)[1:20]) #real top 20

#calculation of how many of the flight originated in the top 20 airports
sum(myVar2008$Origin %in% mostPopular20) # it were 3597054

#how many from a most popular airport went to another most poular
sum(myVar2008$Origin %in% mostPopular20 & myVar2008$Dest %in% mostPopular20) # it were 1444883

# number of flight from less popular 200 airports
leastPopular200 <- names(sort(table(myVar2008$Origin), decreasing = F)[1:200])
sum(myVar2008$Origin %in% leastPopular200) # it were 551776

#how many flights originated in each airport
sort(table(myVar2008$Origin))

#how many in San Diego
table(myVar2008$Origin)["SAN"]
#SanDiego, LAX and SFO
table(myVar2008$Origin)[c("SAN", "SFO", "LAX")]
# or observe it from the mostpopular20
table(myVar2008$Origin)[mostPopular20]

# IAD, DCA observation on destination
table(myVar2008$Dest)[c("IAD", "DCA")]
table(myVar2008$Origin)[c("SAN", "SFO", "LAX")]

# from the first 20 flights were on time, two different ways to tell it
head(myVar2008$DepDelay <= 0, n=20)
(myVar2008$DepDelay <= 0)[1:20]

# tells how many flights departed on time or early
tapply(myVar2008$DepDelay <= 0, myVar2008$Origin, sum, na.rm=T)

#resticted attention to the first 20 airports in traffic
tapply(myVar2008$DepDelay <= 0, myVar2008$Origin, sum, na.rm=T)[mostPopular20]

#resticted attention in percentage to the first 20 airports in traffic
tapply(myVar2008$DepDelay <= 0, myVar2008$Origin, sum, na.rm=T)[mostPopular20] / table(myVar2008$Origin)[mostPopular20]

# double check the result for atlanta, looks right
233718 / 414513

# DEPARTED ON TIME FROM IND IN PERCENT
tapply(myVar2008$DepDelay <= 0, myVar2008$Origin, sum, na.rm=T)["IND"]/ table(myVar2008$Origin)["IND"]

# remembering plots and divide by cut to manager times better
v <- table(cut(myVar2008$DepTime, breaks = seq(0,2400, by=100)))
# another way to achieve the previous result
w <- table(ceiling(myVar2008$DepTime / 100))
# making sure its the same
v == w
# the beautiful representation
plot(w)

#We can break the data in the depDelay vector
# according to which city of origin or according to the month
tapply(myVar2008$DepDelay, myVar2008$Origin, length)
tapply(myVar2008$DepDelay, myVar2008$Month, length)

# We now know how many flights occur from each airport in each month
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)

# we can extract data from a especific row and for a particular column (month in this case)
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)["SAN", 12]

#notice we need to give 2 dimensions then we extract daya from aa matrix by x,y

#number of flights from 3 particular airports during first three months of the year
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)[c("SFO","LAX","SAN"),c(1,2,3)]
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)[c("SFO","LAX","SAN"),c(1:3)]

# june throught october departures ATL AUS, BDL, 2008
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)[c("ATL","AUS","BDL"),c(7:10)]
# TODO Do not manually add any numbers. Use the sum function.

# San Diego, but leaving the coma specification blank
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)["SAN", ]
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)[c("SAN", "SFO"),]

# the previous class and the dimension
class(tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)[c("SAN", "SFO"),])
dim(tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)[c("SAN", "SFO"),])

# data frame for flight delayed more than 30 minutes
longDelat2008DF <- subset(myVar2008, myVar2008$DepDelay >30)
# dimension 
dim(longDelat2008DF)

# cantidad de vuelos de SFO o SAN de acuerdo al mes
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)[c("IND", "ORD"), ]
# same, but applied to flights with delays of more than 30 minutes
tapply(longDelat2008DF$DepDelay, list(longDelat2008DF$Origin, longDelat2008DF$Month), length)[c("IND", "ORD"), ]
#flights departed altogether from IND or ORD in 2008 with a delay of more than 30 minutes each
sum(tapply(longDelat2008DF$DepDelay, list(longDelat2008DF$Origin, longDelat2008DF$Month), length)[c("IND", "ORD"), ])

# the previous information but applied for the case of percentage
M1 <- tapply(longDelat2008DF$DepDelay, list(longDelat2008DF$Origin, longDelat2008DF$Month), length)[c("IND", "ORD"), ]
M2 <- tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$Month), length)[c("IND", "ORD"), ]
M1 / M2

# plotting with dotchart
dotchart(M1 / M2)

sum(tapply(longDelat2008DF$DepDelay, list(longDelat2008DF$Origin, longDelat2008DF$Month), length)[c("IND", "ORD"), ])

# time of day for departure
# the day is divided in fout parts with this aproach
# 1 is early monring, 2 is late morning which means until midday and so on...
v <- ceiling(myVar2008$DepTime/600)

# build vector for parts of the day
# inicialize vector fpr each one with NA
?rep
partoftheday <- rep(NA, times=dim(myVar2008)[1])
head(partoftheday)
length(partoftheday)
partoftheday[v == 1] <- "temprano por la maniana"
partoftheday[v == 2] <- "tarde por la maniana"
partoftheday[v == 3] <- "temprano por la tarde"
partoftheday[v == 4] <- "tarde-noche"

# double chech for partodtheday dim's against data in myvar2008
length(partoftheday)
dim(myVar2008)

# create new column for time of day
myVar2008$timeOfDay <- partoftheday
# now my df has 30 columnos not 29
dim(myVar2008)

#making sure 6 first flights
head(myVar2008$timeOfDay)
head(myVar2008$DepTime)

# departing from IND early in the morning
tapply(myVar2008$timeOfDay, list(myVar2008$Origin, myVar2008$timeOfDay), length)[c("IND"), ]

tail(myVar2008$timeOfDay)
tail(myVar2008$DepTime)

# vuelos totales con salida tardia clsificada de acuerdo a la clasificacion de tiempo
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$timeOfDay), length)
dim(tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$timeOfDay), length)) # 303 filas una por ciudad, 4 columnas una por tiempo en el dia

# vuelos totales con salida tardia clsificada de acuerdo a la clasificacion de tiempo, concentrado a SFO y SAN
tapply(myVar2008$DepDelay, list(myVar2008$Origin, myVar2008$timeOfDay), length)[c("SFO", "SAN"), ]

myVar2007 <- read.csv("D://R-intro-data-science/2007.csv.bz2")
myVar2006 <- read.csv("D://R-intro-data-science/2006.csv.bz2")
# making sure dimension are alright
dim(myVar2008)
# overwriting myvar2008 because it might have 30 columns
myVar2008 <- read.csv("D://R-intro-data-science/2008.csv.bz2")
# making sure dimension are alright, again
dim(myVar2008)
dim(myVar2007)
dim(myVar2006)
myLargaDF <- rbind(myVar2006, myVar2007, myVar2008)
dim(myLargaDF)
# cleaning memory
rm(myVar2006, myVar2007, myVar2008)
# making sure all the years are available
unique(myLargaDF$Year)

# LAX departures thorud period
table(myLargaDF$Origin)["LAX"]

# Efficiently arraging data
# if we compose a table with origins and destinations we'll got and immense table
myNewtable <- table(list(myLargaDF$Origin, myLargaDF$Dest))
dim(myNewtable) # the dimension is too big
sum(myNewtable == 0) # most of the values are sadly zero
sum(myNewtable != 0) #only 6266 are accountable
# Using a paste instead a table will do data structures more effective
myNewPastedtable <- table(paste(myLargaDF$Origin, myLargaDF$Dest))
myNewPastedtable["SAN SFO"] #16206 flights from SAN to SFO from 2006-2008

myNewPastedtable["IND ORD"] #11254 flights from IND to ORD from 2006-2008

# data frame for flights between boston en denver from only 2007 taken from the 3 year dataSet
only2007DF <- subset(myLargaDF, myLargaDF$Year == 2007)
myNewtableBOSDEN <- table(paste(only2007DF$Origin, only2007DF$Dest))["BOS DEN"] #2445 flights in 2007
myNewtableBOSDEN

# visaulization for the table myNewtable
plot(myNewPastedtable)
# we start to focus in IND data
dotchart(sort(myNewPastedtable)) #but none of this plots look helpful

head(myNewtable["IND",])
plot(myNewtable["IND",])

# start to focus on in plot data saved on a vector
v <- myNewtable["IND",]
# so we can do arrangements and projections from data
dotchart(sort(v[v != 0])) # but there are still many destination
dotchart(sort(v[v > 4000])) # we care about airports with more than 4000 flights
pie(v[v > 4000], names(v[v > 4000])) # pie chart from airports with more than 4000 flights to IND


san <- myNewtable["SAN",]
dotchart(sort(san[san > 4000])) # we care about airports with more than 4000 flights
dotchart(sort(v[v > 4000]),col="red",xlab="SAN",ylab="Destination",cex.axis=1) # enhanced version

#EXTRA
#Create a Visualization discussion point Week 4 
# Create a subset of flights from ..
z <- subset(myLargaDF,myLargaDF$Origin == "SAN" & myLargaDF$Dest == "SFO") 
# Load ggplot2 
library("ggplot2")
# Plot Departure delays against Month and Days of the Week 
ggplot(z,aes(z$Month,z$DepDelay)) + geom_point() #december the month with most delays
ggplot(z,aes(z$DayOfWeek,z$DepDelay)) + geom_point() #Friday the day with more delays, but thurssday is close on frequency

# adding supplementary data to analysis
airportsDF <- read.csv("D://R-intro-data-science/airports.csv")
dim(airportsDF)
head(airportsDF)[1:3]
airportsDF[airportsDF$iata == "SAN",]
airportsDF[airportsDF$iata %in% c("SAN", "SFO", "LAX"),] # California CASE

# vector to store airport name, city and state
newX <- paste(airportsDF$airport, airportsDF$city, airportsDF$state, sep=", ")
head(newX)
tail(newX)

# name threatment
# be the three letter airpot from iata
names(newX) <- airportsDF$iata
head(newX)
tail(newX)
newX[c("SAN", "SFO", "LAX")]

table(airportsDF$city)["Chicago"] #three airpots in Chicago
# heres another example
airportsDF <- read.csv("airports.csv")
sum(airportsDF$city == "Chicago", na.rm = T)

# dtaa from plot, we want to know where they are the flishts with IND
v[v > 4000]
newX[names(v[v > 4000])]
# this is the data we plotted
myvec <- v[v > 4000]
names(myvec) <- newX[names(v[v > 4000])]
myvec
dotchart(sort(myvec)) #we can create more flexible dotcharts

# review of airport data
head(airportsDF)

table(airportsDF$state) # states with airports
indianaAirports <- subset(airportsDF, state == "IN") # airports from Indiana

table(myLargaDF$Origin) # total origins 2005-2008
table(myLargaDF$Origin)["IND"] #origins 

#identifying airports with commercial flights, because they have iata
as.character(indianaAirports$iata)
table(myLargaDF$Origin)[as.character(indianaAirports$iata)]

vIndianaIATA <-table(myLargaDF$Origin)[as.character(indianaAirports$iata)]
vIndianaIATA[!is.na(vIndianaIATA)] # detecting ariport which are indiana with IATA
names(vIndianaIATA[!is.na(vIndianaIATA)])

subset(airportsDF, iata %in% names(vIndianaIATA[!is.na(vIndianaIATA)])) # from 60 airports from IND only 4 are working internationally

# Number of californian airposrts with at least one flight
caliAirports <- subset(airportsDF, state == "CA") # airports from Cali
#identifying airports with commercial flights, because they have iata in CA
as.character(caliAirports$iata)
table(myLargaDF$Origin)[as.character(caliAirports$iata)]#origins from the Golden State
vCaliIATA <-table(myLargaDF$Origin)[as.character(caliAirports$iata)]
vCaliIATA[!is.na(vCaliIATA)] # detecting ariport which are indiana with IATA
length(names(vCaliIATA[!is.na(vCaliIATA)])) # total of 26 airports

# building a function to identify the previous (airport with commercial flights) from a given state
myState <- "IN"
myAirportsFromState <- subset(airportsDF, state == myState)
myPreselectedOriginis <- table(myLargaDF$Origin)[as.character(myAirportsFromState$iata)]
subset(airportsDF, iata %in% names(myPreselectedOriginis[!is.na(myPreselectedOriginis)])) # from 60 airports from IND only 4 are working internationally

# the previous four line but in a state determined by the user in the function activeairports
activeAirports <- function(myState) {
  myAirportsFromState <- subset(airportsDF, state == myState)
  myPreselectedOriginis <- table(myLargaDF$Origin)[as.character(myAirportsFromState$iata)]
  subset(airportsDF, iata %in% names(myPreselectedOriginis[!is.na(myPreselectedOriginis)])) 
}
activeAirports("CA")

sapply(state.abb,function(x) dim(activeAirports(x))[1])[c("CA","PA","VA")] # with sapply

# incoporating tailnumbers from planes

tail(sort(tapply(myLargaDF$Distance, myLargaDF$TailNum, sum))) #miles flown by airplanes sorted
head(sort(tapply(myLargaDF$Distance, myLargaDF$TailNum, sum))) #miles flown by airplanes sorted

# here is an admiteddly terrible plot
dotchart(sort(tapply(myLargaDF$Distance, myLargaDF$TailNum, sum))) #miles flown by airplanes sorted
# diving further
vFlightsMileage <- sort(tapply(myLargaDF$Distance, myLargaDF$TailNum, sum))
head(vFlightsMileage)
topMostUsedPlanes <- tail(vFlightsMileage, 25)
topMostUsedPlanes <- topMostUsedPlanes[1:20] #top 20
names(topMostUsedPlanes)

planesDF <- read.csv("D://R-intro-data-science/plane-data.csv")
head(planesDF, n=20) # first 20 from df

subset(planesDF, tailnum %in% names(topMostUsedPlanes)) # where do tailnum comes from?

table(myLargaDF$TailNum)["N556AS"] # 5071 flights from N556AS plane

# reality check, hoe many days there are from 2006 to 2008
365+365+366 # 1096

# month abb stores month names
month.abb
month.abb[c(1,1,4,6,2,5)]

# first 6 flights months
head(month.abb[myLargaDF$Month])
last(month.abb[myLargaDF$Month]) # and lasts

# making sense of month,abb with paste
paste(myLargaDF$DayofMonth, month.abb[myLargaDF$Month], myLargaDF$Year)
myDatesOfFlight <- paste(myLargaDF$DayofMonth, month.abb[myLargaDF$Month], myLargaDF$Year) # assign to something for later storage
length(myDatesOfFlight) # reality check

#departure delays by day
tapply(myLargaDF$DepDelay, myDatesOfFlight, mean, na.rm=T) # on 7 feb 2008 the dep delay was 8.667992348 minutes

head(sort(tapply(myLargaDF$DepDelay, myDatesOfFlight, mean, na.rm=T))) # days with smallest average dep delays
tail(sort(tapply(myLargaDF$DepDelay, myDatesOfFlight, mean, na.rm=T)), n=20) # top 20 days with biggest average dep delays

#Which date during the period 2006-2008 had the most flights? It is supposed to be the 27th july 2007, but still dont know why
head(sort(tapply(myLargaDF$FlightNum, myDatesOfFlight, sum, na.rm=T)), n=2)
