library(xlsx)

possible_dir <- c('C:/RajuPC/CollaborativeSSDA/Assignments/Assignment4', '/Users/mariorodriguez/Desktop/Thesis')
repmis::set_valid_wd(possible_dir)


QoG <- read.csv('qog_std.csv')

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

IDEA <- read.xlsx("database.xlsx", 1)

IDEA$ccodealp <- countrycode(IDEA$country, 'country.name', 'iso3c', warn = FALSE)

Merged <- merge(IDEA, QoGts, by = c('ccodealp', 'year'))

write.csv(Merged, file = "DatabaseCombined.csv")