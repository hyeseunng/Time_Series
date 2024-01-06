data fig1_1;
do t=1 to 100;
z=5000+20*rannor(1234); /**몬테깔로 시뮬**/
output;
end;
run;
data fig1_1;
set fig1-1;
date=intnx('month','1jian80'd,_n_-1);
format date monyy.; run;
proc gplot;
plot z*date=1/vref=5000;
/**figure 1.4. 백화점매출 자료의 시계열그림과 직선식 겹쳐 그리기**/
data fig1_4;
infile 'C:\data\depart.txt';
input z @@;
logz=log(z);                                                 /**자연로그**/   
date=intnx( 'month',  '1jan84'd  , _n_-1);   /** _n_ : 자료개수 (자동변수), _n_-1=59 /'1jan84'd  얘를 시작으로 몇개(59개)를 더 넣을까**/   
format date monyy.; 
x=2.701573+0.000409*date; run;
/**팝업창으로 결과 확인하기**/
proc print data=fig1_4; run;

proc sgplot;
series x=date y=logz/lineattrs=(color=blue);
series x=date y=x/lineattrs=(color=black); run;

/**HW1**/
data fig1_7_1;
infile 'C:\data\female_hw1.txt';
input z @@;
logz=log(z);
date=intnx( 'month',  '1jan81'd  , _n_-1);  
format date monyy.; 
run;
proc print data=fig1_7_1; run;
proc sgplot;
series x=date y=z;run;


/**hw 1-7-2**/
data fig1_7_2;
infile 'C:\data\build_hw1.txt';
input z @@;
logz=log(z);
date=intnx( 'month',  '1jan81'd  , _n_-1);  
format date monyy.; 
run;
proc print data=fig1_7_2; run;
proc sgplot;
series x=date y=z;run;
/**hw 1-7-3**/
data fig1_7_3;
infile 'C:\data\export_hw1.txt';
input z @@;
logz=log(z);
date=intnx( 'month',  '1jan81'd  , _n_-1);  
format date monyy.; 
run;
proc print data=fig1_7_3; run;
proc sgplot;
series x=date y=z;run;
/**hw 1-7-4**/
data fig1_7_4;
infile 'C:\data\usapass_hw1.txt';
input z @@;
logz=log(z);
date=intnx( 'month',  '1jan81'd  , _n_-1);  
format date monyy.; 
run;
proc print data=fig1_7_4; run;
proc sgplot;
series x=date y=z;run;

