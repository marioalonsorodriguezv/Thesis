install.packages('xlsx')
install.packages('rJava')
install.packages('WDI')
install.packages('countrycode')
install.packages('tidyr')
install.packages('XML')
install.packages('plm')

library(WDI)
library(countrycode)
library(xlsx)
library(openxlsx)
library(repmis)
library(tidyr)
library(WDI)
library(XML)
library(plyr)
library(plm)
library(dplyr)


possible_dir <- c('/Users/alvarolopezguiresse/GoogleDrive/[] ADMINISTRACION PUBLICA/tesis/Thesis', '/Users/mariorodriguez/Desktop/Thesis')
repmis::set_valid_wd(possible_dir)


######################################################################
######################################################################
######################################################################
############## Data management.



# --> Abrir la base de Gotemburgo y limpiarla por a??os
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
QoGts<-QoGts[!(QoGts$year==1995),]
QoGts<-QoGts[!(QoGts$year==2016),]

# --> Abrir la base de IDEA con control of corruption
rm(COC, IDEA, Merged, MergedSelect, WEFJI,VerifyMergedSelect)

IDEA <- read.csv("AnalisisR.csv")
IDEA <- IDEA[, -c(2,39,40,41)]
names(IDEA)[names(IDEA)=="Country"] <- "country"
IDEA$ccodealp <- countrycode(IDEA$country, 'country.name', 'iso3c', warn = TRUE)



### --> Se combina IDEA con la QoGts a trav??s de c('ccodealp', 'year')
### --> Hay observaciones duplicadas... cuales?
Merged <- merge(IDEA, QoGts, by = c('ccodealp', 'year'))
write.csv(Merged, file = "DatabaseCombined.csv")
Merged <- read.csv('DatabaseCombined.csv')
Merged <- Merged[, -1]



### --> keeps the relevant variables for the analysis.
MergedSelect <- Merged[, c('ccodealp', "year", "country", "wb_region", "wb_income", "idea_pct", "undp_hdi", 'bti_ij', 'ciri_injud', 'h_j', 'wef_ji', 'fi_index')]



### --> reads WGI CoC.
COC <- read.xlsx("database.xlsx", 1)
COC <- COC[!(COC$country=='KOSOVO'),]
COC$ccodealp <- countrycode(COC$country, 'country.name', 'iso3c', warn = TRUE)
names(COC)[names(COC)=="cocwb"] <- "wb_coc"
COC <- COC[, c('year', 'wb_coc', 'ccodealp')]



### --> Combines data COC & MergedSelect.
MergedSelect <- merge(COC, MergedSelect, by = c('ccodealp', 'year'))



### --> Valores duplicados.
# --? VerifyMergedSelect <- MergedSelect[, c('country', 'year')]
MergedSelect[duplicated(MergedSelect),]
MergedSelect <- MergedSelect[!duplicated(MergedSelect),]
MergedSelect[duplicated(MergedSelect),]

write.csv(MergedSelect, file = "MergedSelect.csv")
fixed <- plm(wb_coc ~ idea_pct, data=MergedSelect, index=c("country", "year"), model="within")
summary(fixed)



######################################################################
######################################################################
###################################################################### 
# Analisis de R



### --> Abrimos ultima version de la base de IDEA y le agregamos el iso3c
IDEA <- read.csv("AnalisisR.csv")
ncol(IDEA)
IDEA <- IDEA[, -(39:41)]
colnames(IDEA)[1] <- "country"
IDEA$iso3c <- countrycode(IDEA$country, 'country.name', 'iso3c', warn = TRUE)
WEFJI <- read.xlsx("WEFJudInd.xlsx", 1)



### --> Limpiar la del base del WEF y agregamos el iso3c
WEFJIclean <- gather(WEFJI, country, wefji, Albania:Zimbabwe)



### -->   
WEFJIclean$iso3c <- countrycode(WEFJIclean$country, 'country.name', 'iso3c', warn = TRUE)
WEFJI <- write.csv(WEFJIclean, "WEFJudicialIndependence.csv")
WEFJI <- read.csv("WEFJudicialIndependence.csv")
WEFJI <- WEFJI[,-c(1,3)] 



### --> Descargar datos del world bank y limpiarlos
WorldBank <- WDI(country = 'all', start = '1996', end = '2015', indicator = c('SI.POV.GINI', 'SP.DYN.LE00.IN', 'NY.GDP.MKTP.CD'), extra =TRUE)
WorldBank <- WorldBank[-(1:100), ]
WorldBank <- WorldBank[, (3:7)]
sapply(WorldBank, class)
colnames(WorldBank)[2] <- "gini"
colnames(WorldBank)[3] <- "lifeexpectancy"
colnames(WorldBank)[4] <- "GDP"



### --> Abrir la base de datos de la Cepal
CepalGastos <- read.csv("CepalGastos.csv")
a <- c("country",1990:2015)
names(CepalGastos) <- a
CepalGastos <- CepalGastos[,-(2:7)] 
# --? dim(CepalGastos)
# --? paste(x,sep = "",collapse = NULL)

CepalGastos <- gather(CepalGastos, "year", "publicinvestment", 2:21)
CepalGastos$iso3c <- countrycode(CepalGastos$country, 'country.name', 'iso3c', warn = TRUE)
# colnames(CepalGastos)[2] <- "year"

CepalGastos$iso3c[which(CepalGastos$country == "REP. DOMINICANA")] <- "DOM"
# subset(CepalGastos, country == "REP. DOMINICANA") 
# CepalGastos %>% filter(country == "REP. DOMINICANA") %>% filter(year >= 1996 & year <= 2000)
# subset(CepalGastos, country=="REP. DOMINICANA" & (year >=1996 & year<=2000))
# CepalGastos <- CepalGastos[,-(1)] 



### --> Juntar las cuatro bases de datos 
AnalisisRCompleta <- merge(IDEA, WorldBank, by = c('iso3c', 'year'))
write.csv(AnalisisRCompleta, file = "AnalisisRCompleta.csv")
AnalisisRCompletaWEF <- merge(AnalisisRCompleta, WEFJI, by = c('iso3c', 'year'))
write.csv(AnalisisRCompletaWEF, file = "AnalisisRCompletaWEF.csv")
AnalisisAL <- merge(AnalisisRCompleta, CepalGastos, by = c('iso3c', 'year'))
write.csv(AnalisisAL, file = "AnalisisAL.csv")





