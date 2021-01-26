ReadData
% returns (5278x28)
% prices (5278x28)
% names (1x28)
% dates (5278x1)

% demean returns (important)
Y = returns;
[n,p]=size(Y);
   Y=Y-repmat(mean(Y),[n 1]);


Mdl = garch(1,1);
volatilities = zeros(size(Y));
for i=1:size(Y,2)
EstMdl = estimate(Mdl,Y(:,i),'Display','off');
volatilities(:,i) = infer(EstMdl,Y(:,i));
end



%% Cluster the assets by volatilities
k=6;
idx = kmeans(volatilities',k); %appears to be the most sensible
idx2 = clusterdata(volatilities','MaxClust',k);
idx3 = kmedoids(volatilities',k);

