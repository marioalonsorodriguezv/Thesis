####Cargar los paquetes que necesitamos para limpiar los datos

library(WDI)
library(countrycode)
library(xlsx)
library(repmis)
library(tidyr)
library(WDI)
library(XML)
library(plyr)
library(plm)

possible_dir <- c('/Users/alvarolopezguiresse/GoogleDrive/[] ADMINISTRACION PUBLICA/THESIS/Thesis', '/Users/mariorodriguez/Desktop/Thesis')
repmis::set_valid_wd(possible_dir)

#####Abrir la base de Gotemburgo y limpiarla por años

QoGts <- read.csv('qog_std_ts.csv')

QoGts<-QoGts[!(QoGts$year==1946),]
QoGts<-QoGts[!(QoGts$year==1947),]
QoGts<-QoGts[!(QoGts$year==1948),]
QoGts<-QoGts[!(QoGts$year==1949),]
QoGts<-QoGts[!(QoGts$year==1950),]
QoGts<-QoGts[!(QoGts$year==1951),]
QoGts<-QoGts[!(QoGts$year==1952),]
QoGts<-QoGts[!(QoGts$year==1953),]
QoGts<-QoGts[!(QoGts$year==1954),]
QoGts<-QoGts[!(QoGts$year==1955),]
QoGts<-QoGts[!(QoGts$year==1956),]
QoGts<-QoGts[!(QoGts$year==1957),]
QoGts<-QoGts[!(QoGts$year==1958),]
QoGts<-QoGts[!(QoGts$year==1959),]
QoGts<-QoGts[!(QoGts$year==1960),]
QoGts<-QoGts[!(QoGts$year==1961),]
QoGts<-QoGts[!(QoGts$year==1962),]
QoGts<-QoGts[!(QoGts$year==1963),]
QoGts<-QoGts[!(QoGts$year==1964),]
QoGts<-QoGts[!(QoGts$year==1965),]
QoGts<-QoGts[!(QoGts$year==1966),]
QoGts<-QoGts[!(QoGts$year==1967),]
QoGts<-QoGts[!(QoGts$year==1968),]
QoGts<-QoGts[!(QoGts$year==1969),]
QoGts<-QoGts[!(QoGts$year==1970),]
QoGts<-QoGts[!(QoGts$year==1971),]
QoGts<-QoGts[!(QoGts$year==1972),]
QoGts<-QoGts[!(QoGts$year==1973),]
QoGts<-QoGts[!(QoGts$year==1974),]
QoGts<-QoGts[!(QoGts$year==1975),]
QoGts<-QoGts[!(QoGts$year==1976),]
QoGts<-QoGts[!(QoGts$year==1977),]
QoGts<-QoGts[!(QoGts$year==1978),]
QoGts<-QoGts[!(QoGts$year==1979),]
QoGts<-QoGts[!(QoGts$year==1980),]
QoGts<-QoGts[!(QoGts$year==1981),]
QoGts<-QoGts[!(QoGts$year==1982),]
QoGts<-QoGts[!(QoGts$year==1983),]
QoGts<-QoGts[!(QoGts$year==1984),]
QoGts<-QoGts[!(QoGts$year==1985),]
QoGts<-QoGts[!(QoGts$year==1986),]
QoGts<-QoGts[!(QoGts$year==1987),]
QoGts<-QoGts[!(QoGts$year==1988),]
QoGts<-QoGts[!(QoGts$year==1989),]
QoGts<-QoGts[!(QoGts$year==1990),]
QoGts<-QoGts[!(QoGts$year==1991),]
QoGts<-QoGts[!(QoGts$year==1992),]
QoGts<-QoGts[!(QoGts$year==1993),]
QoGts<-QoGts[!(QoGts$year==1994),]
QoGts<-QoGts[!(QoGts$year==2016),]

####Abrir la base de IDEA con control of corruption

IDEA <- read.csv("AnalisisR.csv")

IDEA$ccodealp <- countrycode(IDEA$Country, 'country.name', 'iso3c', warn = FALSE)

IDEA <- IDEA[, -2]

Merged <- merge(IDEA, QoGts, by = c('ccodealp', 'year'))

write.csv(Merged, file = "DatabaseCombined.csv")

Merged <- read.csv('DatabaseCombined.csv')

Merged <- Merged[, -1]

MergedSelect <- Merged[, c('ccodealp', "year", "country", "region", "incomegroup", "idea_index", "undp_hdi", 'bti_ij', 'ciri_injud', 'h_j', 'wef_ji', 'fi_index')]

COC <- read.xlsx("database.xlsx", 6)

COC <- COC[!(COC$country=='KOSOVO'),]

COC$ccodealp <- countrycode(COC$country, 'country.name', 'iso3c', warn = TRUE)

names(COC)[names(COC)=="y"] <- "wb_coc"

COC <- COC[, c('year', 'wb_coc', 'ccodealp')]

MergedSelect <- merge(COC, MergedSelect, by = c('ccodealp', 'year'))

VerifyMergedSelect <- MergedSelect[, c('country', 'year')]

MergedSelect[duplicated(MergedSelect),]

MergedSelect <- MergedSelect[!duplicated(MergedSelect),]

fixed <- plm(wb_coc ~ idea_index, data=MergedSelect, index=c("country", "year"), model="within")

summary(fixed)

##############Analisis de R


####Abrimos última versión de la base de IDEA y le agregamos el iso3c

IDEA <- read.csv("AnalisisR.csv")

ncol(IDEA)

IDEA <- IDEA[, -(39:41)]

colnames(IDEA)[1] <- "country"

IDEA$iso3c <- countrycode(IDEA$country, 'country.name', 'iso3c', warn = TRUE)

####Abrir datos del WEF-Judicial Independence

WEFJI <- read.xlsx("WEFJudInd.xlsx", 1)

#####Limpiar la del base del WEF y agregamos el iso3c

WEFJIclean <- gather(WEFJI, country, wefji, Albania:Zimbabwe)
  
WEFJIclean$iso3c <- countrycode(WEFJIclean$country, 'country.name', 'iso3c', warn = TRUE)

WEFJI <- write.csv(WEFJIclean, "WEFJudicialIndependence.csv")

WEFJI <- read.csv("WEFJudicialIndependence.csv")

WEFJI <- WEFJI[,-(1)] 

WEFJI <- WEFJI[,-(2)] 

#####Descargar datos del world bank y limpiarlos

WorldBank <- WDI(country = 'all', start = '1996', end = '2015', indicator = c('SI.POV.GINI', 'SP.DYN.LE00.IN', 'NY.GDP.MKTP.CD'), extra =TRUE)

WorldBank <- WorldBank[-(1:100), ]

WorldBank <- WorldBank[, (3:7)]

sapply(WorldBank, class)

colnames(WorldBank)[2] <- "gini"
colnames(WorldBank)[3] <- "lifeexpectancy"
colnames(WorldBank)[4] <- "GDP"

#####Abrir la base de datos de la Cepal

CepalGastos <- read.csv("CepalGastos.csv")

colnames(CepalGastos)[8] <- "1996"
colnames(CepalGastos)[9] <- "1997"
colnames(CepalGastos)[10] <- "1998"
colnames(CepalGastos)[11] <- "1999"
colnames(CepalGastos)[12] <- "2000"
colnames(CepalGastos)[13] <- "2001"
colnames(CepalGastos)[14] <- "2002"
colnames(CepalGastos)[15] <- "2003"
colnames(CepalGastos)[16] <- "2004"
colnames(CepalGastos)[17] <- "2005"
colnames(CepalGastos)[18] <- "2006"
colnames(CepalGastos)[19] <- "2007"
colnames(CepalGastos)[20] <- "2008"
colnames(CepalGastos)[21] <- "2009"
colnames(CepalGastos)[22] <- "2010"
colnames(CepalGastos)[23] <- "2011"
colnames(CepalGastos)[24] <- "2012"
colnames(CepalGastos)[25] <- "2013"
colnames(CepalGastos)[26] <- "2014"
colnames(CepalGastos)[27] <- "2015"

CepalGastos <- CepalGastos[,-(2:7)] 

CepalGastos <- gather(CepalGastos, country, CepalGastos)

colnames(CepalGastos)[2] <- "year"

CepalGastos$iso3c <- countrycode(CepalGastos$country, 'country.name', 'iso3c', warn = TRUE)

CepalGastos <- CepalGastos[,-(1)] 

####Juntar las cuatro bases de datos 

AnalisisRCompleta <- merge(IDEA, WorldBank, by = c('iso3c', 'year'))

write.csv(AnalisisRCompleta, file = "AnalisisRCompleta.csv")

AnalisisRCompletaWEF <- merge(AnalisisRCompleta, WEFJI, by = c('iso3c', 'year'))

write.csv(AnalisisRCompletaWEF, file = "AnalisisRCompletaWEF.csv")

AnalisisAL <- merge(AnalisisRCompleta, CepalGastos, by = c('iso3c', 'year'))

write.csv(AnalisisAL, file = "AnalisisAL.csv")

#####Abrir 