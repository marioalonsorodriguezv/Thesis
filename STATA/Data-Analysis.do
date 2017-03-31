clear all
set more off
cls
cap log close

* ***************************************************************
* Stats2
* Data Analysis
* Spring 2016
* Jan Minx
* Author: Andrés Londoño Botero
* ***************************************************************

cd "C:\Users\User\Documents\universidad\MPP\Seccond Semester\Stats II\Data Analysis"

use dap_v12
xtset NR YEAR

***Description of data set and methodology***
*********************************************
xtsum //Years of school is time constant

qui do "Year tables" //this is a do file used to export to excel the information
*needed for the firts table of the analysis.

**Gaph variable to see who earn more**

histogram WAGE, normal kdensity // right skew, log transformation
histogram EXPER, normal kdensity

*mean income graphs

gen lwage=ln(WAGE) // wages should be seen in changes
gen dlwage= d.lwage //percentage change of wage

//Per job
gen job=0
replace job=1 if OCC1==1
replace job=2 if OCC2==1
replace job=3 if OCC3==1
replace job=4 if OCC4==1
replace job=5 if OCC5==1
replace job=6 if OCC6==1
replace job=7 if OCC7==1
replace job=8 if OCC8==1
replace job=9 if OCC9==1

meansdplot lwage job, xlabel(1 "Professional" 2 "Manager" 3 "Sales" 4 ///
	"Clerical" 5 "Craftmen" 6 "Operatives" 7 "Laborers-farmes" 8 "Farm-foreman" ///
	9 "Service", angle(vertical)) outer(2) graphregion(fcolor(white)) ///
	title("Graph 1: mean and std.dev of log real hourly income (US$)" "by occupation") ///
	ytitle(Log of real hourly income) xtitle("") name(g1, replace)
graph export mean_job.png, replace 

//per sector

gen sector=0
replace sector=1 if AG==1
replace sector=2 if MIN==1
replace sector=3 if CON==1
replace sector=4 if TRAD==1
replace sector=5 if TRA==1
replace sector=6 if FIN==1
replace sector=7 if BUS==1
replace sector=8 if PER==1
replace sector=9 if ENT==1
replace sector=10 if MAN==1
replace sector=11 if PRO==1
replace sector=12 if PUB==1

meansdplot lwage sector, xlabel(1 "Agricultural" 2 "Mining" 3 "Construction" 4 ///
	"Trade" 5 "Transport" 6 "Finance" 7 "Bussin. Repair" 8 "Pers. serv." ///
	9 "Entretainmenr" 10 "Manifacturing" 11 "Prof. serv." 12 "Public", ///
	angle(vertical)) outer(2) graphregion(fcolor(white)) ///
	title("Graph 2: mean and std.dev of log real hourly income (US$)" "by industry") ///
	ytitle(Log of real hourly income) xtitle("") name(g2, replace)
graph export mean_sector.png, replace 


graph combine g1 g2, title("Graph 1: mean and std.dev of log real hourly income") ///
	graphregion(fcolor(white))
graph export combine_scatter_line.png, replace 

/* according to this graph, there are more non union workers with high
hourly wages*/

scatter UNION lwage, ytitle("if wage was set for collective bargaining =1") ///
	xtitle("log Real hourly wage in US $") graphregion(fcolor(white)) name(g3, replace)
graph export scatter_wage_union.png, replace 

*Generate average income for union and not union

egen mean_union = mean(lwage) if UNION==1, by(YEAR)
egen mean_nounion = mean(lwage) if UNION==0, by(YEAR)
egen mean_school = mean(SCHOOL), by(YEAR)

sum mean_school //mean does not change un time
tsline mean_school

/* The average income in time suggets that on average, income is higher for
worker in unions */

twoway (tsline mean_union, sort) (tsline mean_nounion, sort), ///
	graphregion(fcolor(white)) legend(col(1)) legend( label(1 "log Average wage unions") ///
	label(2 "log Average wage no unions")) ytitle("log Average hourly wage in US$") ///
	xtitle("") scheme(sj)  xlabel(1980(1)1987) tline(1985, lcolor(blue)) name(g4, replace)
graph export wage_mean.png, replace 

*get both graph together

graph combine g3 g4, title("Graph 3: Union wage premium") graphregion(fcolor(white))
graph export combine_scatter_line.png, replace 

*change in Union afiliation
egen union_af = count(UNION) if UNION==1, by(YEAR) // number of union workers
egen union_dwage= mean(dlwage) if UNION==1, by(YEAR) //averaga wage change union
egen nounion_dwage= mean(dlwage) if UNION==0, by(YEAR) //averaga wage change nounion

sum union_af
display r(mean)/545 //25% were members of a union

twoway (tsline union_af, sort yaxis(1) ytitle("Number of unionized workers", axis(1))) ///
	(tsline union_dwage nounion_dwage, sort yaxis(2) ytitle("Real hourly wage change", /// 
	axis(2))), graphregion(fcolor(white)) xtitle("") xlabel(1980(1)1987) scheme(sj) ///
	title("Graph 4: Number of unionized workers and income change") ///
	legend(size(medsmall)) legend( label(1 "N. of union workers") label(2 ///
	"Income change union workers") label(3 "Income change non union workers")) ///
	legend(col(1)) tline(1985, lcolor(blue))
graph export union_af.png, replace 


*Experience can have a non linear relationship

aaplot WAGE EXPER //ideed it has an inverted u shape relation
gen exper2= EXPER^2

*Same for schooling
aaplot WAGE SCHOOL //ideed it has an inverted u shape relation
gen school2= SCHOOL^2

***Diagnosis***
***************

*Outliar
reg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ENT MAN PRO	
predict r, rstudent
stem r
list NR WAGE UNION EXPER if abs(r)>2 //there are many outlias, especially non
// union workers

reg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ENT MAN PRO
dfbeta
scatter _dfbeta_1 _dfbeta_9-_dfbeta_15, yline(.03 -.03) mlabel(NR NR NR NR NR NR NR)

predict lev, leverage
stem lev
list NR lwage UNION EXPER if lev> ((2*14+2)/4360)
lvr2plot, mlabel(NR)

predict d, cooksd
graph twoway (scatter r lev [w=d],msymbol(Oh))

/* Breusch and Pagan LM test for individual efects*/
quie xtreg lwage i.UNION##i.YEAR EXPER exper2 AG MIN CON TRAD TRA FIN BUS PER ENT ///
	MAN PRO, re 
log using individ_eff, text replace
*@s
xttest0
*@e
logs2rtf
cap log close

/*Hasuman test for re vs fe */

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ENT ///
	MAN PRO, re 
estimates store RE

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ENT ///
	MAN PRO, fe 
estimates store FE
	
log using hausman_re_fe, text replace
*@s
hausman FE RE //we prefere FE
*@e
logs2rtf
cap log close

**Testing the model**
*********************

qui xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ENT ///
	MAN PRO, fe 
xttest3 // there is Presence of heteroskedasticity rejet null constant variance
xtserial UNION YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO //autocorr rejet no serial corr

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO, fe
testparm i.YEAR //not jointly significant

label var lwage "Ln(wage)"
label var YEAR "Year"
label var UNION "Union"
label var EXPER "Experience(years)"
label var AG "Agricultural"
label var MIN "Mining"
label var CON "Constroction"
label var TRAD "Trade"
label var TRA "Transportation"
label var FIN "Finances"
label var BUS "Business & Repair"
label var PER "Personal Services"
label var ENT "Entertainment"
label var MAN "Manufacturing"
label var PRO "Prof. Services"
label var PUB "Public admin."
label var MAR "Married"

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO, re vce(cluster NR)
estimates store RE
outreg2 using regression.doc, replace ctitle(RE All) ///
	addtext(Hasuman test, 89.97) drop(i.YEAR) label
	
xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO, fe vce(cluster NR)
estimates store FE
outreg2 using regression.doc, append ctitle(FE ALL)addtext(Year FE, ///
	YES) drop(i.YEAR) label

test AG MIN CON TRAD TRA FIN BUS PER ENT MAN PRO //jointly signifficant

*Margins
	
label define UNION1 0 "No-unionized" 1 "Unionized"
label values UNION UNION1

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO exper2, fe vce(cluster NR)
margins, over(UNION YEAR) //difference of union and no-union
marginsplot, x(YEAR) recast(line) recastci(rarea) graphregion(fcolor(white)) ///
	title("Graph 5: Union Predictive margins with 95%Cls") ///
	xtitle("") yline(0, lcolor(blue)) name(g5, replace) scheme(s2color)
graph export marginspl.png, replace

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO, fe vce(cluster NR) 
margins, dydx(UNION) over(YEAR) at(UNION) vsquish saving(file1, replace)
	*Marginal effect of union coefficient in time
marginsplot, x(YEAR) recast(line) recastci(rarea) graphregion(fcolor(white)) ///
	title("Graph 6: AV. marginal effect of Unions over income in time. 95%Cls") ///
	xtitle("") yline(0, lcolor(blue)) name(g6, replace) saving(gr1, replace)
graph export marginspl1.png, replace

graph combine g5 g6, title("Graph 5: marginal effect of Unions over hourly income in time") ///
graphregion(fcolor(white))
graph export margins_combine.png, replace 

**BLACK**

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(BLACK==1), re vce(cluster NR)
xttest0 //reject no individual effects
outreg2 using regression.doc, append ctitle(RE Black) ///
	addtext(Hasuman test, 365.25) drop(i.YEAR) label
	
xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(BLACK==1), fe vce(cluster NR)
outreg2 using regression.doc, append ctitle(FE Black) ///
	addtext(Year FE, YES) drop(i.YEAR) label

*TEST
qui xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(BLACK==1), re
est sto RE_B

qui xtreg lwage i.YEAR##i.UNION MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(BLACK==1), re
est sto FE_B

hausman FE_B RE_B //FE is prefered

*Margins

margins, dydx(UNION) over(YEAR) at(UNION) vsquish saving(file2, replace)
marginsplot, x(YEAR) recast(line) recastci(rarea) graphregion(fcolor(white)) ///
	title("Graph 6: AV. marginal effect of Unions if Black. 95%Cls") ///
	xtitle("") yline(0, lcolor(blue)) name(g7, replace)
	
xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(BLACK==1), fe vce(cluster NR)
margins, over(UNION YEAR)
marginsplot, x(YEAR) recast(line) recastci(rarea) graphregion(fcolor(white)) ///
	title("Graph 6: Union Predictive margins if Black with 95%Cls") ///
	xtitle("") yline(0, lcolor(blue)) name(g8, replace) scheme(s2color)
graph export marginspl_BL.png, replace

**SPANIC**

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(HISP==1), re vce(cluster NR)
xttest0 //rejet no individual effects
outreg2 using regression.doc, append ctitle(RE Spanic) ///
	addtext(Hasuman test, 328.90) drop(i.YEAR) label

xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(HISP==1), fe vce(cluster NR)
outreg2 using regression.doc, append ctitle(FE Spanic) ///
	addtext(Year FE, YES) drop(i.YEAR) label

*TEST

qui xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(HISP==1), re
est sto RE_S
	
qui xtreg lwage i.UNION##i.YEAR MAR AG MIN CON TRAD TRA FIN BUS PER ///
	ENT MAN PRO if(HISP==1), fe
est sto FE_S

hausman FE_S RE_S //prefere random

margins, dydx(UNION) over(YEAR) at(UNION) vsquish saving(file3, replace)
marginsplot, x(YEAR) recast(line) recastci(rarea) graphregion(fcolor(white)) ///
	title("Graph 8: AV. marginal effect of Unions if Spanic. 95%Cls") ///
	xtitle("") yline(0, lcolor(blue)) name(g9, replace)
	
combomarginsplot file1 file2 file3, x(YEAR) recast(line) noci scheme(s2color) ///
	graphregion(fcolor(white)) xtitle("") yline(0, lcolor(blue)) ///
	title("Graph 7: AV. marginal effect of Unions over income in time") ///
	label("All" "Black" "Spanic")
graph export marginspl_all.png, replace
