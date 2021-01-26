%% Read Data
returns = csvread('returns.csv',0,0,'C2..AD5279');
returns(1,:) = [];
returns(:,1) = [];

datetimes = readtable('dates.xlsx');
names = readtable('names.xlsx');
names = table2cell(names);

datetimes = table2cell(datetimes);
dates = [datetimes{:}]';

%% Compute commodity prices
filler = ones(1,size(returns,2));
prices = zeros(size(returns,1),size(returns,2));
for i=1:size(returns,1)
    if i==1
    prices(i,:) = filler.*(1+returns(i,:));
    else
    prices(i,:) = prices(i-1,:).*(1+returns(i,:));    
    end
    
end
%% Plot return series

for i=1:size(returns,2)
   figure
   hold on
   plot(dates,returns(:,i));
   title(names{i} + " return") 
   xlim([datetime('1-Dec-2016'), datetime('1-Dec-2018')])
   
   hold off
end

%% plot individual return series of (id)
   id = 1;
   figure
   hold on
   plot(dates,returns(:,id));
   title(names{id} + " returns") 
   xlim([datetime('1-Dec-2000'), datetime('1-Dec-2020')])
   hold off


%% Plot price series
for i=1:size(prices,2)
   figure
   hold on
   plot(dates,prices(:,i));
   title(names{i} + " price") 
   xlim([datetime('1-Dec-2016'), datetime('1-Dec-2017')])
   
   hold off
end

%% plot individual price series of (id)
   id = 26;
   figure
   hold on
   plot(dates,prices(:,id));
   title(names{id} + " price") 
   xlim([datetime('1-Dec-2000'), datetime('1-Dec-2020')])
   hold off







%% Compute sample correlation/covariance matrix

SampleCovariance = cov(returns);
SampleCorrelation = corrcov(SampleCovariance);

%%
n = 1;

SampleCovariance = cov(returns(n:n+250,:));
SampleCorrelation = corrcov(SampleCovariance);
