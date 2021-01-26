%% Read Data
returns = csvread('returns.csv',0,0,'B2..AB5178');
returns(1,:) = [];
returns(:,1) = [];

datetimes = readtable('dates.csv');
names = readtable('names.csv');
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