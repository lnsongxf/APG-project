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


% add path to DCC estimator
DCCpath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\DCC_NL06';
addpath(DCCpath)



% add path to shrinkage methods
SHRINKAGEpath='D:\Uni\MASTER\Seminar\Matlab\Shrinkage';
addpath(SHRINKAGEpath)

% add path to Portfolio Construction 
PORTFOLIOpath='D:\Uni\MASTER\Seminar\Matlab\PortfolioConstruction';
addpath(PORTFOLIOpath)



% add path to Oxford MFE toolbox [would be different on your computer]
mfepath='D:\Uni\MASTER\Seminar\Ledoit & Wolf Code\mfe-toolbox-master';
CURRENT_DIRECTORY=pwd;
cd(mfepath)
addToPath('-silent')
cd(CURRENT_DIRECTORY)
clear CURRENT_DIRECTORY

% read return data
ReadData


portfoliosSAMPLE = [];
portfoliosDCC = [];


parfor i = 1:4
    if i==1
         portfoliosSAMPLE(:,i) =   PORTFOLIOconstruction(returns, dates, 'daily', 100, 'SAMPLE', 'QuEST', 0);
    else
        if i==2
         portfoliosSAMPLE(:,i) =   PORTFOLIOconstruction(returns, dates, 'daily', 100, 'SAMPLE', 'lineareig', 0);
        else
            if i==3
         portfoliosSAMPLE(:,i) =   PORTFOLIOconstruction(returns, dates, 'daily', 100, 'SAMPLE', 'modelfree', 0); 
            else
                 portfoliosSAMPLE(:,i) =   PORTFOLIOconstruction(returns, dates, 'daily', 100, 'SAMPLE', 'NONE', 0);
            end
        end
            
           


    end
end

parfor i = 1:4
    if i==1
         portfoliosDCC(:,i) =   PORTFOLIOconstruction(returns, dates, 'daily', 100, 'DCC', 'QuEST', 0);
    else
        if i==2
         portfoliosDCC(:,i) =   PORTFOLIOconstruction(returns, dates, 'daily', 100, 'DCC', 'lineareig', 0);
        else
            if i==3
         portfoliosDCC(:,i) =   PORTFOLIOconstruction(returns, dates, 'daily', 100, 'DCC', 'modelfree', 0); 
            else
                portfoliosDCC(:,i) =   PORTFOLIOconstruction(returns, dates, 'daily', 100, 'DCC', 'NONE', 0); 
            end
        end

    end
end














