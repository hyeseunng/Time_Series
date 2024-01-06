/** EXAMPLE 8.6 **/
 data gas;
   infile 'c:\R\gas.txt'; 
   input gas co2 @@; time+1; run;
proc print data = gas; run;

 proc sgplot data=gas;
   series x=time y=gas ; xaxis label="time"; yaxis label="gas"; run;
 proc arima data=gas;
   identify var=gas nlag=24; run;
   estimate p=3 method=cls plot; run;
   estimate p=3 method=ml noint plot; run;
   forecast lead=0 out=res; run; 
/** 잔차의 시계열그림 **/
 data res; set res; time=_n_; run; 
 proc sgplot data=res;
   series x=time y=residual ; xaxis label="time"; 
   yaxis label="residual"; refline 0 / axis=y; run;

/** EXAMPLE 8.7 **/
 data eg8_7;
   infile 'c:\data_r\eg8_7.txt';
   input z @@; time+1; run;
proc print data = eg8_7; run;

 proc arima data=eg8_7;
   identify var=z nlag=24; run;
   estimate p=1 plot; run;
   forecast lead=0 out=res1; run; 
/** 잔차의 시계열그림 **/
 data res1; set res1; time=_n_; run;
 proc sgplot data=res1;
   series x=time y=residual ; xaxis label="time"; 
   yaxis label="residual"; refline 0 / axis=y; run;
/** 과대적합을 통한 모형진단 **/
 proc arima data=eg8_7;
   identify var=z nlag=12 noprint; run;
   estimate p=2; run;
   estimate p=1 q=1;  run; 
