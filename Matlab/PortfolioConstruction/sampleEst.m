function sigmahat = sampleEst(x, method, demean)
% function [sigmahat, Ht, parameters, ll]=DCCcov(x,demean)
%
% Estimation of scalar DCC(1,1) multivarate volatility model with GARCH(1,1)
% conditional variances
%
% INPUTS:
%   x            - A T by K matrix of zero mean residuals
%   demean       - set to 1 if the data need to be demeaned first, 
%                  and 0 otherwise (optional, default is 1)
%   method       - choose between modelfree, lineareig, QuEST, NONE (default is
%                  QuEST)
% OUTPUTS:
%   sigmahat     - K*K  covariance matrix matrix 

if demean
    meanx=mean(x);
    x=x-meanx(ones(T,1),:);
end


switch method
    case 'modelfree'
        sigmahat = modelfreeShrinkage(x);

    case 'lineareig'
        sigmahat = linearShrinkage(x);
        
    case 'QuEST'
        sigmahat = QuESTimate(x,0,[1e-5 40]);
        
    case 'NONE'
        sigmahat = cov(x);
end









end
