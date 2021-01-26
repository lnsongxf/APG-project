ReadData

%Define 4 clusters
% -agriculture: Wheat (1), Sugar (3), Soybeans (4), Orange Juice (7), kansas wheat (13), coffee arabica (14),  Cotton (25) ,cocoa (27), corn (28) 

% -Livestock and meat: Lean Hogs (9), live cattle (12), feeder cattle (24)

% -metals: Silver (2), Platinum (6), Zinc (15), Tin (16), Nickel (17), Lead (18), Copper London (19), Copper
% High grade (20), Aluminium (21), Gold (23)

%Energy: Gasoline (5), Natural Gas (8), Gasoil (10), Crude Oil Brent (11), Heating Oil (22), Crude
%Oil WTI (26).


%% Rearrange the return matrix to display the commodities in order of agriculture, livestock, metals, energy

returns = returns(:, [1 3 4 7 13 14 25 27 28 9 12 24 2 6 15 16 17 18 19 20 21 23 5 8 10 11 22 26]);
names = names([1 3 4 7 13 14 25 27 28 9 12 24 2 6 15 16 17 18 19 20 21 23 5 8 10 11 22 26]);

% The Blocks are commodities: (1-9, 10-12, 13-22, 23-28)
