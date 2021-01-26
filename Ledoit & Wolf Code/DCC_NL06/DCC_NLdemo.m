% DCC_NLdemo.m - demonstrate how to estimate the DCC-NL model
%
% originally based on estimat20f.m but reorganized for the DCC-NL package
%
% simulated data in DCC_NLdata.mat roughly corresponds to the base-case 
% scenario described in Section 5.1 of the article

clear
clear global

% add path to QuEST toolbox [would be different on your computer]
QuESTpath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\QuEST_v027';
addpath(QuESTpath)

% add path to direct kernel estimator [would be different on your computer]

%
%
DIRECTpath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\Direct';
addpath(DIRECTpath)
% USE OWN CODE FOR DIRECT KERNEL ESTIMATION 
%
%



% add path to Oxford MFE toolbox [would be different on your computer]
mfepath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\mfe-toolbox-master';
CURRENT_DIRECTORY=pwd;
cd(mfepath)
addToPath('-silent')
cd(CURRENT_DIRECTORY)
clear CURRENT_DIRECTORY

% load test data set (if too big for your RAM, cut off some columns)
load DCC_NLdata.mat x
x=x(:,1:50);
x=double(x);
[t,n]=size(x);

% estimate DCC-NL model
disp(['Starting to estimate DCC-NL model at ' datestr(now)])
sigmahat=DCCcov(x);
disp(['Finished estimating DCC-NL model at ' datestr(now)])

% display a sample of the results for verification purposes
disp(sigmahat(end-2:end,end-2:end)*100)
