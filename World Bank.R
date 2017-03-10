####World Bank Government spending data
library(WDI)

possible_dir <- c('/Users/alvarolopezguiresse/GoogleDrive/[] ADMINISTRACION PUBLICA/THESIS/Thesis', '/Users/mariorodriguez/Desktop/Thesis')
repmis::set_valid_wd(possible_dir)

WorldBank <- WDI(country = 'all', start = '1986', end = '2015', indicator = c('SI.POV.GINI', 'NY.GDP.PCAP.PP.CD', 'GC.XPN.TOTL.GD.ZS', 'NY.GDP.MKTP.CD'), extra = TRUE)
