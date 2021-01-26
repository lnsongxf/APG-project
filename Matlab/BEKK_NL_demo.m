% BEKK_NLdemo.m - demonstrate how to estimate the scalar BEKK-NL model
% originally based on DCC_NLdemo.m but adapted for the BEKK-NL model
% details of the BEKK-NL model are in Section 7 of the article 
% entitled "Large Dynamic Covariance Matrices"  in the Journal of 
% Business and Economics Statistics, authored by Robert F. Engle, 
% Olivier Ledoit, and Michael Wolf

clear
clear global

% add path to QuEST toolbox [would be different on your computer]
QuESTpath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\QuEST_v027';
addpath(QuESTpath)

%
%
DIRECTpath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\Direct';
addpath(DIRECTpath)
% USE OWN CODE FOR DIRECT KERNEL ESTIMATION 
% currently not used
%

% add path to DCC estimaters
BEKKpath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\DCC_NL06';
addpath(BEKKpath)



% add path to Oxford MFE toolbox [would be different on your computer]
mfepath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\mfe-toolbox-master';
CURRENT_DIRECTORY=pwd;
cd(mfepath)
addToPath('-silent')
cd(CURRENT_DIRECTORY)
clear CURRENT_DIRECTORY

% load test data set (if too big for your RAM, cut off some columns)
load DataFrame.mat
x=returns(1:120,:);
x=double(x);
[t,n]=size(x);

% estimate BEKK-NL model
disp(['Starting to estimate BEKK-NL model at ' datestr(now)])
sigmahat=BEKKcov(x);
disp(['Finished estimating BEKK-NL model at ' datestr(now)])

% display a sample of the results for verification purposes
disp(sigmahat(end-2:end,end-2:end)*100)