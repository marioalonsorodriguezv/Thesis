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
library(stargazer)
library(ggplot2)
library(plotly)
library(plm)
library(googleVis)
library(reshape2)
library(foreign)
library(calibrate)
library(rworldmap)
library(magrittr)

possible_dir <- c('/Users/alvarolopezguiresse/GoogleDrive/[] ADMINISTRACION PUBLICA/tesis/Thesis', '/Users/mariorodriguez/Desktop/Thesis')
repmis::set_valid_wd(possible_dir)


##############Analisis de R


####Abrimos ??ltima versi??n de la base de IDEA y le agregamos el iso3c

IDEA <- read.csv("AnalisisR.csv")

ncol(IDEA)

IDEA <- IDEA[, -(39:41)]

colnames(IDEA)[1] <- "country"

IDEA$iso3c <- countrycode(IDEA$country, 'country.name', 'iso3c', warn = TRUE)

names(IDEA)[1] <- c("country.IDEA")

####Abrir datos del WEF-Judicial Independence

WEFJI <- read.xlsx("WEFJudInd.xlsx", 1)

#####Limpiar la del base del WEF y agregamos el iso3c

WEFJIclean <- gather(WEFJI, country, wefji, Albania:Zimbabwe)
  
WEFJIclean$iso3c <- countrycode(WEFJIclean$country, 'country.name', 'iso3c', warn = TRUE)

WEFJI <- write.csv(WEFJIclean, "WEFJudicialIndependence.csv")

WEFJI <- read.csv("WEFJudicialIndependence.csv")

WEFJI <- WEFJI[,-(1)] 

#####Descargar datos del world bank y limpiarlos

WorldBank <- WDI(country = 'all', start = '1996', end = '2015', indicator = c('SI.POV.GINI', 'SP.DYN.LE00.IN', 'NY.GDP.MKTP.CD', 'ny.gdp.totl.rt.zs', 'SP.RUR.TOTL.ZS', 'SE.TER.ENRR'), extra =TRUE)

WorldBank <- WorldBank[!is.na(WorldBank$iso3c),]

sapply(WorldBank, class)

colnames(WorldBank)[4] <- "gini"
colnames(WorldBank)[5] <- "lifeexpectancy"
colnames(WorldBank)[6] <- "GDP"
colnames(WorldBank)[7] <- "natres"
colnames(WorldBank)[8] <- "ruralpop"
colnames(WorldBank)[9] <- "tertiaryschool"
colnames(WorldBank)[2] <- "country.wb"


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
colnames(CepalGastos)[1] <- "country.cepal"


CepalGastos$iso3c <- countrycode(CepalGastos$country, 'country.name', 'iso3c', warn = TRUE)
CepalGastos$iso3c[CepalGastos$country=="REP. DOMINICANA"] <- "DOM"


#####Datos Gottemburgo

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


QoGts <- QoGts[, c( "cname", 'year','ccodealp', "fh_status","fh_fotpc", "dr_sg", 
                    "dr_eg", "hf_trade", "sgi_ecgf", "fi_index", "fi_index_cl", 
                    "hf_business", "hf_efiscore", "hf_financ", "hf_fiscal")]


QoGts <- QoGts[!QoGts$cname %in% c("Germany, East", "Germany, West", 
                                   "Korea, North", "Micronesia", "Serbia and Montenegro",
                                   "Cyprus (-1974)", "Ethiopia (-1992)", "France (-1962)", 
                                   "Malaysia (-1965)","Pakistan (-1970)", "USSR"),]

names(QoGts)[3]<-"iso3c"

# QoGts$iso3c <- countrycode(QoGts$cname, 'country.name', 'iso3c', warn = TRUE)


#####Datos FOTPS

FOTP <- read.xlsx("FOTPScores.xlsx", 1)

FOTP <- FOTP[, 1:21]

names(FOTP)[2:21] <- c(1996:2015)

FOTP<- gather(FOTP, "year", "FOTP", 2:21)

names(FOTP)[1] <- c("country")

FOTP <- FOTP[!is.na(FOTP$FOTP),]



FOTP$iso3c <- countrycode(FOTP$country, 'country.name', 'iso3c', warn = TRUE)

FOTP <- FOTP[!FOTP$country %in% c("Crimea","Germany, East", "Germany, West", 
                                   "Israeli-Occupied Territories and Palestinian Authority",
                                  "Micronesia","Kosovo", "Serbia and Montenegro", "Transkei", "Yemen, North"),]
FOTP <- FOTP[!is.na(FOTP$iso3c),]


names(FOTP)[1] <- c("country.fotp")


####Juntar las seis bases de datos 

AnalisisRCompleta <- merge(IDEA, WorldBank, by = c('iso3c', 'year'))

AnalisisRCompleta <- merge(AnalisisRCompleta, FOTP, by = c('iso3c', 'year'))

AnalisisRCompleta <- merge(AnalisisRCompleta, QoGts, by = c('iso3c', 'year'))

write.csv(AnalisisRCompleta, file = "AnalisisRCompleta.csv")

AnalisisRCompletaWEF <- merge(AnalisisRCompleta, WEFJI, by = c('iso3c', 'year'))

write.csv(AnalisisRCompletaWEF, file = "AnalisisRCompletaWEF.csv")

AnalisisAL <- merge(AnalisisRCompletaWEF, CepalGastos, by = c('iso3c', 'year'))

write.csv(AnalisisAL, file = "AnalisisAL.csv")


###Tiramos Serbia y Yemen del Norte

AnalisisRCompletaWEF <- read.csv('AnalisisRCompletaWEF.csv')

AnalisisRCompletaWEF <- AnalisisRCompletaWEF[, -1]

AnalisisRCompletaWEF <- AnalisisRCompletaWEF[!AnalisisRCompletaWEF$cname %in% c("Yemen, North",
                                                                                "Serbia"),]
write.csv(AnalisisRCompletaWEF, file = "AnalisisRCompletaWEF.csv")

#####Crear dataframes para el scatterplot y el heatmap

write.csv (IDEA, "IDEA.csv")

IDEAmapdata <- IDEA[IDEA$year == '2015',]

IDEAmapdata <- IDEAmapdata[, c("iso3c", "idea_pct")]

write.csv(IDEAmapdata, 'IDEAmapdata.csv')


IDEAmap <- gvisGeoChart(IDEAmapdata, locationvar = 'iso3c',
                       colorvar = 'idea_pct',
                       options = list(
                         colors = "['red', 'yellow']"
                       ))

print(IDEAmap, tag = 'chart')


####Guardar datos en dta

write.dta(AnalisisAL, 'AnalisisAL.dta', version = 10,
          convert.dates = TRUE, tz = "GMT",
          convert.factors = c("labels", "string", "numeric", "codes"))

write.dta(AnalisisRCompletaWEF, 'AnalisisRCompletaWEF.dta', version = 10,
          convert.dates = TRUE, tz = "GMT",
          convert.factors = c("labels", "string", "numeric", "codes"))

#####Recodificar coc e idea_pct

AnalisisAL <- read.csv("AnalisisAL.csv")

AnalisisAL <- AnalisisAL[,-(1)] 

AnalisisAL$CoCRecoded <- AnalisisAL$CoC + 2.5

AnalisisAL$CoCRecoded <- AnalisisAL$CoCRecoded * 2

AnalisisAL$IDEARecoded <- AnalisisAL$idea_pct * 100

write.csv(AnalisisAL, 'AnalisisAL.csv')

##### Crear Scatterplot con datos de 2015

AnalisisAL2015 <- AnalisisAL[(AnalisisAL$year=="2015"),]

p <- plot_ly(AnalisisAL2015, x = ~idea_pct, y = ~CoCRecoded, color = ~wefji, size = ~wefji,
             text= ~iso3c, type='scatter', mode= 'markers', 
             title="Effect of Political Finance Regulation on Control of Corruption 2006") %>% 
  add_annotations(x = AnalisisAL2015$idea_pct,
                  y = AnalisisAL2015$CoCRecoded,
                  text = rownames(AnalisisAL2015$iso3c),
                  xref = "x",
                  yref = "y",
                  showarrow = TRUE,
                  ax = 20,
                  ay = -40) %>%
                  layout(title ='Party Finance Reform and Control of Corruption 2015', 
                         xaxis = list(title='Political Finance Regulation'), 
                         yaxis = list(title='Control of Corruption'), autosize = F)
                         

p

##### Crear Scatterplot con datos de 2006

AnalisisAL <- read.csv('AnalisisAL.csv')

AnalisisAL2006 <- AnalisisAL[(AnalisisAL$year=="2006"),]

p2006 <- plot_ly(AnalisisAL2006, x = ~idea_pct, y = ~CoCRecoded, color = ~wefji, size = ~wefji,
             text= ~iso3c, type='scatter', mode= 'markers', title="Effect of Political Finance Regulation on Control of Corruption 2006") %>% 
  add_annotations(x = AnalisisAL2006$idea_pct,
                  y = AnalisisAL2006$CoCRecoded,
                  text = rownames(AnalisisAL2006$iso3c),
                  xref = "x",
                  yref = "y",
                  showarrow = T,
                  arrowhead = 4,
                  arrowsize = .5,
                  ax = 20,
                  ay = -40) %>% 
                  layout(title ='Party Finance Reform and Control of Corruption 2006', 
                  xaxis = list(title='Political Finance Regulation'), 
                  yaxis = list(title='Control of Corruption'), autosize = F)

p2006

##### Heatmap global

AnalisisRCompleta <- read.csv("AnalisisRCompleta.csv")

AnalisisRCompleta <- AnalisisRCompleta[,-(1)] 

AnalisisRCompleta$IDEARecoded <- AnalisisRCompleta$idea_pct * 100

AnalisisR2015 <- AnalisisRCompleta[(AnalisisRCompleta$year=="2015"),]

n <- joinCountryData2Map(AnalisisR2015, joinCode="ISO3", nameJoinColumn="iso3c")

mapCountryData(n, nameColumnToPlot="idea_pct", mapTitle="Political Finance Regulation Index 2015 (World)", colourPalette = 'heat', catMethod = "pretty")

##### Heatmap latinoamerica


n2 <- joinCountryData2Map(AnalisisAL2015, joinCode="ISO3", nameJoinColumn="iso3c")

mapCountryData(n2, nameColumnToPlot="idea_pct", mapTitle="Political Finance Regulation Index 2015 (Latin America)", mapRegion="latin america", colourPalette = "heat")


######Transformar gastos de cepal a numeros absolutos

AnalisisAL$CepalGastosAbs <- AnalisisAL$CepalGastos * AnalisisAL$GDP

AnalisisAL$CepalGastosAbs <- AnalisisAL$CepalGastosAbs / 100

AnalisisAL$CepalGastosAbs <- AnalisisAL$CepalGastosAbs / 1000000000

######Subset de Freedom House

AnalisisRCompletaWEF_fh <- AnalisisRCompletaWEF


####Regresion en r

AnalisisRCompletaWEF <- read.csv('AnalisisRCompletaWEF.csv')

m1 <- plm(CoC ~ idea_pct + natres + lifeexpectancy + wefji + wefji:natres + wefji:idea_pct, data=AnalisisRCompletaWEF, index= c('iso3c', 'year'), model = 'within')
summary(m1)

m2 <- plm(CoC ~ idea_pct + lifeexpectancy + natres + wefji:natres + wefji:idea_pct, data=AnalisisRCompletaWEF, index= c('iso3c', 'year'), model = 'random')
summary(m2)

m3 <- plm(CoC ~ idea_pct*wefji+ lifeexpectancy + CepalGastosAbs*wefji + ruralpop, data=AnalisisAL, index= c('iso3c', 'year'), model = 'within')
summary(m3)

stargazer(m3)

m4 <- plm(CoC ~ idea_pct*wefji+ lifeexpectancy + CepalGastosAbs*wefji + ruralpop, data=AnalisisAL, index= c('iso3c', 'year'), model = 'within')
summary(m4)


wefji <- read.csv('WEFJudicialIndependence.csv')
