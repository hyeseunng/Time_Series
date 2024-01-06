data pop;
	infile 'C:\regression\population.txt';
	input pop@@;
	pop=round(pop/10000);
	lnpop=log(pop);
	t+1;t2=t*t;year=1959+t ; run;

	proc print data=pop; run;
proc sgplot data=pop;
	series x=year y=pop /  markers markerattrs=(symbol=asterisk);
	xaxis values=(1960 to 1995 by 5); run;
proc reg data=pop;
	model pop=t/dw;
	output out=out1 p=pred1 r=residual1; run;




proc sgplot data=out1;
	series x=year y=residual1 markers markerattrs= (symbol=square);
	xaxis values=(1960 to 1995 by 5);
	refline 0/axis=y; run;




proc reg data=pop;
	model pop=t t2/dw;
	output out=out2 p=pred2 r=residual2; run;




proc sgplot data=out2;
	series x=year y=pop/ markers markerattrs= (symbol=circle);
	scatter x=year y=pred2/markerattrs=(symbol=plus);
	xaxis values=(1960 to 1995 by 5);
	yaxis label="pop" ; run;

proc sgplot data=out2;
	series x=year y=residual2 / lineattrss=(pattern=1 color=black thickness=1)
		markers markerattrs=(symbol=star color=black size=5);
	xaxis values=(1960 to 1995 by 5);
	refline 0/axis=y; run;

proc reg data=pop;
	model lnpop=t t2/dw;
	output out=out3 p=pred2 r=residual3; run;
proc sgplot data=out3;
	series x=year y=residual3 / lineattrss=(pattern=1 color=black thickness=1)
		markers markerattrs=(symbol=diamondfilled color=black size=5);
	xaxis values=(1960 to 1995 by 5);
	refline 0/axis=y; run;

/** 지시함수를 이용한 계절모형 적합**/

data dept;
	infile 'C:\Temp\depart.txt'; input dept @@;
	lndept=log(dept);t+1;
	date=intnx('month', '1JAN84'D,_n_-1); format date monyy.;
		mon=month(date);
		if mon=1 then i1=1; else i1=0;
		if mon=2 then i2=1; else i2=0;
		if mon=3 then i3=1; else i3=0;
		if mon=4 then i4=1; else i4=0;
		if mon=5 then i5=1; else i5=0;
		if mon=6 then i6=1; else i6=0;
		if mon=7 then i7=1; else i7=0;
		if mon=8 then i8=1; else i8=0;
		if mon=9 then i9=1; else i9=0;
		if mon=10 then i10=1; else i10=0;
		if mon=11 then i11=1; else i11=0;
		if mon=12 then i12=1; else i12=0; run;
		proc print data= dept ; run;
proc sgplot;
	series x=date y=dept/ markers markerattrs= (symbol=dot); run;
proc sgplot;
	series x=date y=lndept/ markers markerattrs= (symbol=dot); run;
proc reg; 
	model lndept=t i1-i12/noint dw;
	output out=deptout r=residual; run;
proc sgplot data=deptout;
	series  x=date y=residual / markers markerattrs= (symbol=circlefilled);
	refline 0/ axis=y; run;
proc arima data=deptout; identify var=residual; run;
		proc print data= deptout ; run;


/** 2.4 자기회귀오차모형 적합**/
proc autoreg data=dept;
	model lndept=t i1-i12/noint backstep nlag=13 dwprob;
	output out=out1 r=residual; run;
proc sgplot data=out1;
	series x=date y=residual/ markers markerattrs=(symbol=dot);
	refline 0/ axis=y; run;
		

