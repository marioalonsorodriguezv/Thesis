

clear
cls
set more off

// cd "P:\152856\[01] Tesis Party Finance\IDEAS"
// cd "/Users/alvarolopezguiresse/GoogleDrive/[] ADMINISTRACION PUBLICA/THESIS/IDEA/basenueva"

cd "/Users/alvarolopezguiresse/GoogleDrive/[] ADMINISTRACION PUBLICA/tesis/Thesis/STATA"

//import excel graficas_y_analisis_v2.xlsx, sheet("importar_software") firstrow
import excel AnalisisRCompletaWEF, sheet("AnalisisRCompletaWEF.csv") firstrow



******************
*** las variables en string son convertidas a categorias numericas
******************
encode iso3c, generate(iso3c_code)
drop iso3c
rename iso3c_code iso3c



//codigos de regiones del WB.
encode wb_region, generate(region_code)
drop wb_region
rename region_code wb_region

//codigos de income del WB
encode wb_income, generate(wb_income_code)
drop wb_income
rename wb_income_code wb_income

//Ticker
encode Ticker, generate(Ticker_code)
drop Ticker
rename Ticker_code Ticker


//UN region name
encode un_region_name, generate(un_region_name_code)
drop un_region_name
rename un_region_name_code un_region_name

//UN sub region name
encode un_sub_region_name, generate(un_sub_region_name_code)
drop un_sub_region_name
rename un_sub_region_name_code un_sub_region_name

//UN intermediate region name
encode un_intermediate_region_name, generate(un_intermediate_region_name_code)
drop un_intermediate_region_name
rename un_intermediate_region_name_code un_intermediate_region_name

//UN developed-developing region name
encode un_dev_devping, generate(un_dev_devping_code)
drop un_dev_devping
rename un_dev_devping_code un_dev_devping

// anos que no son corridos en el cocwb
drop if Year==1996
drop if Year==1997
drop if Year==1998
drop if Year==1999
drop if Year==2001
/*
drop if Year==2002
drop if Year==2003
drop if Year==2005
drop if Year==2006
drop if Year==2007
drop if Year==2009
drop if Year==2010
drop if Year==2011
drop if Year==2013
drop if Year==2014
*/

drop if Ticker==33


drop if un_intermediate_region==2
drop if un_intermediate_region==8
drop if un_intermediate_region==13
drop if un_region==5




//el setting de panel es activado i-country code j-1996:2015.
xtset iso3c year



//OLS

xtreg CoC CepalGastos c.wefji##c.idea_pct, re
margins, at(idea_pct=(0 (0.1) 1) wefji=(1.5, 5.5))
marginsplot


xtreg CoC i.un_intermediate_region##c.idea_pct, re
margins idea_pct, over(un_intermediate_region) 
marginsplot




/*******************************************************************************
******* reshape database world governance indicators CoC World Bank ************
*******************************************************************************/

clear
cls
set more off
*cd "P:\152856\tesis"
cd "/Users/alvarolopezguiresse/GoogleDrive/[] ADMINISTRACION PUBLICA/THESIS/IDEA/basenueva"


import excel Libro3.xlsx, sheet("Hoja1") firstrow

encode code, generate(country_code)

reshape long y, i(country_code) j(year)

sort Country

drop country_code
sort  wbcode year

save cocWB.dta, replace

clear


