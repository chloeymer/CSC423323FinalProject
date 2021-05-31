# CSC423323FinalProject

CSC 423 / 323 Final Project
proc import datafile = "heart.csv" out = heart replace;
delimiter = ",";
getnames = yes;
run;

proc print data = heart;
run;

proc sgscatter;
title "Association between age and the other variables";
matrix Age sex cp trtps chol fbs restecg thalachh exng oldpeak slp caa thall output;
run;
