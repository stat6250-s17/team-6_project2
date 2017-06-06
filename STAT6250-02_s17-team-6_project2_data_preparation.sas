*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
[Dataset 1 Name] rentprice2015
[Dataset Description] Average monthly rent price across major cities in US 
from Jan-Dec 2015
[Experimental Unit Description] Major metropolitan cities in US.
[Number of Observations] 13,131                   
[Number of Features] 18
[Data Source] https://www.kaggle.com/zillow/rent-index
[Data Dictionary] https://www.kaggle.com/zillow/rent-index
[Unique ID Schema] The column “city code” identifies the experimental units 
in this dataset as well as in rentprice2016.
--
[Dataset 2 Name] rentprice2016
[Dataset Description] Average monthly rent price across major cities in 
US from Jan-Dec 2015
[Experimental Unit Description] Major metropolitan cities in US.
[Number of Observations] 13,131                 
[Number of Features] 18
[Data Source] https://www.kaggle.com/zillow/rent-index
[Data Dictionary] https://www.kaggle.com/zillow/rent-index
[Unique ID Schema] The column “city code” identifies the experimental units 
in this dataset as well as in rentprice2016.
--
[Dataset 3 Name] costlivingAM
[Dataset Description] Cost of living metrics in metro hubs around the world.
[Experimental Unit Description] Major cities around the world
[Number of Observations] 103                 
[Number of Features] 14
[Data Source] https://www.kaggle.com/blitzr/movehub-city-rankings
[Data Dictionary] https://www.kaggle.com/blitzr/movehub-city-rankings
[Unique ID Schema] The Column “City” is the unique id.All other columns are 
exactly replicated in costlivingNZ.
--
[Dataset 3 Name] costlivingNZ
[Dataset Description] Cost of living metrics in metro hubs around the world.
[Experimental Unit Description] Major cities around the world
[Number of Observations] 113                 
[Number of Features] 14
[Data Source] https://www.kaggle.com/blitzr/movehub-city-rankings
[Data Dictionary] https://www.kaggle.com/blitzr/movehub-city-rankings
[Unique ID Schema] The Column “City” is the unique id. All other columns are 
exactly replicated in costlivingNZ.
;

* environmental setup;

* create output formats;

proc format;
    value $country_bins
        "United States"="United State"
	other="Not_United State"
    ;
    value Avg_Disposable_Income
	low-<999="Q1 Avg_Disposable_Income "
	1000-<1535="Q2 Avg_Disposable_Income "
	1536-<2999="Q3 Avg_Disposable_Income "
	3000-high="Q4 Avg_Disposable_Income "
    ;
run;


* setup environmental parameters;
%let inputDataset1URL =
https://github.com/stat6250/team-6_project2/blob/master/data/rentprice2015.xls?raw=true
;
%let inputDataset1Type = XLS;
%let inputDataset1DSN = rentprice2015_raw;

%let inputDataset2URL =
https://github.com/stat6250/team-6_project2/blob/master/data/rentprice2016.xls?raw=true
;
%let inputDataset2Type = XLS;
%let inputDataset2DSN = rentprice2016_raw;

%let inputDataset3URL =
https://github.com/stat6250/team-6_project2/blob/master/data/costlivingAM.xls?raw=true
;
%let inputDataset3Type = XLS;
%let inputDataset3DSN = costlivingAM_raw;

%let inputDataset4URL =
https://github.com/stat6250/team-6_project2/blob/master/data/costlivingNZ.xls?raw=true
;
%let inputDataset4Type = XLS;
%let inputDataset4DSN = costlivingNZ_raw;

* load raw datasets over the wire, if they doesn't already exist;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile "%sysfunc(getoption(work))/tempfile.xlsx";
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    &inputDataset1DSN.,
    &inputDataset1URL.,
    &inputDataset1Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset2DSN.,
    &inputDataset2URL.,
    &inputDataset2Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset3DSN.,
    &inputDataset3URL.,
    &inputDataset3Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset4DSN.,
    &inputDataset4URL.,
    &inputDataset4Type.
)

* sort and check raw datasets for duplicates with respect to their unique ids,
  removing blank rows, if needed;
proc sort
        nodupkey
        data=rentprice2015_raw
        dupout=rentprice2015_raw_dups
        out=rentprice2015_raw_sorted(where=(not(missing(City_Code))))
    ;
    by
        City_Code
	;
run;
proc sort
        nodupkey
        data=rentprice2016_raw
        dupout=rentprice2016_raw_dups
        out=rentprice2016_raw_sorted(where=(not(missing(City_Code))))
    ;
    by
        City_Code
	;
run;
proc sort
        nodupkey
        data=costlivingAM_raw
        dupout=costlivingAM_raw_dups
        out=costlivingAM_raw_sorted(where=(not(missing(City))))
    ;
    by
        City
	;
run;
proc sort
        nodupkey
        data=costlivingNZ_raw
        dupout=costlivingNZ_raw_dups
        out=costlivingNZ_raw_sorted(where=(not(missing(City))))
    ;
    by
        City
	;
run;

* combine costlivingAM and costlivingNZ data vertically into a single dataset.
Data housing_concat;

Data costliving_combined;
	set costlivingAM_raw_sorted costlivingNZ_raw_sorted;
run;

* build analytic dataset from raw datasets with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data costliving_combined_edited;
	retain
		Country
		City
		Cappuccino
		Cinema
		Wine
		Gasoline
		Avg_Rent
		Avg_Disposable_Income
		Crime_Rating
		;
	keep
		Country
		City
		Cappuccino
		Cinema
		Wine
		Gasoline
		Avg_Rent
		Avg_Disposable_Income
		Crime_Rating
		;
	set costliving_combined;
run;

*Combine rentprice2015 and rentprice 2016 with macro data horizontally;
Data rentprice_combined;
	set rentprice2015_raw;
	set rentprice2016_raw;
run;

* build analytic dataset from raw datasets with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data rentprice_combined_edited;
	retain
		City_Code
		City
		Metro
		County
		State
		Population_Rank
		Jan_15
		Feb_15
		Mar_15
		Apr_15
		May_15
		Jun_15
		Jul_15
		Aug_15
		Sep_15
		Oct_15
		Nov_15
		Dec_15
		Jan_16
		Feb_16
		Mar_16
		Apr_16
		May_16
		Jun_16
		Jul_16
		Aug_16
		Sep_16
		Oct_16
		Nov_16
		Dec_16
		;
	keep
		City_Code
		City
		Metro
		County
		State
		Population_Rank
		Jan_15
		Feb_15
		Mar_15
		Apr_15
		May_15
		Jun_15
		Jul_15
		Aug_15
		Sep_15
		Oct_15
		Nov_15
		Dec_15
		Jan_16
		Feb_16
		Mar_16
		Apr_16
		May_16
		Jun_16
		Jul_16
		Aug_16
		Sep_16
		Oct_16
		Nov_16
		Dec_16
		;
	set rentprice_combined;
run;


* Calculate the average rent price from 2015 to 2016 and produces a 
table. Sort the table by average.
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


proc sort data=rentprice_avg out=rentprice_sort2;
    by
        population_rank
    ;
run;

* calculates the max and min rent price for each city. Calculates
the difference between the max and min. Then sort by the difference.
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

* calculates the average rent price for 2015 and for 2016. Take the 
difference between 2016 and 2015 to see what the increase/decrease is.
Sort by the difference.
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

proc sort data=rentprice_incr_2015_2016 out=rentprice_decr_2015_2016_sort;
    by 
        diffavg
    ;
run;


*Use PROC MEANS to compute the mean of Avg_Rent for City,
and output the results to a temporary dataset, and use PROC SORT
to extract and sort just the means the temporary dateset,
which will be used as part of data analysis by YY.
;
proc means
        mean
        noprint
        data=costliving_combined
    ;
    class
        City
    ;
    var
        Avg_Rent
    ;
    output
        out=costliving_combined_temp
    ;
run;

proc sort
        data=costliving_combined_temp(where=(_STAT_="MEAN"))
    ;
    by
        descending Avg_Rent
    ;
run;

*Use PROC MEANS to compute the mean of Crime_Rating for City,
and output the results to a temporary dataset, and use PROC SORT
to extract and sort just the means the temporary dateset,
which will be used as part of data analysis by YY.
;
proc means
        mean
        noprint
        data=costliving_combined
    ;
    class
        City
    ;
    var
        Crime_Rating
    ;
    output
        out=costliving_combined_temp
    ;
run;

proc sort
        data=costliving_combined_temp(where=(_STAT_="MEAN"))
    ;
    by
        ascending Crime_Rating
    ;
run;
