*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;


*
This file uses the following analytic dataset to address several research
questions regarding rental prices and living cost trends at in the US.
Dataset Name: rentprice_combined and livingcost_combined created in 
external file STAT6250-02_s17-team-6_project2_data_preparation.sas, which is 
assumed to be in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset cde_2014_analytic_file;
%include '.\STAT6250-02_s17-team-6_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'What are the Top 5 US Cities with the highest property rent price in from 2015-2016?'
;

title2
'This will help identify which cities are the most expensive to live in.'
;

footnote1
'Jupiter Island has the most expensive average rent from 2015-2016 at about $20,800 a month.'
;

footnote2
'The top five cities are located in Florida and California. These cities are not well-known but are located near well-known metropolitan areas like San Francisco, Los Angeles, and Miami. '
;

footnote3
'These cities are likely tiny, exclusive and highly expensive communities. A follow-up would be to look at the cities by the population ranking.'
;

*
Question: What are the top 5 most expensive US cities in terms of average rent 
price in 2015-2016? Are the 5 least expensive US cities in terms of average rent 
price? 

Rationale: 
This will help identify cities where renting may be an issue due to high demand 
and low supply or the opposite. It will also show if there is any interesting 
geographic insights about cities with highest rent - such as 
coastal cities vs. inland cities.

Methodology: I will use PROC MEAN to calculate the mean of rent prices from 
Jan 2015 to Dec 2016 to proceed a new mean variable. Then using PROC SORT, I 
will sort the data and print only the top 5 cities by the mean variable.

Limitations: This output will take in account the average rent price over
a 2 year period. However, the trends could proceed additiona insights.
This will not show if rent has been declining in certain cities.

Followup Steps: Possible follow-up steps is to calculate change over month.
Or compare the average against the last month.
;

data rentprice_avg;
    set rentprice_combined;

    average=mean(of Jan_15 Feb_15 Mar_15 Apr_15 May_15 Jun_15 Jul_15 
        Aug_15 Sep_15 Oct_15 Nov_15 Dec_15 Jan_16 Feb_16 Mar_16 Apr_16 
        May_16 Jun_16 Jul_16 Aug_16 Sep_16 Oct_16 Nov_16 Dec_16);
run;

proc sort data=rentprice_avg out=rentprice_sorted;
    by descending
        average
	  ;
run;

proc print
        data=rentprice_sorted(obs=5)
  ;
  id
        City Metro County State
	;
	var
		    average
  ;
run;

title;
footnote;


title1
'Average rent price for Top 5 cities with largest population'
;

proc sort data=rentprice_avg out=rentprice_sort2;
    by
        population_rank
    ;
run;

proc print
        data=rentprice_sort2(obs=5)
    ;
    id
        City Metro County State Population_Rank
	;
	var
		average
    ;
run;

title;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;


title1
'Whare are the Top 5 Cities in the US with the largest rent fluctuation between 2015-2016.'
;

title2
'This may reveal some interesting insight about cities where rent is more volatile and if there may be economic reasons for such.'
;

footnote1
'Not surprisingly, Jupiter Island once again comes out on top. This may suggest that Jupiter Island is a vacation spot and therefore experiences high and low visitation season.'
;

footnote2
'All 5 of these cities upon further research are small, exclusive communities with low population but inhabited by the wealthiest people in US.'
;

footnote3
'This could also suggest that the rent fluctuation could have something to do with the economy and how well its performing, especially since so much is dependent on the very few.'
;

*
Question: What are the top 5 cities with the highest rent flunctuation between 
2015-2016? 

Rationale: Rent prices fluctuates. This will help us identify communities may 
be have seasonal factors or are more vacational cities.

Methodology: Using Max to identify the highest rent across obsveration, min to 
idenitfy the lowest, and calculate the difference between the max and min.

Limitations: This output does not show which month is the max and which is the 
min. Some cities may have a seasonal pattern different from others and this will 
not reveal this information.

Followup Steps: A possible follow-up is to identify the month associate with the 
max and min rent price.
;

data rentprice_range;
    set
	    rentprice_combined;
    maxmonth=max(of Jan_15 Feb_15 Mar_15 Apr_15 May_15 Jun_15 Jul_15 
        Aug_15 Sep_15 Oct_15 Nov_15 Dec_15 Jan_16 Feb_16 Mar_16 Apr_16 
        May_16 Jun_16 Jul_16 Aug_16 Sep_16 Oct_16 Nov_16 Dec_16);
	  minmonth=min(of Jan_15 Feb_15 Mar_15 Apr_15 May_15 Jun_15 Jul_15 
        Aug_15 Sep_15 Oct_15 Nov_15 Dec_15 Jan_16 Feb_16 Mar_16 Apr_16 
        May_16 Jun_16 Jul_16 Aug_16 Sep_16 Oct_16 Nov_16 Dec_16); 
    diff=maxmonth-minmonth;

proc sort data=rentprice_range out=rentprice_s1;
    by descending
        diff
    ;
run;

proc print
        data=rentprice_s1(obs=5)
    ;
    id
        City Metro County State 
	;
	var
		maxmonth minmonth diff
    ;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;


title1
'Which 5 cities have had the largest increase in rent prices from 2015 to 2016?'
;

title2
'This will help reveal economic trend for those cities - idenitfy which cities are on the rise.'
;

footnote1
'Three cities in the top 5 list are located in New York, one in California, and one in Florida. All 5 cities saw an increase of well over $1,000 in average rent prices between 2015 and 2016.'
;

footnote2
'The amount of increase in rent is really startling. A follow-up is to see what cities had a decrease in average rent price.'
;

*
Question: Which 5 cities have had the largest increase in rent prices from 
the two averages. Sort by the difference variable and print the top 5 cities.

Limitations: This only looks at increase of price. Looking at highest decrease
can also reveal interesting insights.

Followup Steps: Print the highest negative difference, not only the highest 
positive difference.
;


data rentprice_incr_2015_2016;
    set
	    rentprice_combined;
    avg2015=mean(of Jan_15 Feb_15 Mar_15 Apr_15 May_15 Jun_15 Jul_15 
        Aug_15 Sep_15 Oct_15 Nov_15 Dec_15);
	  avg2016=mean(of Jan_16 Feb_16 Mar_16 Apr_16 
        May_16 Jun_16 Jul_16 Aug_16 Sep_16 Oct_16 Nov_16 Dec_16); 
    diffavg=avg2016-avg2015;

proc sort data=rentprice_incr_2015_2016 out=rentprice_incr_2015_2016_sort;
    by descending
        diffavg
    ;
run;

proc print
        data=rentprice_incr_2015_2016_sort(obs=5)
    ;
    id
        City Metro County State 
	;
	var
		avg2015 avg2016 diffavg
    ;
run;

title;
footnote;

title1
'Top 5 cities with largest decrease in average rent from 2015 to 2016'
;

proc sort data=rentprice_incr_2015_2016 out=rentprice_decr_2015_2016_sort;
    by 
        diffavg
    ;
run;

proc print
        data=rentprice_decr_2015_2016_sort(obs=10)
    ;
    id
        City Metro County State 
	;
	var
		avg2015 avg2016 diffavg
    ;
run;

title;

