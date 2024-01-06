/**시계열 7장**/

data depart;
	infile 'C:\R\depart.txt';
	input z @@;
	date=intnx('month','1jan84'd, _n_-1);
	format date Monyy.; run;

proc print data=depart; run;

	/** FIGURE 7.1**/
proc sgplot;
	series x=date y=z; xaxis values=('1jan84'd to '1jan89'd by year)
	label="date"; yaxis label ="depart"; run;

data ldepart;
	set depart; logz=log(z); run;

proc print data=ldepart; run;

/** FIGURE 7.2**/
proc sgplot data=ldepart;
	series x=date y=logz; 
	xaxis values=('1jan84'd to '1jan89'd by year)
	label="date"; yaxis label ="ln depart"; run;

data depart; /*1차 및 계절 차분*/
	set ldepart; dif1=dif(logz); dif1_12=dif12(dif1); run;
proc print data=depart; run;

	/** FIGURE 7.5**/
proc sgplot data=depart ;
	series x=date y=dif1; 
	xaxis values=('1jan84'd to '1jan89'd by year)
	label="date"; yaxis label ="▽ln Zt"; refline 0/ axis=y; run;
/** FIGURE 7.6**/
proc sgplot ;
	series x=date y=dif1_12; 
	xaxis values=('1jan85'd to '1jan89'd by year)


	label="date"; yaxis label ="▽▽12 ln Zt"; refline 0/ axis=y; run;





