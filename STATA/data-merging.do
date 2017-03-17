clear
***total pop***

cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-stata.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop="" if pop==":"
destring pop, replace

drop if tin(2015, 2016)

sort ID year

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

save poptot.dta, replace

clear

***0 to 4***
************

import excel pop-0-4.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop04="" if pop04==":"
destring pop, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608
drop if tin(2015, 2016)

sort ID year

merge 1:1 ID year CITIESTIME using poptot.dta
drop _merge

save final.dta, replace

clear

**5-9**
cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"
import excel pop-5-9.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop59="" if pop59==":"
destring pop, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**10-14**

cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"
import excel pop-10-14.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop1014="" if pop1014==":"
destring pop1014, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**15-19**

cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-15-19.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop1519="" if pop1519==":"
destring pop1519, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**20-24**

cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-20-24.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop2024="" if pop2024==":"
destring pop2024, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**pop-25-34**

cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-25-34.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop2534="" if pop2534==":"
destring pop2534, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**pop-35-44**

cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-35-44.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop3544="" if pop3544==":"
destring pop3544, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**pop-45-54**
cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-45-54.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop4554="" if pop4554==":"
destring pop4554, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**pop-55-64**

cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-55-64.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop5564="" if pop5564==":"
destring pop5564, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**pop-65-74**
cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-65-74.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop6574="" if pop6574==":"
destring pop6574, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**pop-75**
cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel pop-75.xls, sheet("Sheet1") firstrow
xtset ID year

replace pop75="" if pop75==":"
destring pop75, replace

keep if ID== 534 | ID== 706 | ID== 519 | ID== 57 |ID== 317 |ID== 780 |ID== 608

drop if tin(2015, 2016)
sort ID year

merge 1:1 ID year CITIESTIME using final.dta
drop _merge

save "final.dta", replace

clear

**nationas as % of the population**
cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel natpercent.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace natpercent="" if natpercent==":"
destring natpercent, replace

keep if ID== 91 | ID== 138 | ID== 139 | ID== 466 |ID== 653 |ID== 208 |ID== 937
recode ID (91=57 ) (138=706 ) (139=534 ) (466=519 ) (653=317 ) (208= 780) (937=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace

clear

**foreigns as % of the population**
cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel forpercent.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace forpercent="" if forpercent==":"
destring forpercent, replace

keep if ID== 91 | ID== 138 | ID== 139 | ID== 466 |ID== 653 |ID== 208 |ID== 937
recode ID (91=57 ) (138=706 ) (139=534 ) (466=519 ) (653=317 ) (208= 780) (937=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace
clear

**EU foreigns as % of the population**
cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel europerc.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace europerc="" if europerc==":"
destring europerc, replace

keep if ID== 91 | ID== 138 | ID== 139 | ID== 466 |ID== 653 |ID== 208 |ID== 937
recode ID (91=57 ) (138=706 ) (139=534 ) (466=519 ) (653=317 ) (208= 780) (937=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace

clear

**non-EU foreigns as % of the population**
cd "C:\Users\User\Documents\Investigaciones\ciudades\Datos\educación\Cities"

import excel noneuperc.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace noneuperc="" if noneuperc==":"
destring noneuperc, replace

keep if ID== 91 | ID== 138 | ID== 139 | ID== 466 |ID== 653 |ID== 208 |ID== 937
recode ID (91=57 ) (138=706 ) (139=534 ) (466=519 ) (653=317 ) (208= 780) (937=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace

clear

**Persons (aged 25-64) with ISCED level 0, 1or 2 as the highest level of education**

import excel educisced0to2level.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace educisced0to2level="" if educisced0to2level==":"
destring educisced0to2level, replace

keep if ID== 88 | ID== 136 | ID== 137 | ID== 465 |ID== 642 |ID== 208 |ID== 927
recode ID (88=57 ) (136=706 ) (137=534 ) (465=519 ) (642=317 ) (208= 780) (927=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace

clear

**Persons (aged 25-64) with ISCED level 3 or 4 as the highest level of education**

import excel educisced3to4level.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace educisced3to4level="" if educisced3to4level==":"
destring educisced3to4level, replace

keep if ID== 88 | ID== 136 | ID== 137 | ID== 465 |ID== 642 |ID== 208 |ID== 927
recode ID (88=57 ) (136=706 ) (137=534 ) (465=519 ) (642=317 ) (208= 780) (927=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace

clear

**Persons (aged 25-64) with ISCED level 5 or 6 as the highest level of education**

import excel educisced5to6level.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace educisced5to6level="" if educisced5to6level==":"
destring educisced5to6level, replace

keep if ID== 88 | ID== 136 | ID== 137 | ID== 465 |ID== 642 |ID== 208 |ID== 927
recode ID (88=57 ) (136=706 ) (137=534 ) (465=519 ) (642=317 ) (208= 780) (927=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace

clear

**Proportion of working age population qualified at level 3 or 4 ISCED**

import excel edworkprop3to4level.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace edworkprop3to4level="" if edworkprop3to4level==":"
destring edworkprop3to4level, replace

keep if ID== 88 | ID== 136 | ID== 137 | ID== 465 |ID== 642 |ID== 208 |ID== 927
recode ID (88=57 ) (136=706 ) (137=534 ) (465=519 ) (642=317 ) (208= 780) (927=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace

clear

**Proportion of working age population qualified at level 3 or 4 ISCED**

import excel edworkprop5to6level.xls, sheet("Sheet1") firstrow
sort CITIESTIME

en CITIESTIME, gen(ID)

replace edworkprop5to6level="" if edworkprop5to6level==":"
destring edworkprop5to6level, replace

keep if ID== 88 | ID== 136 | ID== 137 | ID== 465 |ID== 642 |ID== 208 |ID== 927
recode ID (88=57 ) (136=706 ) (137=534 ) (465=519 ) (642=317 ) (208= 780) (927=608)
drop CITIESTIME
label drop ID

merge 1:1 ID year using final.dta
drop _merge

save "final.dta", replace

clear
