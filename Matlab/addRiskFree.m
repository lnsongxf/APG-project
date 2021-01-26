function [riskfreeReturns, returns, overlappingDates] = addRiskFree(data, dates, riskfreeRates, riskfreeDates )
% function [riskfreeReturns, returns, overlappingDates] = addRiskFree(data, dates, riskfreeDates)
% removes observations between riskfree rates and returns that dont
% overlap.

% INPUTS
% data              - A T by K matrix of returns
% dates             - A T by 1 datetime 
% riskfreeRates     - A P by 1 matrix of risk free rates
% riskfreeDates     - A P by 1 datetime
%
%
%





% here we return a series of returns - the riskfree rate

intsectRf = datenum(riskfreeDates);
intsectData = datenum(dates);

% C = A(ia) and C = B(ib).
[C,ia,ib] = intersect(intsectRf,intsectData);

overlappingDates = datetime(intsectRf(ia), 'ConvertFrom', 'datenum');
overlappingDates = datetime(overlappingDates, 'Format', 'yyyy/MM/dd');

riskfreeReturns = data(ib,:) - riskfreeRates(ia)*ones(1,size(data,2))/100;
returns = data(ib,:);
end