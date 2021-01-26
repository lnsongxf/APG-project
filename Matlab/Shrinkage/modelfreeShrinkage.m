function ShrunkMatrix = modelfreeShrinkage(returns)
% returns is a TxN return matrix of T observations and N assets
    Mean = mean(returns(:,:))';
Covariance = cov(returns(:,:));
T = size(returns,1);


obsN = size(Covariance,1);
    %before computing any weights we compute the shrunk covariance matrix.
    r = zeros(size(Covariance));
    for k =1:size(Covariance,1)
        for l=1:size(Covariance,2)
        r(k,l) = Covariance(k,l)/ sqrt(Covariance(k,k)*Covariance(l,l));
        end
    end
sum1 = 0;
    for i=1:obsN-1
        for j=i+1:obsN
            sum1 = sum1 + r(i,j);         
        end
    end
r_bar = 2*sum1/((obsN-1)*obsN);


%Compute the shrinkage target matrix F
F = zeros(size(Covariance));
for i=1:obsN
    for j=1:obsN
        if i==j
            F(i,j) = Covariance(i,j);
        else
            F(i,j) = r_bar * sqrt(Covariance(i,i)*Covariance(j,j));
        end
    end
end

% We need an esimator for the shrinkage intensity delta in 
% Sigma = delta*F + (1- delta)*Covariance

% this is a shitload of effort and i will not comment
% any of it. just rely on the algebraic skills of ledoit and wolf.



% Compute the consistent estimators for pi, rho and gamma

% for pi:

pi = zeros(size(Covariance));
for i=1:obsN 
    for j=1:obsN
        %nested loops = efficient coding
        sum1 = 0;
        for t=1:T
            sum1 = sum1 +  (   (returns(t,i)-Mean(i)) *  (returns(t,j)-Mean(j)) - Covariance(i,j))^2;                  
        end
        pi(i,j) = sum1/T;   
    end 
end

pi_hat = sum(sum(pi));



% for rho:

%first compute the weird looking v in ledoit and wolf
% for v_{ii,ij} and  v_{jj,ij}
v_i = zeros(size(Covariance));
v_j = zeros(size(Covariance));

for i=1:obsN
    for j=1:obsN
        sum_i = 0;
        sum_j = 0;
        for t=1:T
            sum_i = sum_i +     ((returns(t,i)-Mean(i))^2 - Covariance(i,i))   *   ( (returns(t,i)-Mean(i))*(returns(t,j)-Mean(j))-Covariance(i,j));
            sum_j = sum_j +     ((returns(t,j)-Mean(j))^2 - Covariance(j,j))   *   ( (returns(t,j)-Mean(j))*(returns(t,i)-Mean(i))-Covariance(j,i));
        end
        v_i(i,j) = sum_i/T;
        v_j(i,j) = sum_j/T;
    end
end


%Collecting terms now yields us an estimator for rho

sum1 = 0;
sum2 = 0;
for i=1:obsN
   sum1 = sum1 + pi(i,i);
    
    
    for j=1:obsN
           if j~=i
               sum2 = sum2 + r_bar/2 * (   sqrt(Covariance(j,j)/Covariance(i,i))*v_i(i,j) + sqrt(Covariance(i,i)/Covariance(j,j))*v_j(i,j));
           end
    end
end
rho = sum1 + sum2; 


%The consistent estimator for gamma is easy:
sum1 = 0;
for i=1:obsN
    for j=1:obsN
        sum1 = sum1 + (F(i,j)-Covariance(i,j))^2;
    end
end
gamma = sum1;

%This gives us an estimator for kappa

kappa = (pi_hat - rho)/gamma;

%Finally the shrinkage intensity is given by 

delta = max(0, min(kappa/T,1));
%in principle it can happen that kappa/T < 1 hence the max function to
%truncate it.

%Finally the shrinkage matrix is given by 

ShrunkMatrix = delta*F + (1-delta)*Covariance;








