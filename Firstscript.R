####Cargar los paquetes que necesitamos para limpiar los datos

library(WDI)
library(countrycode)
library(xlsx)
library(repmis)
library(tidyr)
library(WDI)

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

IDEA <- read.xlsx("graficas_y_analisis_v2.xlsx", 1)

IDEA$ccodealp <- countrycode(IDEA$country, 'country.name', 'iso3c', warn = FALSE)

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

####Abrir datos del WEF-Judicial Independence

WEFJI <- read.xlsx("WEFJudInd.xlsx", 1)


#####Como limpiamos 

WEFJIclean <- gather(WEFJI, country, wefji, Albania:Zimbabwe)

WEFJI <- write.csv(WEFJIclean, "WEFJudicialIndependence.csv")

WEFJI <- read.csv("WEFJudicialIndependence.csv")
#####Descargar datos del world bank

WorldBank <- WDI(country = 'all', start = '1996', end = '2015', indicator = c('SI.POV.GINI', 'SP.DYN.LE00.IN', 'NY.GDP.MKTP.CD'), extra = FALSE)


