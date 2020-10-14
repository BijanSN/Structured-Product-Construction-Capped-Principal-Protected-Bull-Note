# Structured Product Construction:  A Capped Principal-Protected Bull Note

## Work in progress

2 main files :
* **PreProcessing01.m** : Pre-processing the different datasets
* **CappedPrincipalProtectedBullNote02.m** : S


# PRODUCT DESCRIPTION & TARGETED CLIENTELE
Financial structured as an equity-linked derivative, this capped principal-protected bull note provides an exposition on a particular risk factor, relative to non-listed assets. This particular structured product is defined to target retail, non-professional investors trying to diversify their portfolio with uncorrelated assets. Indeed, the potential investor will benefit from an exposure on a particular alternative market, usually being very restrictive due to entry, liquidity and performance costs, which will help diversify his own portfolio. Additionally, this derivative provides exposure on a marketed security to provide an already diversified portfolio in case this particular product is his only security.


INSTALT provides a packaged solution to multiple problems a particular retail investor may face such as:
* 1.	A lack of knowledge on how to correctly protect their portfolio, as they are often long-only with unlimited potential loss.
* 2.	Cognitive biases; deviations from rationality or logic, mostly due to emotional attachment to a particular position, leading to misjudgement.
* 3.	Limited/ non-existent access to non-traded assets such as private equity, thus yielding a potentially lower efficient frontier.


Indeed, INSTALT provides, in a single product, an exposure meeting the needs of the markets investors; a positive, protected, exposure on exotic asset class through the construction of a portfolio of different assets, while being professionally managed in a systematic way, with a guaranteed principal. This capped principal protected bull note guarantees a minimum return equal to the investor’s initial investment, regardless of the underlying’s performance at the redemption date. More intuitively, if the structured product is held until maturity, the investor will get the notional amount N and a potential performance depending on how the underlying, the portfolio, performed. Additionally, 2 knock-out barriers will be placed. 


# PAYOFF STRUCTURE & UNDERLINGS 
Being an Equity-linked note, INSTALT’s payoff depends on the several factors, such as the value of a bond, as well as the value of the underlying asset; the portfolio exposed to the alternative market. The bond comes from a hypothetical zero coupon with a face value of 1000 with no interest payments. The portfolio is composed of 2 assets; a US index on Private Equity (non traded) and the world total returns index including all capitalisations; low+mid+large (traded). These are quarterly data from Q1 1999 to Q1 2017. Since indices from the private equity sector suffers from an anchoring bias. This bias occurs when a large proportion of the valuation at time t comes from time t-1. A robust desmoothing method is therefore applied in order to reveal the real risk/returns trade off behind the previous smoothed time series. This investment strategy provides a capital protection at a pre-determined floor level, as well as capped returns. The rationale for constructing such cap level is to mitigate the drawbacks of the loss of participation rate of principal protected notes. 


In order to increase attractiveness on the product, several barriers were implemented such the price is more aligned with the investors’ views on this particular market. Indeed, by restricting the potential gains, the investor gains from reducing the price of the structured product. Such events do not follow the investor’s opinion on this market and therefore do not want to pay for it. Knock-out barriers on the underlyings of the portfolio are placed at an appropriate level, at respectively 60 and 64% of the initial value, reducing the probability of being in-the-money, lowering the structured product’s price.
Alternatively, by decomposing the portfolio returns, we can plug additional constraints, leading to this following general equation:










