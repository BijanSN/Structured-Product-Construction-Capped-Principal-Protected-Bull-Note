%% Loading & pre-processing Data 
clear all, close all,clc

rng default
% load the dataset
[date,currency,ACWIIMIIMILargeMidSmallCap,CAGlobalBuyoutGrowthEquity_desmoothed,CAGlobalBuyoutGrowthEquity_smoothed,CARealEstate_desmoothed,CARealEstate_smoothed,CAUSPrivateEquity_desmoothed,CAUSPrivateEquity_smoothed,CAUSVenture_desmoothed,CAUSVenture_smoothed,EUR3monthLIBORreturn,PreqinInfrastructure_desmoothed,PreqinInfrastructure_smoothed,US3monthTbillreturn,WorldBigExMBSHedged,WorldBigExMBSUnhedged] = importfile('data_ RE-PE-Infr.xlsx','Feuil1',2,78);
Listed=ACWIIMIIMILargeMidSmallCap(1:end-4);
Non_Listed=CAUSPrivateEquity_desmoothed(1:end-4);
date=date(1:end-4);

date= datetime(date,'InputFormat','MM-yyyy');
date.Format='QQQQ-yyyy';

% Our data : (only returns)
head = table(date, Listed, Non_Listed)

save ACWIIMIIMILargeMidSmallCap.mat
save CAUSPrivateEquity_desmoothed.mat
save date.mat

