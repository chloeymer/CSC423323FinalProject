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

* temporary;
* need to check with predicting variable again (age or output);
* check for insignificant variables;
proc reg data = heart;
model output = sex cp thalachh exng oldpeak slp caa thall/vif tol;
run;

* stepwise selection method;
proc logistic data = heart;
model output (event = '1') = sex cp trtbps chol fbs restecg thalachh exng oldpeak slp caa thall age/ selection = stepwise; 
run;

proc logistic data = heart;
model output (event = '1') = sex cp trtbps thalachh exng oldpeak caa thall/rsquare stb corrb; 
run;

* check for outiers/influencial points;
proc reg data = heart;
model output = sex cp trtbps thalachh exng oldpeak caa thall/influence R ;
run; 

proc corr data = heart;
var output sex cp trtbps thalachh exng oldpeak caa thall;
run;
