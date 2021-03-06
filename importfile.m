function [date1,currency,ACWIIMIIMILargeMidSmallCap,CAGlobalBuyoutGrowthEquity_desmoothed,CAGlobalBuyoutGrowthEquity_smoothed,CARealEstate_desmoothed,CARealEstate_smoothed,CAUSPrivateEquity_desmoothed,CAUSPrivateEquity_smoothed,CAUSVenture_desmoothed,CAUSVenture_smoothed,EUR3monthLIBORreturn,PreqinInfrastructure_desmoothed,PreqinInfrastructure_smoothed,US3monthTbillreturn,WorldBigExMBSHedged,WorldBigExMBSUnhedged] = importfile(workbookFile,sheetName,startRow,endRow)
%IMPORTFILE Import data from a spreadsheet
%   [date1,currency,ACWIIMIIMILargeMidSmallCap,CAGlobalBuyoutGrowthEquity_desmoothed,CAGlobalBuyoutGrowthEquity_smoothed,CARealEstate_desmoothed,CARealEstate_smoothed,CAUSPrivateEquity_desmoothed,CAUSPrivateEquity_smoothed,CAUSVenture_desmoothed,CAUSVenture_smoothed,EUR3monthLIBORreturn,PreqinInfrastructure_desmoothed,PreqinInfrastructure_smoothed,US3monthTbillreturn,WorldBigExMBSHedged,WorldBigExMBSUnhedged]
%   = IMPORTFILE(FILE) reads data from the first worksheet in the Microsoft
%   Excel spreadsheet file named FILE and returns the data as column
%   vectors.
%
%   [date1,currency,ACWIIMIIMILargeMidSmallCap,CAGlobalBuyoutGrowthEquity_desmoothed,CAGlobalBuyoutGrowthEquity_smoothed,CARealEstate_desmoothed,CARealEstate_smoothed,CAUSPrivateEquity_desmoothed,CAUSPrivateEquity_smoothed,CAUSVenture_desmoothed,CAUSVenture_smoothed,EUR3monthLIBORreturn,PreqinInfrastructure_desmoothed,PreqinInfrastructure_smoothed,US3monthTbillreturn,WorldBigExMBSHedged,WorldBigExMBSUnhedged]
%   = IMPORTFILE(FILE,SHEET) reads from the specified worksheet.
%
%   [date1,currency,ACWIIMIIMILargeMidSmallCap,CAGlobalBuyoutGrowthEquity_desmoothed,CAGlobalBuyoutGrowthEquity_smoothed,CARealEstate_desmoothed,CARealEstate_smoothed,CAUSPrivateEquity_desmoothed,CAUSPrivateEquity_smoothed,CAUSVenture_desmoothed,CAUSVenture_smoothed,EUR3monthLIBORreturn,PreqinInfrastructure_desmoothed,PreqinInfrastructure_smoothed,US3monthTbillreturn,WorldBigExMBSHedged,WorldBigExMBSUnhedged]
%   = IMPORTFILE(FILE,SHEET,STARTROW,ENDROW) reads from the specified
%   worksheet for the specified row interval(s). Specify STARTROW and
%   ENDROW as a pair of scalars or vectors of matching size for
%   dis-contiguous row intervals. To read to the end of the file specify an
%   ENDROW of inf.
%
%	Non-numeric cells are replaced with: NaN
%
% Example:
%   [date1,currency,ACWIIMIIMILargeMidSmallCap,CAGlobalBuyoutGrowthEquity_desmoothed,CAGlobalBuyoutGrowthEquity_smoothed,CARealEstate_desmoothed,CARealEstate_smoothed,CAUSPrivateEquity_desmoothed,CAUSPrivateEquity_smoothed,CAUSVenture_desmoothed,CAUSVenture_smoothed,EUR3monthLIBORreturn,PreqinInfrastructure_desmoothed,PreqinInfrastructure_smoothed,US3monthTbillreturn,WorldBigExMBSHedged,WorldBigExMBSUnhedged] = importfile('data_ RE-PE-Infr.xlsx','Feuil1',2,78);
%
%   See also XLSREAD.

% Auto-generated by MATLAB on 2019/05/28 15:23:14

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 3
    startRow = 2;
    endRow = 78;
end

%% Import the data, extracting spreadsheet dates in Excel serial date format
[~, ~, raw, dates] = xlsread(workbookFile, sheetName, sprintf('A%d:Q%d',startRow(1),endRow(1)),'' , @convertSpreadsheetExcelDates);
for block=2:length(startRow)
    [~, ~, tmpRawBlock,tmpDateNumBlock] = xlsread(workbookFile, sheetName, sprintf('A%d:Q%d',startRow(block),endRow(block)),'' , @convertSpreadsheetExcelDates);
    raw = [raw;tmpRawBlock]; %#ok<AGROW>
    dates = [dates;tmpDateNumBlock]; %#ok<AGROW>
end
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
stringVectors = string(raw(:,[2,13,14,15]));
stringVectors(ismissing(stringVectors)) = '';
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,16,17]);
dates = dates(:,1);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),dates); % Find non-numeric cells
dates(R) = {NaN}; % Replace non-numeric Excel dates with NaN

%% Create output variable
I = cellfun(@(x) ischar(x), raw);
raw(I) = {NaN};
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
dates(~cellfun(@(x) isnumeric(x) || islogical(x), dates)) = {NaN};
date1 = datetime([dates{:,1}].', 'ConvertFrom', 'Excel');
currency = categorical(stringVectors(:,1));
ACWIIMIIMILargeMidSmallCap = data(:,1);
CAGlobalBuyoutGrowthEquity_desmoothed = data(:,2);
CAGlobalBuyoutGrowthEquity_smoothed = data(:,3);
CARealEstate_desmoothed = data(:,4);
CARealEstate_smoothed = data(:,5);
CAUSPrivateEquity_desmoothed = data(:,6);
CAUSPrivateEquity_smoothed = data(:,7);
CAUSVenture_desmoothed = data(:,8);
CAUSVenture_smoothed = data(:,9);
EUR3monthLIBORreturn = data(:,10);
PreqinInfrastructure_desmoothed = categorical(stringVectors(:,2));
PreqinInfrastructure_smoothed = categorical(stringVectors(:,3));
US3monthTbillreturn = categorical(stringVectors(:,4));
WorldBigExMBSHedged = data(:,11);
WorldBigExMBSUnhedged = data(:,12);

% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% date1=datenum(date1);

