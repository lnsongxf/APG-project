function sigmahat = DCC_shrinkage(x,method)
% method must be either
% - modelfree (model free shrinkage from ledoit and wolf 2003)
% - lineareig (linear eigenvalue shrinkage from ledoit and wolf 2004)
% - quEST (nonlinear eigenvalue shrinkage from ledoit and wolf 2012,2015)

% May also add dcc univariate specification. Currently default is
% TARCH(1,1), but could be extended to TGARCH or perhaps regime switching
% GARCH models.


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

% add path to shrinkage methods
SHRINKAGEpath='D:\Uni\MASTER\Seminar\Matlab\Shrinkage';
addpath(SHRINKAGEpath)



% add path to Oxford MFE toolbox [would be different on your computer]
mfepath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\mfe-toolbox-master';
CURRENT_DIRECTORY=pwd;
cd(mfepath)
addToPath('-silent')
cd(CURRENT_DIRECTORY)
clear CURRENT_DIRECTORY

x=double(x);

% estimate DCC-NL model
sigmahat=DCCcov(x,method);

end