*** Replication code for Marshall, "Education and voting Conservative: Evidence from a major schooling reform in Great Britain"

*** Molly's Version for Gov1006!
* Only the code I actually ran or attempted the run is included
* all orignal code (including for appendix figues I didn't replicate) can be found in the repo for this project



****************************** PRELIMINARIES


*** Set the relevant working directory - Changed to Molly files
cd "/Users/mollychiang/Desktop/Harvard/Sophomore Year/Semester 2/Gov1006/Marshall_Replication"



*** Log analysis
log using "Replication Results.smcl", replace



*** Load the dataset used throughout the analysis; the creation of the dataset (principally from the British Election Survey) is described in the Online Appendix
use "UK Election Data Replication.dta", clear



*** Restrict to the sample used for the Conservative vote models (return to the broader sample containing turnout too below)
keep if vote_choice_sample==1





****************************** GRAPHICAL ANALYSIS

* a new variable caleld weight_14 will be generated for each value of yearat14 and will be equal
* to the total number of inputs for each of the yearat14 values

bysort yearat14 : g weight_14 = _N

* a new variable called meancon14 will be generated for each set of data points 
* with one value of yearat14 - and it will be the mean of the of the conservative votes
* aka-all of the data points with the same yearat14 value will have the same meancon14 value
* and that value will be the average of the con (whether they voted conservative or not) column
* for that set of points with the same yearat14 value

bysort yearat14 : egen meancon14 = mean(con)

* just like with meancon14, a new variable called meanconpart14 will be created for each
* set of yearat14 values. This new variable will be the mean of the conpart column,
* which contains a 1 or 0 value indicating if the individual is conservative partisan or not

bysort yearat14 : egen meanconpart14 = mean(conpart)

* another variable created for each set of values with the same yearat14
* this time named meanleave14 and is the average age at which the individuals left school
* for each set of values with the same yearat14

bysort yearat14 : egen meanleave14 = mean(leave)

* same thing again, this time mean of taxspendself, which is a tax spend scale

bysort yearat14 : egen meantaxspendself14 = mean(taxspendself)

* same process of variable creation, this time for mean of welfaretoofar which is
* a 0 or1 variable indicating if the individual took welfare too far or not

bysort yearat14 : egen meanwelfaretoofar14 = mean(welfaretoofar)

* again same process, this time mean of redist, which is a redistributed scale of
* income and wealth from 0 to 4

bysort yearat14 : egen meanredist14 = mean(redist)

* generate a number of columns for students who left at different grades (level 8, 9, 10
* 11, 12) - which will have a 1 if the student was under age 9, 10, 11, 12, 13 years
* respectively and 0 if they did not (and only if there is a leave age value)
* then create another column for each of these new columns called meanleave_## which
* is the mean of the leave_l# column for each value of yearat14
* this will give us an idea of the number of kids who left at each level of school
* for each cohort of people who were all 14 at the same time 

g leave_l8 = leave<9 if leave!=.
by yearat14, sort : egen meanleave_l8 = mean(leave_l8)
g leave_l9 = leave<10 if leave!=.
by yearat14, sort : egen meanleave_l9 = mean(leave_l9)
g leave_l10 = leave<11 if leave!=.
by yearat14, sort : egen meanleave_l10 = mean(leave_l10)
g leave_l11 = leave<12 if leave!=.
by yearat14, sort : egen meanleave_l11 = mean(leave_l11)
g leave_l12 = leave<13 if leave!=.
by yearat14, sort : egen meanleave_l12 = mean(leave_l12)

*** Figure 1: Trends in school leaving age

* start with twoway function which is stata's way of indicating a graph will come next
* many different things will be plotted on the same axis each with individual identifier variables
* to combine all this stuff include each thing in its own set of parenthesis 

* first use lpoly to create a local polynomial smooth plot with leave_18 on the y acis and yearat14
* on the x axis - however, subset to only include individuals who were 14 between 1925 and 1947
* add a specefic color, width of the line and degree of the line

twoway (lpoly leave_l8 yearat14 if yearat14<1947 & yearat14>=1925, lcolor(gs14) clwidth(thick) degree(4)) ///
 
 * repeat the same use of lpoly and axis, but this time for individuals who were 14 between 1947 and 1970
 * add the same specifications for color, width and degree
 
  (lpoly leave_l8 yearat14 if yearat14>=1947 & yearat14<=1970, lcolor(gs14) clwidth(thick) degree(4)) ///
  
  * now plot the same information from the first lpoly as a scatter plot
  * with its own weight, size, and color specifications
  
  (scatter meanleave_l8 yearat14 if yearat14>=1925 & yearat14<=1970 [weight=weight_14], msize(small) mcolor(gs14)) ///
  
  * the process of: creating 2 different lpoly plots for those who are 14 before and after 1947
  * to show the proportion of students leaving school after all the different grades in different years
  * and then adding a scatterplot of the same data afterwards
  * will be repeated for leaving level 9, 10, 11, and 12
  
  (lpoly leave_l9 yearat14 if yearat14<1947 & yearat14>=1925, lcolor(gs11) clwidth(thick) degree(4)) ///
  (lpoly leave_l9 yearat14 if yearat14>=1947 & yearat14<=1970, lcolor(gs11) clwidth(thick) degree(4)) ///
  (scatter meanleave_l9 yearat14 if yearat14>=1925 & yearat14<=1970 [weight=weight_14], msize(small) mcolor(gs11)) ///
  (lpoly leave_l10 yearat14 if yearat14<1947 & yearat14>=1925, lcolor(gs7) clwidth(thick) degree(4)) ///
  (lpoly leave_l10 yearat14 if yearat14>=1947 & yearat14<=1970, lcolor(gs7) clwidth(thick) degree(4)) ///
  (scatter meanleave_l10 yearat14 if yearat14>=1925 & yearat14<=1970 [weight=weight_14], msize(small) mcolor(gs7)) ///
  (lpoly leave_l11 yearat14 if yearat14<1947 & yearat14>=1925, lcolor(gs5) clwidth(thick) degree(4)) ///
  (lpoly leave_l11 yearat14 if yearat14>=1947 & yearat14<=1970, lcolor(gs5) clwidth(thick) degree(4)) ///
  (scatter meanleave_l11 yearat14 if yearat14>=1925 & yearat14<=1970 [weight=weight_14], msize(small) mcolor(gs5)) ///
  (lpoly leave_l12 yearat14 if yearat14<1947 & yearat14>=1925, lcolor(black) clwidth(thick) degree(4)) ///
  (lpoly leave_l12 yearat14 if yearat14>=1947 & yearat14<=1970, lcolor(black) clwidth(thick) degree(4)) ///
  (scatter meanleave_l12 yearat14 if yearat14>=1925 & yearat14<=1970 [weight=weight_14], msize(small) mcolor(black)), ///
  
  * add specifications for the graph - background colors, axis labels and titles
  * add a vertical black line to indicate when 1947 was
  * add a legend to give labels to the different times to leave school
  
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Proportion leaving) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) xlab(1925(5)1970) ///
  legend(nobox region(fcolor(white) margin(zero) lcolor(white)) lab(3 "Leave before 14") lab(6 "Leave before 15") lab(9 "Leave before 16") lab(12 "Leave before 17") lab(15 "Leave before 18") order(3 6 9 12 15) row(1)) 



*** Figure 3: Reduced form

* use twoway again to create a graphic - and use paranthesis to combine many different aspects
* on one set of axis

* once again, use two different lpolys - one for people 14 before 1947 and one for after
* once again add a scatter to this data (for whole time range)
* add specifications on color and size for all aspects, add axis labels and tables and 
* rescale the y axis

twoway (lpoly con yearat14 if yearat14>=1925 & yearat14<1947, lcolor(black) clwidth(thick) degree(4)) ///
  (lpoly con yearat14 if yearat14>=1947 & yearat14<=1970, lcolor(black) clwidth(thick) degree(4)) ///
  (scatter meancon14 yearat14 if yearat14>=1925 & yearat14<=1970 [weight=weight_14], msize(small) mcolor(gray)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Conservative vote share) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  yscale(range(.2 .5)) ylabel(.2[0.1]0.5) xlab(1925[5]1970) legend(off) 
    



	
	
******************************* CONTINUITY IN OTHER VARIABLES

*** Figure 2: Continuity graphs

* use capture to suppress the results of the following code and store it 
* unless the output is 0 (in which nothing will occur)
* in this case capture is used on another by ... sort: egen which creates a new column called 
* meanyear which is the mean year for each set of yearat14 values
* then a scatter plot is created with meanyear on y and yearat14 on x axisfor yearat14 between 1925
* and 1970 - add specifications. Add labels to the graph
* save the graph as a graph called g1.gph - replace any old copies of this file if there are any

capture by yearat14, sort : egen meanyear = mean(year)
twoway (scatter meanyear yearat14 if yearat14>=1925 & yearat14<=1970, mcolor(black) msize(medsmall)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Year) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  legend(off) title(Panel A: Survey year, color(black) size(medium)) xlab(1930[10]1970)
graph save Graph "g1.gph", replace

* once again use capture. this time make a new column for meanmale (by yearat14 values)
* create a scatterplot with meanmale on yand yearat14 on x axis (same year range and 
* specifications of points and graph)
* save graph and replace old files
* repeat this process for all of the variables we are testing the continuity of 

capture by yearat14, sort : egen meanmale = mean(male)
twoway (scatter meanmale yearat14 if yearat14>=1925 & yearat14<=1970, mcolor(black) msize(medsmall)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Proportion) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  legend(off) title(Panel B: Male, color(black) size(medium)) xlab(1930[10]1970)
graph save Graph "g2.gph", replace

capture by yearat14, sort : egen meanwhite = mean(white)
twoway (scatter meanwhite yearat14 if yearat14>=1925 & yearat14<=1970, mcolor(black) msize(medsmall)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Proportion) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  legend(off) title(Panel C: White, color(black) size(medium)) xlab(1930[10]1970)
graph save Graph "g3.gph", replace

capture by yearat14, sort : egen meanblack = mean(black)
twoway (scatter meanblack yearat14 if yearat14>=1925 & yearat14<=1970, mcolor(black) msize(medsmall)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Proportion) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  legend(off) title(Panel D: Black, color(black) size(medium)) xlab(1930[10]1970)
graph save Graph "g4.gph", replace

capture by yearat14, sort : egen meanasian = mean(asian)
twoway (scatter meanasian yearat14 if yearat14>=1925 & yearat14<=1970, mcolor(black) msize(medsmall)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Proportion) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  legend(off) title(Panel E: Asian, color(black) size(medium)) xlab(1930[10]1970)
graph save Graph "g5.gph", replace

capture by yearat14, sort : egen meanmanual = mean(fathermanual)
twoway (scatter meanmanual yearat14 if yearat14>=1925 & yearat14<=1970, mcolor(black) msize(medsmall)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Proportion) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  legend(off) title(Panel F: Father manual/unskilled job, color(black) size(medium)) xlab(1930[10]1970)
graph save Graph "g6.gph", replace

capture by yearat14, sort : egen meanurate = mean(urate)
twoway (scatter meanurate yearat14 if yearat14>=1925 & yearat14<=1970, mcolor(black) msize(medsmall)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Rate (%)) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  legend(off) title(Panel G: National unemployment rate, color(black) size(medium)) xlab(1930[10]1970)
graph save Graph "g7.gph", replace

twoway (scatter average_earnings yearat14 if yearat14>=1925 & yearat14<=1970, mcolor(black) msize(medsmall)), ///
  graphregion(fcolor(white) lcolor(white)) ylab(,nogrid) ytitle(Index (2000=100)) xtitle(Cohort: year aged 14) xline(1946.5, lcolor(black) lpattern(dash)) ///
  legend(off) title(Panel H: National average earnings, color(black) size(medium)) xlab(1930[10]1970)
graph save Graph "g8.gph", replace

 * use gr to combin the 3 graphs into one panel with 3 rows and three columns

gr combine "g1" "g2" "g3" "g4" "g5" "g6" "g7" "g8", rows(3) cols(3) subtitle(, color(black) fcolor(white) lcolor(white)) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))








****************************** LOCAL LINEAR REGRESSION ANALYSIS

******* MOLLY - set all h and bwselect(IK) to bwselect(mserd) to reflect new use of rdrobust 
		* IK and h are now deprecated
* this table shows estimates on the 1947's affect on different variables (measure effect of a program).
* rdrobust will be used again to compare local linear regressions on either side of
* a cutoff (1947)

* A number of variables are input as the dependent variable, while yearat14 is the
* independent for all of them, c indicates the RD cut off - which in this case is 
* the year 1947, p indicates the order of the local polynomial for the
* points (1 was chosen indicating local linear regression), q indicates
* the order of the local polynomial for bias correction (2 was chosen
* indicating local quadratic regression), the kernel function indicates
* the mathematical method used to construct the local polynomials, in this
* case they chose tri (which is the default method)
* h is the old bandwidth used to construct the RD point estimator (14.736 was
* used originally (from Imbens and Kalyanaraman (2012)) but as I said it was changed


*** Table 1: Main estimates

* first use rdrobust on leave (year left school) and yearat14
* this should show how much a trend in the variable changed after 1947 
* (and the associated measures of standard error)
* hen sum the leave variable if the individuals were 14 between 1933 and 1961

rdrobust leave yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
sum leave if yearat14>=1933 & yearat14<=1961

* repeat the same process for uni instead of leave - giving us
* how much more/less people started going to university before and after
* 1947 (uni is a 0 or 1 variable for if you went) and associated error terms
* again after running rdrobust, sum uni values if yearat14 is between 1933 and 1961

rdrobust uni yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
sum uni if yearat14>=1933 & yearat14<=1961

* now run rdrobust on our con variable (whether or not someone voted conservative) and yearat14
* use same cutoff and p, q, and kernel specifications
* bwselect was changed here from IK to mserd

rdrobust con yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)

* run rdrobust on con again, this time add a fuzzy variable - this specifies leave (leave when left 
* school) as the treatment status variable to implement a fuzzy regression discontinuity
* which is another type of regression discontinuity 

rdrobust con yearat14, c(1947) fuzzy(leave) p(1) q(2) kernel(tri) bwselect(mserd)
sum leave if yearat14>=1933 & yearat14<=1961

* use areg to fit linear regressions including all the indicated variables
* while absorbing the specified survey variable - which was the year the survey occured 

areg con leave male white black asian sagesq-sagequart syearat14 syearat14sq syearat14cub syearat14quart, ro a(survey)
areg con ib9.leave male white black asian sagesq-sagequart syearat14 syearat14sq syearat14cub syearat14quart, ro a(survey)
summ con if e(sample)

* run rdrobust 2 more times - first between lab (voting for the labour party) and
* yearat14 (same specifications and use fuzzy(leave) model) and then between lib  (voted for 
* libertarian party) and yearat14 (fuzzy(leave) model as well)
* in both cases, sum lib if yearat14 is between 1933 and 1961

rdrobust lab yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd) fuzzy(leave)
sum lib if yearat14>=1933 & yearat14<=1961
rdrobust lib yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd) fuzzy(leave)
sum lib if yearat14>=1933 & yearat14<=1961



** MOLLY ADDITION TO TRY TO PRINT TABLE (from Alice)
* this addition did not end up working.
cd "/Users/mollychiang/Desktop/Harvard/Sophomore Year/Semester 2/Gov1006/Marshall_Replication"
eststo clear
eststo: rdrobust leave yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
eststo: rdrobust uni yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
eststo: rdrobust con yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
eststo: rdrobust con yearat14, c(1947) fuzzy(leave) p(1) q(2) kernel(tri) bwselect(mserd)
eststo: areg con leave male white black asian sagesq-sagequart syearat14 syearat14sq syearat14cub syearat14quart, ro a(survey)
eststo: areg con ib9.leave male white black asian sagesq-sagequart syearat14 syearat14sq syearat14cub syearat14quart, ro a(survey)
eststo: areg con ib9.leave male white black asian sagesq-sagequart syearat14 syearat14sq syearat14cub syearat14quart, ro a(survey)
eststo: areg con ib9.leave male white black asian sagesq-sagequart syearat14 syearat14sq syearat14cub syearat14quart, ro a(survey)
esttab using "marshall_tab1.tex", b(%9.3f) se(3) ar(3) ///
stats(N, fmt(0 3) layout("\multicolumn{1}{c}{@}")  ///
labels(`"Observations"')) star(* 0.1  ** 0.05 *** 0.01) ///
mtitles("Model") ///
title("Economic" \label{table1}) style(tex) label append


****************************** MECHANISMS

*** Table 2: Raising social class, Heterogeneity by age (above 60), Become a Conservative partisan, and Decide before the electoral campaign

* this code creates table two - which aims to investigate if people continue
* to vote conservative even after they are retired (the implication being that people
* with more edu had higher incomes and that was why they voted conservative, once people
* got old and weren't experiencing the results of high incomes, they stopped voting
* conservative, which was found to be true)

* first see if people under 60 were more likely to be manual workers before and after the reform
* test this by running two different rdrobusts between nonmanual and yearat14 if age < 60
* in the first have no fuzzy input, in the second use fuzzy(leave) - for both cutoff is 1947
* p=1, q=2, kernel = tri and bwselect(IK)
* sum nonmanual if individuals were under 60 and 14 between 1934 and 1960

rdrobust nonmanual yearat14 if age<60, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
rdrobust nonmanual yearat14 if age<60, fuzzy(leave) c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
sum nonmanual if age<60 & yearat14>=1934 & yearat14<=1960

* now run rdrobust on voting con and yearat14 for people under 60
* same speficifcations and again one time without fuzzy(leave) and one time with
* sum con if individuals were under 60 and 14 between 1923 and 1969

rdrobust con yearat14 if age<60, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
rdrobust con yearat14 if age<60, c(1947) p(1) q(2) kernel(tri) bwselect(mserd) fuzzy(leave)
sum con if age<60 & yearat14>=1923 & yearat14<=1969

* now same process (two rdrobusts one fuzzy one not) for con and yearat14 for those over 60
* sum con if individuals were over 60 and 14 between 1932 and 1962

rdrobust con yearat14 if age>=60, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
rdrobust con yearat14 if age>=60, c(1947) p(1) q(2) kernel(tri) bwselect(mserd) fuzzy(leave)
sum con if age>=60 & yearat14>=1932 & yearat14<=1962

* now just run two rdrobusts on both conpart (whether individual is conservative
* partisan) and perm (if indiviudal decided how they were voting before campaign)
* like above, run one rdrobust with fuzzy(leave) and one without
* sun conpart if 14 between 1934 and 1960, sum perm if 14 between 1935 and 1959

rdrobust conpart yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
rdrobust conpart yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd) fuzzy(leave)
sum conpart if yearat14>=1934 & yearat14<=1960

rdrobust perm yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd)
rdrobust perm yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(mserd) fuzzy(leave)
sum perm if yearat14>=1935 & yearat14<=1959




*** Table 3 Panel A: Economic policy preferences

* table 3 investigates another implication of the data - does more high school education
* increase support for conservative values in addition to just voting conservative
* and of conservative values, does more education support conservative economic values or
* noneconomic values in addition?
* table 3 panel A investigates feelings toward conservative economic policy

* Marshall investigated 4 conservative economic values: opposition to tax and spend policies, 
* the belief that welfare spending has gone too far, opposition to income and wealth 
* redistribution, and opposition to the belief that attempts to give women equal opportunities
* have not gone far enough - all of these were run in a rdrobust with yearat 14
* cutoff 1947, p=1, q=2, tri kernel and bwselect(IK)
* in addition rdrobust was run for econ_values, which was a standardized, composite
* score indicating the conservative economic preference of an individual

rdrobust taxspendself yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
rdrobust welfaretoofar yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
rdrobust redist yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
rdrobust gender_not_too_much yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
sum gender_not_too_much if yearat14>=1931 & yearat14<=1963
rdrobust econ_values yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
sum econ_values if yearat14>=1930 & yearat14<=1964

* with the same 4 variables (and the composite econ_values variable) also
* run a fuzzy rdrobust

rdrobust taxspendself yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
rdrobust welfaretoofar yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
rdrobust redist yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
rdrobust gender_not_too_much yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
rdrobust econ_values yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)



*** Table 3 Panel B: Non-economic policy preferences

* after finding more edu did increase support for conservative economic policies 
* (although not always significantly), Marshall investigated if more high school increased
* support for more social conservative, and some social liberal values in Panel B of table3
* Marshall found there was no significant support for conservative economic policies or
* for liberal ones - indicating high school edu doesn't seem to effect either of them
* and that the increased conservative voting is almost all economically linked

* to do this rdrobust was again used
* this time foremphasis on reducing crime over protecting citizen right (crime_rights_scale),
* support for Britain leaving the European community (leave_europe), and opposition to abolishing
* private education (end private edu)
* rdrobust was also used for two liberal values of abortion and racial equality
* all rdrobusts were run with cutoff 1947, p=1, q=2, tri kernel and bwselect(IK)

rdrobust crime_rights_scale yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
rdrobust leave_europe yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
rdrobust end_priv_edu yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
rdrobust abortion_too_far yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
sum abortion_too_far if yearat14>=1933 & yearat14<=1961
rdrobust raceequ_too_far yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
sum raceequ_too_far if yearat14>=1927 & yearat14<=1967

* again the process was repeated for a fuzzy rdrobust

rdrobust crime_rights_scale yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
rdrobust leave_europe yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
rdrobust end_priv_edu yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
rdrobust abortion_too_far yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
rdrobust raceequ_too_far yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)



preserve
use "UK Election Data Replication.dta", clear

* perserve original UK Election data so analysis doesn't affect it

* run two rdrobusts on turnout (total number of people who voted inelections) one fuzzy
* and one not to see if it changed after 1947
* sum turnout btwen 1929 and 1965 and then sum turnout overall

rdrobust turnout yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK)
rdrobust turnout yearat14, c(1947) p(1) q(2) kernel(tri) bwselect(IK) fuzzy(leave)
sum turnout if yearat14>=1929 & yearat14<=1965
sum turnout

* restore data to what it had looked like when we called preserve

restore
