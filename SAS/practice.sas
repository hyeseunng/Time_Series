data pop;
	infile 'C:\regression\population.txt' ; 
	input z @@;
	date = intnx( 'month', '1jan89'd, _n_-1) ;
	format date monyy.;
	logz=log(z);
proc sgplot;
	series x=date y=z; run;
 

proc arima data=out11;
identify var=error;
run;

proc univariate data=out11;
var error; run;


/*example 2.4 자기회귀오차모형 적합**/
proc autoreg data=dept;
	model lndept= t i1-i12 / noint backstep nlag=13 dwprob;
	output out=out1 r=resid1; run;
