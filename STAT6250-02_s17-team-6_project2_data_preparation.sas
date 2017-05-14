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

* setup environmental parameters;
%let inputDataset1URL =
https://github.com/stat6250/team-6_project2/blob/master/data/rentprice2015.xls?raw=true
;
%let inputDataset1Type = XLS;
%let inputDataset1DSN = rentprice2015_raw;

%let inputDataset2URL =
https://github.com/stat6250/team-0_project2/blob/master/data/rentprice2016.xls?raw=true
;
%let inputDataset2Type = XLS;
%let inputDataset2DSN = rentprice2016_raw;

%let inputDataset3URL =
https://github.com/stat6250/team-0_project2/blob/master/data/costlivingAM.xls?raw=true
;
%let inputDataset3Type = XLS;
%let inputDataset3DSN = costlivingAM_raw;

%let inputDataset4URL =
https://github.com/stat6250/team-0_project2/blob/master/data/costlivingNZ.xls?raw=true
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

