data fig1_1;
do t=1 to 100;
z=5000+20*rannor(1234); /**���ױ�� �ù�**/
output;
end;
run;
data fig1_1;
set fig1-1;
date=intnx('month','1jian80'd,_n_-1);
format date monyy.; run;
proc gplot;
plot z*date=1/vref=5000;
/**figure 1.4. ��ȭ������ �ڷ��� �ð迭�׸��� ������ ���� �׸���**/
data fig1_4;
infile 'C:\data\depart.txt';
input z @@;
logz=log(z);                                                 /**�ڿ��α�**/   
date=intnx( 'month',  '1jan84'd  , _n_-1);   /** _n_ : �ڷᰳ�� (�ڵ�����), _n_-1=59 /'1jan84'd  �긦 �������� �(59��)�� �� ������**/   
format date monyy.; 
x=2.701573+0.000409*date; run;
/**�˾�â���� ��� Ȯ���ϱ�**/
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

