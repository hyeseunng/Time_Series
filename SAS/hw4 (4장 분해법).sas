
/**HW4**/

data food;
infile 'C:\R\food.txt'; input food @@;
date= intnx('month', '1jan80'd, _n_-1);
format date monyy.; t+1;
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

proc print data=food; run;

/**food자료에 선형추세모형 적합하기**/
proc reg data=food; 
model food=t/dw;
output out= trendata p=trend;
id date; run;
data adtrdata; 
set trendata; 
adjtrend=food-trend; 
run;

/**food자료에 회귀오차모형 적합하기**/
proc reg data=adtrdata;
model adjtrend=i1-i12/noint;
output out=seasdata p=seasonal; run;
data all;
	set seasdata;
    keep date food trend seasonal irregular fitted;
	irregular=adjtrend-seasonal; 
	fitted=trend+seasonal;
	run;
proc print data=all;
	var date food trend seasonal irregular fitted; run;

/** [그림 4-1] 그리기**/
proc sgplot data=all;
	series x=date y=food/ lineattrs=(pattern=1 color=blue);
	series x=date y=trend/ lineattrs=(pattern=2 color=black); run;
/** [그림 4-2] 그리기**/
proc sgplot data=all; series x=date y=seasonal; run;
/** [그림 4-3] 그리기**/
proc sgplot data=all; series x=date y=irregular; refline 1.0/ axis=y; run;
/** [그림 4-4] 그리기**/
proc sgplot data=all;
	series x=date y=food/ lineattrs=(pattern=1 color=blue);
	series x=date y=trend/ lineattrs=(pattern=2 color=black); run;



