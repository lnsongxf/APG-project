function [sigma,shrinkage]=linearShrinkage(x)
% x is a TxN return matrix of T observations and N assets


% Copyright (c) 2014, Olivier Ledoit and Michael Wolf 
% All rights reserved.

% de-mean returns
[t,n]=size(x);
meanx=mean(x);
x=x-meanx(ones(t,1),:);

% compute sample covariance matrix
sample=(1/t).*(x'*x);

% sample = cov(x);  using matlabs covariance estimator yields different
% results

% compute prior
meanvar=mean(diag(sample));
prior=meanvar*eye(n);

  % This would be beta^2
  y=x.^2;
  betaMat=y'*y/t-sample.^2;
  beta=sum(sum(betaMat));
  
  % what we call r is not needed for this shrinkage target
  
  % this would be delta^2
  delta=norm(sample-prior,'fro')^2;

  % compute shrinkage constant rho
  rho=beta/delta;
  % truncate the shrinkage intensity between 0 and 1.
  shrinkage=max(0,min(1,rho/t));
    
% compute shrinkage estimator
sigma=shrinkage*prior+(1-shrinkage)*sample;


