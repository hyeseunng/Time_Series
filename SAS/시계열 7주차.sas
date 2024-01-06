/**EXAMPLE 3.1 :Simple Expotential Smoothing **/

data mindex;
infile 'C:\regression\mindex.txt'; 
input mindex @@;
date=intnx('month','1jan86'd,_n_-1);
format date monyy.; run;

proc print data=mindex; run;

proc sgplot data= mindex;
series x=date y=mindex;
run;

proc forecast data=mindex
	interval=month method=expo out=out1 outest=est1
	weight=0.89 trend =1 lead=6 outfull outresid; 
	id date; var mindex; run;

	proc print data=est1; run;
	proc print data=out1; run;
/**[그림 3-1]**/
proc sgplot data=out1;
	series x=date y=mindex/group=_type_;
	where _type_^='RESIDUAL';
	refline '01may94'd/axis=x;
	yaxis values=(0 to 30 by 5); run;
/**[그림 3-4]**/
data out11; set out1; 
	if _type_='RESIDUAL'; error=mindex; run;
proc sgplot data=out11;
	series x=date y=error;
	refline 0/ axis=y;
	yaxis values=(-6 to 5 by 1); run;
proc print data=out11; run;
/**[표 3-3]**/

proc arima data=out11; identify var=error; run;
proc univariate data=out11; var error; run;



/**p.171*      이동평균값구하기            */
proc expand data=mindex out=mindex1;
	convert mindex=m3/transformout=(cmovave 3 trim 1);
	convert mindex=m7/transformout=(cmovave 7 trim 3); run;


/** [표 4-4]**/
proc print data=mindex1; run;
	var mindex m3 m7; run;

/** [그림 4-5]**/
proc sgplot data=mindex1;
	series x=date y=mindex/lineattrs =(pattern=1 color=black);
	series x=date y=m3/lineattrs =(pattern=2 color=blue);
	xaxis values=('1jan86'd to '1jan94'd by year); run;
/** [그림 4-6]**/
proc sgplot data=mindex1;
	series x=date y=mindex/lineattrs =(pattern=1 color=black);
	series x=date y=m7/lineattrs =(pattern=2 color=blue);
	xaxis values=('1jan86'd to '1jan94'd by year); run;
