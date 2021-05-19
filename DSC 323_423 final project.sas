proc import datafile = "heart.csv" out = heart replace;
delimiter = ",";
getnames = yes;
run;
proc print;
run;

title "Descriptives";
proc means min p25 p50 p75 max std;
var age trtbps chol thalachh oldpeak;
run;

title "Histogram W/ normal curve";
proc univariate normal;
var age trtbps chol thalachh oldpeak;
histogram / normal (mu = est sigma = est);
run;

title "Boxplots vs IDVs";
proc sort;
by output;
run;
proc boxplot;
plot trtbps*output;
plot chol*output;
plot thalachh*output;
plot oldpeak*output;
plot age*output;
plot sex*output;
plot cp*output;
plot fbs*output;
plot restecg*output;
plot thalachh*output;
plot exng*output;
plot oldpeak*output;
plot caa*output;
run;

* scatter plot;
proc sgscatter;
plot (age)*(sex cp trtbps chol fbs restecg thalachh exng oldpeak slp caa thall output)/pbspline;
run;
