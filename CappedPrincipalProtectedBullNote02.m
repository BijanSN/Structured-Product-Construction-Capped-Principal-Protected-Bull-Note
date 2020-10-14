clear all, close all,clc

load ACWIIMIIMILargeMidSmallCap.mat
load CAUSPrivateEquity_desmoothed.mat
load date.mat 

%% Payoff structure
S0=100; % composé de 2 underlyings
gamma=2; %initial guess of a higher participation rate than 1:1
Cap=0.5; % max returns = 50%
F=0;% influe le floor
N=1000;

ST=50:.1:200;
 
Payoff=N*(1+max(min(gamma*((ST-S0)/S0),Cap),F));
Payoff_2= N+N*(gamma*((ST-S0)/S0)+max(F-gamma*((ST-S0)/S0),0)-max(gamma*((ST-S0)/S0)-Cap,0));% decomposed as underlying + black&scholes options
%same payoff = same price, otherwise there is arbitrage opportunities (If no frictions)
figure
plot(ST,Payoff,'r')
hold on
% plot(ST,Payoff_2,'r')


set(gca, 'FontSize', 18)
grid on
hold on
plot (ST,N*(1+(ST-S0)/S0),'b')
%legend('INSTALT','Underlying')

% this ST is the compositon of assets, one listed, one non-listed.
%let's simulate it, but first we define useful variables :


%% Montecarlo simulations of the underlying,
clc, close all
mat=40;
T = 1e3;                 % Number of time steps.                   %1e4 !
dt = mat/T;              % Time increment

A_rf=.05;                 % annual risk free 
Rf = (1 +A_rf)^(1/4)- 1  % quaterlly risk free asset returns

mat = 40;                  % Time to maturity: 10 ans = 40 quarters
N=1000;                   % Face value of the zero coupon bond

%drift ( under P)
u1=mean(Listed)
u2=mean(Non_Listed)
% vol
s1=std(Listed)
s2=std(Non_Listed)

% assumption : initial price s1  = 100, s2=250
S1_0=100;
S2_0=250;
SE1 = zeros(T,mat); 
SE1(:,1) = S1_0;
SE2(:,1) = S2_0;

theta1=  (u1-Rf)/s1 % market price of risk of dBt1(traded)
% assumption on theta 2 (exposition on on private assets) : double theta 1

% theta2=  (u2-rf)/s2 on peut pas ! => assumptions required. more pricy to
% hedge/speculate that the market one :  more!
theta2=theta1*2;
theta=[theta1 theta2];

%exposition to brownian motions depending on the underlyings :
COV=cov(Listed, Non_Listed)

s11=s1;                      % exposition of St1 to Bm1
s12=0;                       % exposition of St1 to Bm2 : no exposition on "non marketed assets" dBt2)
s21=(COV(1,2))/s11;          % exposition of St2 to Bm1 : yes ! Affected by market factors
s22=sqrt(s11^2-s21^2);       % exposition of St2 to Bm2 

N = 100; % number of simulations                                                 %Nt=10000! ;

St1 = zeros(N,T);
St2 = zeros(N,T);

St1(:,1)=S1_0;
St2(:,1)=S2_0;

dBt1_a = randn(N,T);
dBt2_a = randn(N,T);
dBt3_a = zeros(N,T);

for n=1:N % 1000 simulations/paths
    for t=2:T 
        St1(n,t)=St1(n,t-1)+St1(n,t-1)*((u1- [s11 s12]*[theta1 theta2]')*dt + s11*sqrt(dt)*dBt1_a(n,t-1)+s12*sqrt(dt)*dBt2_a(n,t-1));
        St2(n,t)= St2(n,t-1)+St2(n,t-1)*((u2-s21*theta1-s22*theta2)*dt+ s21*sqrt(dt)*dBt1_a(n,t-1) + s22*sqrt(dt)*dBt2_a(n,t-1)); % s2 affected by the market as well
    
        %MST1(n,t)=(St1(n,t)-St1(n,t-1))/St1(n,t-1)
    end
    
   % TR_St1(n)= (St1(n,end)-St1(n,1))/St1(n,1)
   % TR_St2(n)= (St2(n,end)-St2(n,1))/St2(n,1)

end
% Sigma= cov(mean(St1(:,2:end)-St1(:,1:end-1))/St1(:,1:end-1),mean(St2(:,2:end)-St2(:,1:end-1))/St2(:,1:end-1))
% weights_MSR=(inv(Sigma)*MarketReturns)./(A*inv(Sigma)*MarketReturns)
% ...

Port=0.5*St1+0.5*St2; % each line is a different path. the colomns are the time frame
figure
plot(Port')
title('Portfolio')

B1=60;% Knock-out Barrier S1
PB1=B1*ones(1,T);
B2=160;% Knock-out Barrier S2
PB2=B2*ones(1,T);

figure
plot([1:T],St1')
hold on 
plot([1:T], PB1,'k--','LineWidth',2)
title('Listed Asset')

figure
plot([1:T],St2')
hold on 
plot([1:T], PB2,'k--','LineWidth',2)
title('Non-Listed Asset')

%% Real payoff with 2 barriers
N=1000;
Rf=0.05;
gamma=1.25;
for i=1:100 
   Returns_Pf(i)=(Port(i,end)-(Port(i,1)))/(Port(i,1));
   if (min(St1(i,:))<B1)
       payoff2(i)=N;
   elseif (min(St2(i,:))<B2)
       payoff2(i)=N;
   else
       payoff2(i)=N*(1+max(min(gamma*Returns_Pf(i),Cap),F));%bewteen 1000 et 1500
       Discounted_Payoff2(i)=exp(-Rf*mat)*payoff2(i)
   end
end
figure
plot(payoff2,'rx') % at maturity. too high gamma or gap (floor,cap)  too low, because too few in between observations.

Price1= mean(exp(-Rf*mat)*payoff2) %AVERAGE discounted PAYOFF =price : 859
Discounted_Bond= exp(-Rf*mat)*1000; %~670
%Intuitively, you pay ~200USD more to get between potentially 0 to 500 USD more. Seems
%fair ex ante.

%If we were not to use the barriers, it would cost more ! 
N=1000;
gamma=1.25;
for i=1:100 
       payoff3(i)=N*(1+max(min(gamma*Returns_Pf(i),Cap),F));%bewteen 1000 et 1500
       Discounted_Payoff3(i)=exp(-Rf*mat)*payoff2(i)
end
Price2= mean(exp(-Rf*mat)*payoff3) %873 : higher than before!

% Plot how port changes wrt to St1 & st2. Multiples slopes: reconstruct the curve (3d) 

% for i=1:100 % time . use 1000 after
%        St1(i)=N*(1+max(min(gamma*Returns_Pf(i),Cap),F));
%        Discounted_Payoff3(i)=exp(-Rf*mat)*payoff3(i
% end
%% 
N=1000;% #simulations 
z=randn(N,2) %matrix of BM  => faster
T=40;
r=.05;
for i=2:1000
    E_PF(i)=mean(Port(:,i));
    RET_PF(i)=(E_PF(i)-E_PF(i-1))/E_PF(i-1)
end
E_RET_PF=(E_PF(end)-E_PF(2))/E_PF(2) %expected total returns on the portfolio
vv=std(RET_PF(3:end)) % volatility of the underlying

figure
plot(Port')
hold on 
plot(E_PF(2:end),'k-','linewidth', 4)
title('Portfolio')
%% Delta hedging
NRepl=10000;
F=0;
% Deltas= exp(-r*mat).*(exp(mu + s11*rand(1000,1))).*(P0*exp(mu + s11*rand(1000,1))>K1)
for i=1:length(S0)
    for j=1:length(T)
        nuT = (r - 0.5*vv^2)*dt;
        siT = vv*sqrt(dt);
        X = exp(nuT+siT*randn(NRepl,1));
        delta= normfit(exp(-r*T) .* X .* (S0*X > F))
    end
end
% we need to hold 0.1356 of the portfolio & 0.86644 into the bonds
%% Analytical Pricing
%Long underlying + BS long put K1 + BS short call K2
%S0   = gamma*E_RET_PF                    % Gamma*(ST-S0)/S0 une seule valeur , l'expected
F=0.1;
Cap=0.75;
S0   = gamma*E_RET_PF              % Gamma*average return pf 
K1   = F;                          % Strike price put = Floor
K2   = Cap;                        % Strike price call =Cap ( K2>K1)
Rf   = 0.005;                      % Quaterly risk free rate ( *sqrt(4) to transform into annualised risk free) 1% annualised = 0.5% quaterly
q   = 0.0;                         % Quaterly dividend yield =0%
mat = 40;                          % Time to maturity: 10 years = 40 quarters
N=1000;                            % Face value of the bond

%% long put K1
d1=(log(S0/K1)+(Rf+((vv^2)/2))*mat)/(vv*sqrt(mat)); 
d2=d1-vv*sqrt(mat); 
disp('Black and Scholes long Put Price') 
Price_long_Put_K1=K1*exp(-Rf*mat)*cdf('norm',-d2,0,1)-S0*cdf('norm',-d1,0,1); 
[c,p]=blsprice(S0,K1,Rf,mat,vv)% using matlab precompiled function for double-check : same !
%logique.

%Under BS, we can hedge by selling -N(-d1) shares of the underlying at
%price St, and Bt= (Vt-alpha*ST/Bt) of the risk free asset.
%% Short call K2
d1=(log(S0/K2)+(Rf+((vv^2)/2))*mat)/(vv*sqrt(mat)); 
d2=d1-vv*sqrt(mat); 
disp('Black and Scholes Call Price') 
Price_short_Call_K2=-(S0*cdf('norm',d1,0,1)-K2*exp(-Rf*mat)*cdf('norm',d2,0,1));

% Under Black& Scholes, the volatility is constant independantly of the
% value of K. By shorting, we collect the premium, hence the  "negative price"
[c]=-blsprice(S0,K2,Rf,mat,vv)
%blsdelta(c,K2,Rf,mat,vv)

%% Underlying (leveredged)
U=gamma*S0

%% Derivatives : sum of all 
U+Price_short_Call_K2 %0.8081
