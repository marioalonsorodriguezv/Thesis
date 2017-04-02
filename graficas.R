
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
library(ggplot2)
library(plotly)
library(foreign)
library(gcookbook)
library(interplot)
library("margins")
library(grid)

setwd("/Users/alvarolopezguiresse/GoogleDrive/[] ADMINISTRACION PUBLICA/tesis/Thesis")

brewer.pal(n = 8, name = "Blues")
colorRampPalette(brewer.pal(9,"Blues"))(8)

############################################################################
# --> (1) Gr??fico de l??neas de evoluci??n en el tiempo del PFR dividido por 
# regiones: Am??rica, Europa, ??frica, Ocean??a, Asia.
#########################################################################
df <- read.csv("AnalisisRCompleta.csv")

# ->? se eliminan pa??ses con NA values.

# se calculan promedio por a??o.
gr_1 <- aggregate(idea_pct ~ year + un_region_name, data = df, FUN = function(x) mn = mean(x))

p1 <- ggplot(data=gr_1, aes(x=year, y=idea_pct, colour=un_region_name)) + 
  geom_line() + theme_bw() + 
  labs(title = "PFR Index time series by region 1996 - 2015", x="year", y="PFR Index") + 
  guides(color=guide_legend("Region")) + 
  theme(legend.position="bottom", legend.background = element_rect(colour = "black", 
                                                                   size = 0.5)) + 
  theme(panel.border=element_rect(fill=NA)) + 
  theme(plot.background = element_rect(colour = "black", size = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(strip.background=element_rect(fill="white")) + 
  theme(strip.background=element_rect(fill="white")) + 
  theme(plot.title = element_text(size = 10, face = "bold"), 
        legend.title=element_text(size=8) , legend.text=element_text(size=6), 
        legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
        plot.margin=unit(c(5,10,5,10),"mm")) 
p1
#################

# Latino America.
#################
df <- read.csv("AnalisisRCompleta.csv")
df <- df[df$iso3c %in% c("ARG", "BOL", "BRA", "CHL", "COL", "DOM", "ECU", "GTM", "HND", "MEX", 
                         "NIC", "PAN", "PER", "PRY", "SLV", "URY", "VEN"),]

# se calculan promedio por a??o.
gr_1la <- aggregate(cbind(idea_pct, blpi_pct, pf_pct, rs_pct, os_pct ) ~ year, 
                    data = df, FUN = function(x) mn = mean(x))

names(gr_1la)[2:6] <- c("PFR","BLPI","PF","RS","OS")
gr_1la <- gather(gr_1la, "subindex", "value", 2:6)

p1la <- ggplot(data=gr_1la, aes(x=year, y=value, colour=subindex)) + 
  geom_line() + theme_bw()


p1la <- p1la + 
  labs(title = "PFRI & Subindexes time series for Latin America 1996-2015", x="year", 
             y="Index") + 
  guides(color=guide_legend("Index"), labels = c("BLPI", "PFRI", "OS", "PF", "RS")) + 
  theme(legend.position="bottom", legend.background = element_rect(colour = "black", 
                                                                   size = 0.5)) + 
  theme(panel.border=element_rect(fill=NA)) + 
  theme(plot.background = element_rect(colour = "black", size = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(strip.background=element_rect(fill="white")) + 
  theme(strip.background=element_rect(fill="white")) + 
  theme(plot.title = element_text(size = 10, face = "bold"), 
        legend.title=element_text(size=8) , legend.text=element_text(size=6), 
        legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
        plot.margin=unit(c(5,10,5,10),"mm"))
p1la
#################


# Party finance subindex Global.
#################
df <- read.csv("AnalisisRCompleta.csv")

# se calculan promedio por a??o.
gr_1b <- aggregate(cbind(idea_pct, blpi_pct, pf_pct, rs_pct, os_pct ) ~ year + 
                      un_region_name, 
                    data = df, FUN = function(x) mn = mean(x))

names(gr_1b)[3:7] <- c("PFR","BLPI","PF","RS","OS")
gr_1b <- gather(gr_1b, "subindex", "value", 3:7)



p1b <- ggplot(data=gr_1b, aes(x=year, y=value, colour=subindex)) + 
  geom_line() + theme_bw() + facet_grid(~un_region_name)



p1b <- p1b + 
  labs(title = "PFR Subindexes time series all countries 1996-2015", x="year", 
       y="Index") + 
  guides(color=guide_legend("Index"), labels = c("BLPI", "PFRI", "OS", "PF", "RS")) + 
  theme(legend.position="bottom", legend.background = element_rect(colour = "black", 
                                                                   size = 0.5)) + 
  theme(panel.border=element_rect(fill=NA)) + 
  theme(plot.background = element_rect(colour = "black", size = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(strip.background=element_rect(fill="white")) + 
  theme(strip.background=element_rect(fill="white")) + 
  theme(plot.title = element_text(size = 10, face = "bold"), 
        legend.title=element_text(size=8) , legend.text=element_text(size=6), 
        legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
        plot.margin=unit(c(5,10,5,10),"mm"))
p1b
#################

############################################################################
# --> (2) Gr??fico de barras diferencia PFR 1996-2015, dividido por categor??a y 
# dentro de cada categor??a las cinco regiones.
#########################################################################
  df <- read.csv("AnalisisRCompleta.csv")
  gr_2 <- aggregate(cbind(blpi_pct, pf_pct, rs_pct, os_pct ) ~ year + 
                      un_region_name, data = df, FUN = function(x) mn = mean(x))
  gr_2_bar <- subset(gr_2, year=="2015" | year=="1996")
  gr_2_bar_r <- gather(gr_2_bar, "subindex", "value", 3:6)
  
  
  
  p2 <- ggplot(gr_2_bar_r,aes(un_region_name,value,fill=subindex)) +
    geom_bar(stat="identity",position="dodge", colour="black") + 
    facet_grid(~year) + theme_bw(base_size = 9)
  p2
  
  
  p2 <- p2 + 
    labs(title = "PFR Subindex level in 1996 & 2015", x = "Region", y = "PFR Subindex") 
  p2 <- p2 + 
    scale_fill_brewer(name="PFR Subindex", labels=c("BLPI", "PF", "RS","ROS"))
  p2 <- p2 + 
    theme(legend.position="bottom", legend.background = element_rect(colour = "black"))  
  p2 <- p2 + 
    theme(panel.border=element_rect(fill=NA)) + 
    theme(plot.background = element_rect(colour = "black", size = 0.5))
  p2 <- p2 + 
    theme(plot.title = element_text(hjust = 0.5))
  p2 <- p2 + 
    theme(strip.background=element_rect(fill="white")) + 
      theme(plot.title = element_text(size = 12, face = "bold"), 
            legend.title=element_text(size=9) , legend.text=element_text(size=8), 
            legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
            plot.margin=unit(c(10,10,10,10),"mm"))
  p2
#################

# Latin America
#################
  df <- read.csv("AnalisisRCompleta.csv")
  df <- df[df$iso3c %in% c("ARG", "BOL", "BRA", "CHL", "COL", "DOM", "ECU", "GTM", "HND", "MEX", 
                           "NIC", "PAN", "PER", "PRY", "SLV", "URY", "VEN"),]
  gr_2_bar <- subset(df, year=="2015" | year=="2006")
  gr_2_bar_r <- gather(gr_2_bar, "subindex", "value", 26:29)

  gr_2_bar_r1 <- gr_2_bar_r[gr_2_bar_r$iso3c %in% c("ARG", "BOL", "BRA", "CHL", "COL", "ECU", 
                                   "PER", "PRY", "URY", "VEN"),]
  gr_2_bar_r2 <- gr_2_bar_r[gr_2_bar_r$iso3c %in% c("DOM", "GTM", "HND", "MEX", "NIC", "PAN", "SLV"),]
  
  
  p2 <- ggplot(gr_2_bar_r1,aes(iso3c,value,fill=subindex)) +
    geom_bar(stat="identity",position="dodge", colour="black") + 
    facet_grid(~year) + theme_bw(base_size = 9)
  
  
  
  p2 <- p2 + 
    labs(title = "PFR index level for Latin America in 1996-2015", x = "Country", y = "PFR Index") 
  p2 <- p2 + 
    scale_fill_brewer(name="PFR Subindex", labels=c("BLPI", "PF", "RS","ROS"))
  p2 <- p2 + 
    theme(legend.position="bottom", legend.background = element_rect(colour = "black"))  
  p2 <- p2 + 
    theme(panel.border=element_rect(fill=NA)) + 
    theme(plot.background = element_rect(colour = "black", size = 0.5))
  p2 <- p2 + 
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(strip.background=element_rect(fill="white")) + 
    theme(plot.title = element_text(size = 12, face = "bold"), 
          legend.title=element_text(size=9) , legend.text=element_text(size=8), 
          legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
          plot.margin=unit(c(10,10,10,10),"mm"))
  p2
#################  
  
  p2b <- ggplot(gr_2_bar_r2,aes(iso3c,value,fill=subindex)) +
    geom_bar(stat="identity",position="dodge", colour="black") + 
    facet_grid(~year) + theme_bw(base_size = 9)
  
  
  
  p2b <- p2b + 
    labs(title = "PFR index level for Latin America in 1996-2015", x = "Country", y = "PFR Index") +
    scale_fill_brewer(name="PFR Subindex", labels=c("BLPI", "PF", "RS","ROS")) +
    theme(legend.position="bottom", legend.background = element_rect(colour = "black")) +
    theme(panel.border=element_rect(fill=NA)) + 
    theme(plot.background = element_rect(colour = "black", size = 0.5)) +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(strip.background=element_rect(fill="white")) + 
    theme(plot.title = element_text(size = 12, face = "bold"), 
          legend.title=element_text(size=9) , legend.text=element_text(size=8), 
          legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
          plot.margin=unit(c(10,10,10,10),"mm"))
  p2b
  #################  

############################################################################
# --> (3) Gr??fico de barras diferencia PFR & WB Control of Corruption CoC
# para 1996-2015, dividido por categor??a y 
# dentro de cada categor??a las cinco regiones.
############################################################################

# Data  
#################  
  
df <- read.csv("AnalisisRCompleta.csv")

# se hace el recode de las regiones
df$un_region_new <- "NULL"

# asia y oceania
df$un_region_new[which(df$un_intermediate._region_name == "Australia and New Zealand")] <- "Oceania"
df$un_region_new[which(df$un_intermediate._region_name == "Polynesia")] <- "Oceania"
df$un_region_new[which(df$un_intermediate._region_name == "Melanesia")] <- "Oceania"

df$un_region_new[which(df$un_intermediate._region_name == "Central Asia")] <- "Asia"
df$un_region_new[which(df$un_intermediate._region_name == "South-eastern Asia")] <- "Asia"
df$un_region_new[which(df$un_intermediate._region_name == "Southern Asia")] <- "Asia"
df$un_region_new[which(df$un_intermediate._region_name == "Western Asia")] <- "Asia"
df$un_region_new[which(df$un_intermediate._region_name == "Eastern Asia")] <- "Asia"

# africa
df$un_region_new[which(df$un_intermediate._region_name == "Eastern Africa")] <- "Africa"
df$un_region_new[which(df$un_intermediate._region_name == "Middle Africa")] <- "Africa"
df$un_region_new[which(df$un_intermediate._region_name == "Northern Africa")] <- "Africa"
df$un_region_new[which(df$un_intermediate._region_name == "Southern Africa")] <- "Africa"
df$un_region_new[which(df$un_intermediate._region_name == "Sub-Saharan Africa")] <- "Africa"
df$un_region_new[which(df$un_intermediate._region_name == "Western Africa")] <- "Africa"

# europe
df$un_region_new[which(df$un_intermediate._region_name == "Northern Europe")] <- "Western\nEurope"
df$un_region_new[which(df$un_intermediate._region_name == "Eastern Europe")] <- "Eastern\nEurope"
df$un_region_new[which(df$un_intermediate._region_name == "Western Europe")] <- "Western\nEurope"
df$un_region_new[which(df$un_intermediate._region_name == "Southern Europe")] <- "Southern\nEurope"

# america 
df$un_region_new[which(df$un_intermediate._region_name == "Caribbean")] <- "Caribean"
df$un_region_new[which(df$un_intermediate._region_name == "Central America")] <- "Central\nAmerica"
df$un_region_new[which(df$un_intermediate._region_name == "Northern America")] <- "Northern\nAmerica"
df$un_region_new[which(df$un_intermediate._region_name == "South America")] <- "South\nAmerica"

gr_3 <- aggregate(cbind(idea_pct,CoC) ~ year + un_region_new, data = df, FUN = function(x) mn = mean(x))

temp1 <- subset(gr_3, year=="2015")
temp2 <- subset(gr_3, year=="1996")
temp3 <- merge(temp1, temp2, by = "un_region_new")
temp3$idea_pct_diff <- temp3$idea_pct.x - temp3$idea_pct.y
temp3$coc_diff <- temp3$CoC.x - temp3$CoC.y
temp4 <- c("un_region_new", "idea_pct_diff", "coc_diff")
temp5 <- temp3[temp4]
names(temp5) <- c("region", "idea", "coc")

# order barplot by coc.
temp6 <- temp5[order(temp5$coc),]
temp7 <- gather(temp5, "variable", "value", 2:3)

#################  

# Plot
#################  

p3 <- ggplot(temp7,aes(region,value,fill=variable)) +
  geom_bar(stat="identity",position="dodge") + theme_bw(9)



p3 <- p3 + 
  labs(title = "PFR Index & World Bank Control of Corruption (CoC) \nchange in 1996-2015 period", 
       x = "Region", y = "PFR Index & CoC change") +
  scale_fill_manual(name = "", labels=c("World Bank Control of Corruption", "PFR Index"), 
                    values = c("red","black")) +
  theme(legend.position="bottom", legend.background = element_rect(colour = "black")) +
  theme(panel.border=element_rect(fill=NA)) + 
  theme(plot.background = element_rect(colour = "black", size = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(strip.background=element_rect(fill="white")) + 
  theme(plot.title = element_text(size = 10, face = "bold"), 
        legend.title=element_text(size=8) , legend.text=element_text(size=6), 
        legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
        plot.margin=unit(c(5,10,5,10),"mm"))
p3
#################

# Latin America
#################

# data
#################
df <- read.csv("AnalisisRCompleta.csv")
gr_3la <- df[df$iso3c %in% c("ARG", "BOL", "BRA", "CHL", "COL", "DOM", "ECU", "GTM", "HND", "MEX", 
                         "NIC", "PAN", "PER", "PRY", "SLV", "URY", "VEN"),]
names(gr_3la)[39] <- "Region"
gr_3la <- gr_3la[, c("iso3c", "year", "Region", "idea_pct", "CoC")]


temp1 <- subset(gr_3la, year=="2015")
temp2 <- subset(gr_3la, year=="2006")
temp3 <- merge(temp1, temp2, by = c("iso3c"))

temp3$idea_pct_diff <- temp3$idea_pct.x - temp3$idea_pct.y
temp3$coc_diff <- temp3$CoC.x - temp3$CoC.y
temp4 <- gather(temp3, "index_name", "index", 10:11)
#################


# plot
#################
p3la <- ggplot(temp4,aes(iso3c,index,fill=index_name)) +
  geom_bar(stat="identity",position="dodge") + theme_bw(9)
p3la



p3la <- p3la + 
  labs(title = "PFR Index & World Bank Control of Corruption (CoC) \nchange in 2006-2015 period", 
       x = "Region", y = "PFR Index & CoC change") +
  scale_fill_manual(name = "", labels=c("World Bank Control of Corruption", "PFR Index"), 
                    values = c("red","black")) +
  theme(legend.position="bottom", legend.background = element_rect(colour = "black")) +
  theme(panel.border=element_rect(fill=NA)) + 
  theme(plot.background = element_rect(colour = "black", size = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(strip.background=element_rect(fill="white")) + 
  theme(plot.title = element_text(size = 10, face = "bold"), 
        legend.title=element_text(size=8) , legend.text=element_text(size=6), 
        legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
        plot.margin=unit(c(5,10,5,10),"mm"))
p3la
#################

############################################################################


############################################################################
# --> (4) gr??fico de barras, evoluci??n PFR Index 96-15, dividido por pa??ses 
# con la media de LA. (Gr??fico 5 Gtvo.) --> South America...
#########################################################################
df <- read.csv("AnalisisRCompleta.csv")
df <- df[df$iso3c %in% c("ARG", "BOL", "BRA", "CHL", "COL", "DOM", "ECU", "GTM", "HND", "MEX", 
                         "NIC", "PAN", "PER", "PRY", "SLV", "URY", "VEN"),]
df <- subset(df, year == 2015 | year == 2006)
df$Year <- "NULL"
df$Year[which(df$year == 2006)] <- "2006"
df$Year[which(df$year == 2015)] <- "2015"




p4a <- ggplot(df,aes(iso3c,idea_pct)) +
  geom_bar(stat="identity",position="dodge", aes(fill = Year)) +
  theme_bw(9)
  


p4a <- p4a + 
  labs(title = "PFR Index level in 1996-2015: South America", x = "Country", 
       y = "PFR Index") + 
  scale_fill_manual(name = "", labels=c("2006", "2015"), 
                    values = c("red","black")) +
  theme(legend.position="bottom", legend.background = element_rect(colour = "black")) +
  theme(panel.border=element_rect(fill=NA)) + 
  theme(plot.background = element_rect(colour = "black", size = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(strip.background=element_rect(fill="white")) + 
  theme(plot.title = element_text(size = 10, face = "bold"), 
        legend.title=element_text(size=8) , legend.text=element_text(size=6), 
        legend.key.width = unit(0.3, "cm"), legend.key.height = unit(0.3, "cm"),
        plot.margin=unit(c(5,10,5,10),"mm"))
p4a


############################################################################









############################################################################
# 
# pushViewport(viewport(layout = grid.layout(1, 2)))
# print(p4a, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
# print(p4b, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
# 
############################################################################






# --> (5) Gr??fico de l??neas para todo LA, en la que se vea como evolucion?? cada 
# categor??a del ??ndice 96-15.
############################################################################



############################################################################











# --> () Modelo de regresion latin america.
############################################################################
df <- read.xlsx("AnalisisAL.xlsx", 1)
df <- subset(df, !df$un_intermediate._region_me == "Caribbean")
df$cepalgastoslevel <- ((df$CepalGastos*df$GDP)/100/1000000)

m1 <- lm(CoC ~ cepalgastoslevel + idea_pct*wefji + cepalgastoslevel:wefji, data=df)
summary(m1)

m2 <- plm(CoC ~ cepalgastoslevel + idea_pct*wefji + cepalgastoslevel:wefji, data=df, index= c('ID', 'year'), model = "within")
summary(m2)

m3 <- plm(CoC ~ cepalgastoslevel + idea_pct*wefji + cepalgastoslevel:wefji, data=df, index= c('ID', 'year'), model = 'random')
summary(m3)

phtest(m2, m3)  

# tabla interpretacion de modelo.



















############################################################################


x <- read.table(text = "  id1 id2 val1 val2
1   a   x    1    9
                2   a   x    2    4
                3   a   y    3    5
                4   a   y    4    9
                5   b   x    1    7
                6   b   y    4    4
                7   b   x    3    9
                8   b   y    2    8", header = TRUE)

# calculate mean
aggregate(. ~ id1 + id2, data = x, FUN = mean)

# count rows
aggregate(. ~ id1 + id2, data = x, FUN = length)
aggregate(cbind(val1, val2) ~ id1 + id2, data = x, FUN = function(x) c(mn = mean(x), n = length(x)))




############################################################################
data("mtcars")
mtcars2 <- data.frame(mtcars)

data("diamonds")
b <- data.frame(diamonds)


dat1 <- data.frame(
  sex = factor(c("Female","Female","Male","Male")),
  time = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")),
  total_bill = c(13.53, 16.81, 16.24, 17.42)
)

# Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity", position=position_dodge())

ggplot(data=gr_2_bar, aes(x=un_region_name, y=cbind(blpi_pct, os_pct)) +
  geom_bar(stat="identity", position=position_dodge())

  
  
  
  
  
  
  ## Re-level the cars by mpg
  mtcars3$car <-factor(mtcars2$car, levels=mtcars2[order(mtcars$mpg), "car"])
  
  x <-ggplot(mtcars3, aes(y=car, x=mpg)) + 
    geom_point(stat="identity")
  
  y <-ggplot(mtcars3, aes(x=car, y=mpg)) + 
    geom_bar(stat="identity") + 
    coord_flip()
  
  grid.arrange(x, y, ncol=2)
  
  
  