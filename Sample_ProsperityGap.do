********************************************************************************
/*
*** Sample do file to estimate the properity gap ***
*/
********************************************************************************

global ps = 25				// global prosperity standard
global bc = 0.25			// bottom code (winsorizing value) for global reporting


use "Sample_data.dta", clear

drop if welfare<0																// for global reporting we do not include observations with negative income

gen 	welfare_new = welfare 													// generage new welfare vector with bottom code
replace welfare_new = $bc if welfare<$bc

**********************
*** PROSPERITY GAP ***
**********************

gen pg = $ps / welfare_new														// estimate individual prosperity gap ratios from $25 prosperity threshold 

bys year: sum pg [w = weight]													// country prosperity gap by year 

/* Stata OUTPUT:

-> year = 2012
(analytic weights assumed)

    Variable |     Obs      Weight        Mean   Std. dev.       Min        Max
-------------+-----------------------------------------------------------------
          pg |   7,940  23831218.1    9.447423   8.537426   .1388789        100


*/



collapse pg [w=weight], by(code year)											// keep only the prosperity gap ratios
list

/* Stata OUTPUT:
			
     +------------------------+
     | code   year         pg |
     |------------------------|
  1. |  NNN   2012   9.447423 |
     +------------------------+
				
*/

********************************************************************************
exit