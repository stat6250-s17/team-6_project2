*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding college-preparation trends at CA public K-12 schools
Dataset Name: cde_2014_analytic_file created in external file
STAT6250-02_s17-team-0_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
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

*
Research question: Which metropolitan area is the most expensive to live in? 

Rational: We can have a rough idea of the range of the rent and the tendency of
house renting over the year.

Methodology:
Limitations: 
Followup Steps:
;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

*
Question: Where have rental prices increased in the past six years and where have
they remained the same? 

Rational: We can then analysis the tendency of the house renting and know the 
relationship between the location and house rent price over the years, also get 
the overall graph of the rent.

Methodology:

Limitations: 

Followup Steps:
;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

*
Question: Which city or state has the lowest cost per square foot over the years? 
Have they changed? 

Rational: We can study the relationship between the location and the lowest rent 
over the year and observe the reason behind this changed/unchanged variables.

Methodology:

Limitations: 

Followup Steps:
;
