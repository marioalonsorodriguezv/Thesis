clear all
set more off
cls
*****DISSERTATION*****
**********************
*Overall balance
*All Datasets
*Consolidated Income statements

***********
***SIREM***
***********

cd "C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Consolidated"

append using "C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2011\Estados Financiero 2011 SIREM.dta" ///
	"C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2012\Estados Financiero 2012 SIREM.dta" ///
	"C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2013\Estados Financiero 2013 SIREM.dta" ///
	"C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2014\Estados Financiero 2014 SIREM.dta" ///
	"C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2015\Estados Financiero 2015 SIREM.dta"
	
sort nit year
save "Estados Financieros SIREM", replace

**********************
***Super Financiera***
**********************
clear all

cd "C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Consolidated"

append using "C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2011\Superfinanciera\Estados Financiero 2011.dta" ///
	"C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2012\Superfinanciera\Estados Financiero 2012.dta" ///
	"C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2013\Superfinanciera\Estados Financiero 2013.dta" ///
	"C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2014\Superfinanciera\Estados Financiero 2014.dta" ///
	"C:\Users\User\Documents\universidad\MPP\tesis\3. STATISTICAL ANALYSIS\1. DATA\CORPORATE FINANCIAL INFO\Estados 2015\Superfinanciera\Estados Financiero 2015.dta", force
sort nit year
save "Estados Financieros Superfin", replace

***********
****ALL****
***********

append using "Estados Financieros SIREM.dta", force
sort nit year
drop if missing(nit)
save "Financial Information", replace
