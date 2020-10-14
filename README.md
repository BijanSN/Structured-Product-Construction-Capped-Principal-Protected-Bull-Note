# Structured Product Construction. INSTALT: A Capped Principal-Protected Bull Note

## Work in progress

2 main files :
* **PreProcessing01.m** : Pre-processing the different datasets
* **CappedPrincipalProtectedBullNote02.m** : Main file. Prices a home-made structued product: the capped principal-protected bull note through monte-carlo simulations.


# PRODUCT DESCRIPTION & TARGETED CLIENTELE
Financial structured as an equity-linked derivative, this capped principal-protected bull note provides an exposition on a particular risk factor, relative to non-listed assets. This particular structured product is defined to target retail, non-professional investors trying to diversify their portfolio with uncorrelated assets. Indeed, the potential investor will benefit from an exposure on a particular alternative market, usually being very restrictive due to entry, liquidity and performance costs, which will help diversify his own portfolio. Additionally, this derivative provides exposure on a marketed security to provide an already diversified portfolio in case this particular product is his only security.


INSTALT provides a packaged solution to multiple problems a particular retail investor may face such as:
* A lack of knowledge on how to correctly protect their portfolio, as they are often long-only with unlimited potential loss.
* Cognitive biases; deviations from rationality or logic, mostly due to emotional attachment to a particular position, leading to misjudgement.
* Limited/ non-existent access to non-traded assets such as private equity, thus yielding a potentially lower efficient frontier.


Indeed, INSTALT provides, in a single product, an exposure meeting the needs of the markets investors; a positive, protected, exposure on exotic asset class through the construction of a portfolio of different assets, while being professionally managed in a systematic way, with a guaranteed principal. This capped principal protected bull note guarantees a minimum return equal to the investor’s initial investment, regardless of the underlying’s performance at the redemption date. More intuitively, if the structured product is held until maturity, the investor will get the notional amount N and a potential performance depending on how the underlying, the portfolio, performed. Additionally, 2 knock-out barriers will be placed. 



# PAYOFF STRUCTURE & UNDERLINGS 
Being an Equity-linked note, INSTALT’s payoff depends on the several factors, such as the value of a bond, as well as the value of the underlying asset; the portfolio exposed to the alternative market. The bond comes from a hypothetical zero coupon with a face value of 1000 with no interest payments. The portfolio is composed of 2 assets; a US index on Private Equity (non traded) and the world total returns index including all capitalisations; low+mid+large (traded). These are quarterly data from Q1 1999 to Q1 2017. Since indices from the private equity sector suffers from an anchoring bias. This bias occurs when a large proportion of the valuation at time t comes from time t-1. A robust desmoothing method is therefore applied in order to reveal the real risk/returns trade off behind the previous smoothed time series. This investment strategy provides a capital protection at a pre-determined floor level, as well as capped returns. The rationale for constructing such cap level is to mitigate the drawbacks of the loss of participation rate of principal protected notes. 


![alt text](https://github.com/BijanSN/Structured-Product-Construction-Capped-Principal-Protected-Bull-Note/blob/main/Figures/payoff.png)


In order to increase attractiveness on the product, several barriers were implemented such the price is more aligned with the investors’ views on this particular market. Indeed, by restricting the potential gains, the investor gains from reducing the price of the structured product. Such events do not follow the investor’s opinion on this market and therefore do not want to pay for it. Knock-out barriers on the underlyings of the portfolio are placed at an appropriate level, at respectively 60 and 64% of the initial value, reducing the probability of being in-the-money, lowering the structured product’s price.
Alternatively, by decomposing the portfolio returns, we can plug additional constraints, leading to this following general equation:

![alt text](https://github.com/BijanSN/Structured-Product-Construction-Capped-Principal-Protected-Bull-Note/blob/main/Figures/Equation.PNG)
Where S1_i and ST_i stands for the asset price of i=(1,2) at ,respectively, inception and maturity. B1 is the knock-out barrier associated to St1 and B2 the knock-out barrier associated to St2.


# MODELLING ASSUMPTIONS
For the computation of the price of the structured product, the following assumptions were used. Some are very restrictive, limiting the correct replication of the price.

* The portfolio is rebalanced at no cost such that the weights associated to each stock is 0.5 at all-time to simplify calculations.
* The riskless rate Rf is assumed fixed through time.
* The index given on the datasheet can be replicated at perfection, as if there were funds.
* There are no dividends.
* There is no borrowing or lending constraints.
* There are no transaction costs.
* The two underlyings behind the portfolio follows a geometric Brownian motion with a constant drift and volatility. The dynamics are given below : 

![alt text](https://github.com/BijanSN/Structured-Product-Construction-Capped-Principal-Protected-Bull-Note/blob/main/Figures/Geometric_brownian_motions.PNG)


# PRICING

We can therefore apply Monte Carlo to simulate multiples paths of the two indices to create portfolios.

![alt text](https://github.com/BijanSN/Structured-Product-Construction-Capped-Principal-Protected-Bull-Note/blob/main/Figures/pf.png)
![alt text](https://github.com/BijanSN/Structured-Product-Construction-Capped-Principal-Protected-Bull-Note/blob/main/Figures/PFE.png)


The price of the product is given by the present value of the nominal face value of the bond, discounted at the inception’s date, as well as the expected present value of the underlying asset: the black line, as defined in the first section.
Using fixed parameters, for N, Cap, Floor among others, the price of this derivative product is 859 USD. This seems coherent as the present value of the bond is 670. We will therefore pay a premium of ~200 USD for a potential 0 to 500 USD increase.






Coherent with our intuition, removing the barriers increases slightly the price of the derivative, to 873 USD.
