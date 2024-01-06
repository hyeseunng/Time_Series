data fig1;
	infile 'C:\regression\depart.txt';
	input z @@;
	logz= log(z);
	date = intnx('month', '1jan84'd, _n_-1) ;
	format date monyy. ;
proc print data=fig1; run;
proc sgplot;
	series x=date y=logz / lineattrs=(color=blue) ; run;
