function [PORTFOLIOreturns, weight] = PORTFOLIOconstruction(x, dates, rebalancing, window,  model, method, demean)
% function function PORTFOLIOreturns = portfolio(x, method, demean)
%
% Construction of portfolio returns using estimation of scalar DCC(1,1) multivariate volatility model with TGARCH(1,1)
% conditional variances (or shrinkage applied to the sample covariance matrix)
%
% INPUTS:
%   x            - A T by K matrix of returns
%   window       - number of observations used in rolling window
%   time         - value that determines how frequently portfolio is
%                  rebalanced. Choices are between daily, monthtly, yearly.
%                  default is daily.
%   dates        - A T by 1 datetime
%   method       - choose between modelfree, lineareig, QuEST (default is
%                  quEST)
%   model        - choose between SAMPLE, DCC, BEKK, DECO,
%   demean       - set to 1 if the data need to be demeaned first,
%                  and 0 otherwise (optional, default is 1)
% OUTPUTS:
%   PORTFOLIOreturns - returns of portfolio for provided sample period.
%
% COMMENTS:
%   The dynamics of the correlations in a 3-stage DCC model are:
%     Q(t) = R*(1-a-b) + a*e(t-1)'*e(t-1) + b*Q(t-1)
%

if nargin < 3
    rebalancing = 'daily';
    window = 100;
    model = 'SAMPLE';
    method = 'QuEST';
    demean = 1;
end

if nargin < 4
    window = 100;
    model = 'SAMPLE';
    method = 'QuEST';
    demean = 1;
end
if nargin < 5
    model = 'SAMPLE';
    method = 'QuEST';
    demean = 1;
end
if nargin < 6
    method = 'QuEST';
    demean = 1;
end
if nargin < 7
    demean = 1;
end


[T,k] = size(x);

% switch rebalancing cases

jota = ones(k,1);

switch rebalancing
    case 'daily'
        % compute out of sample returns for the entire sample period
        % excluding the first "window" observations
        weight = zeros(T-window,k);
        PORTFOLIOreturns = zeros(T-window,1);
        
        % determine which model to use
        switch model
            case 'SAMPLE'
                for i=1:T-window
                    % determine relevant returns
                    returns = x(i:i+window-1,:);
                    
                    % estimate dcc model with shrinkage for covariance matrix at
                    % time "window + 1"
                    covMat = sampleEst(returns, method, demean);
                    
                    % determine global minimum variance portfolio weight
                    weight(i,:) = ((covMat\jota) / (jota'/covMat*jota))';
                    PORTFOLIOreturns(i) = weight(i,:)*x(window+i,:)';
                end
                
            case 'DCC'
                for i=1:T-window
                    % determine relevant returns
                    returns = x(i:i+window-1,:);
                    
                    % estimate dcc model with shrinkage for covariance matrix at
                    % time "window + 1"
                    covMat = DCCcovEst(returns, method, demean);
                    
                    % determine global minimum variance portfolio weight
                    weight(i,:) = ((covMat\jota) / (jota'/covMat*jota))';
                    PORTFOLIOreturns(i) = weight(i,:)*x(window+i,:)';
                end
                
            case 'BEKK'
                for i=1:T-window
                    % determine relevant returns
                    returns = x(i:i+window-1,:);
                    
                    % estimate dcc model with shrinkage for covariance matrix at
                    % time window + 1
                    covMat = BEKKcovEst(returns, method, demean);
                    % MUST CREATE BEKKcovEST!!
                    
                    
                    % determine global minimum variance portfolio weight
                    weight(i,:) = ((covMat\jota) / (jota'/covMat*jota))';
                    PORTFOLIOreturns(i) = weight(i,:)*x(window+i,:)';
                end
                
            case 'DECO'
                for i=1:T-window
                    % determine relevant returns
                    returns = x(i:i+window-1,:);
                    
                    % estimate dcc model with shrinkage for covariance matrix at
                    % time window + 1
                    covMat = DECO(returns, method, demean);
                    % MUST CREATE BEKKcovEST!!
                    
                    
                    % determine global minimum variance portfolio weight
                    weight(i,:) = ((covMat\jota) / (jota'/covMat*jota))';
                    PORTFOLIOreturns(i) = weight(i,:)*x(window+i,:)';
                end
                
            case 'monthly'
                
                
                
            case 'yearly'
                
                
                
                
        end
        
end
end