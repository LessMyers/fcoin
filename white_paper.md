## Project Introduction
- Fund Coin (FC) is an innovative cryptocurrency designed around the concept of "endogenous growth and sustained appreciation". FC achieves automatic value accumulation through its built-in transaction fee mechanism, and cooperates with the exchange to achieve sustained value growth. Its goal is to build a sustainable, community driven asset appreciation system.

## Vision and mission
#### Vision
- Create a token with a genuine intrinsic value growth mechanism to consistently enhance user asset value over the long term. FC hopes to become an important value carrier and innovative financial tool for global users in the digital economy era, following gold and Bitcoin, leading the new paradigm of digital assets.
#### mission
- By using a fee driven value accumulation mechanism, we break the traditional model of relying on funds to drive down projects and achieve autonomous price increases. We are committed to promoting a new era of digital assets that are truly driven by mechanisms, value accumulation, and community consensus.

## Core mechanism
- The price of FC is equal to the ratio of the quantity of USDT in the contract to the total quantity of FC issued.
- Due to transaction fees, the proportion of issuance (corresponding to buying behavior) and destruction (corresponding to selling behavior) continues to rise, resulting in a sustained increase in prices.
- If the handling fee is 0, then FC is the equivalent of USDT.

#### FC issuance
- fee: commission
- totalSupply: Total issuance of FC
- pool_usdt: The quantity of USDT in the contract
- fc: Quantity of FC obtained from additional issuance
- usdt: Quantity of USDT issued for issuance
- Additional issue price:  
$ \text{price} = \left( \frac{\text{pool\_usdt}}{\text{totalSupply}} \right) \times (1 + \text{fee}) $
- Number of additional issuances:
$
\text{fc} = \text{totalSupply} \times \left( \left( \frac{\text{pool\_usdt} + \text{usdt}}{\text{pool\_usdt}} \right)^{1 - fee} - 1 \right)
$
#### FC Destruction
- fee: commission
- totalSupply: Total issuance of FC
- pool_usdt: The quantity of USDT in the contract
- fc: Number of FC destroyed
- usdt: The quantity of USDT obtained through destruction
- Destruction price:
$ \text{price} = \left( \frac{\text{pool\_usdt}}{\text{totalSupply}} \right) \times (1 - \text{fee}) $
- Destruction quantity:
$
\text{usdt} = \text{pool\_usdt} \times \left( 1 - \left( \frac{\text{totalSupply} - \text{fc}}{\text{totalSupply}} \right)^{1 - fee} \right)
$

#### Market Value Management
- Upon listing on centralized exchanges, the market price of the FC token is expected to fluctuate within a defined range, bounded by the on-chain minting price and burning price. When the exchange price significantly exceeds the on-chain minting threshold, arbitrageurs are economically incentivized to mint new FC tokens on-chain and sell them on the exchange. This process facilitates capital inflow into the protocol and results in an upward adjustment of the base price. Conversely, when the exchange price falls below the on-chain burning price, arbitrageurs are likely to repurchase FC tokens from the market and burn them to capture arbitrage profits. This reduces circulating supply and likewise contributes to a rise in the base price.

- This mechanism leverages spontaneous market dynamics and incentivized arbitrage to establish a self-reinforcing feedback loop. Through this game-theoretic design, FC creates a price structure that promotes long-term value accumulation, supply reduction under downward pressure, and resistance to deflationary risks — forming the foundation of a sustainable token economy.

- The project team dynamically adjusts transaction fees to flexibly regulate the ranges of minting and burning prices. This enables effective management of market capitalization and strategic guidance of price movements. By doing so, the protocol provides a structured foundation for the steady appreciation of the token, enhancing the controllability and sustainability of its long-term value trajectory.


## Token Model
project | describe
:----:| :-----: 
Token Name | Fund Coin  
Token symbol | FC 
Initial issuance volume | 1111K 
Initial price | 0.007 
Scope of handling fees | 0%~50% 
Total Circulation | Market decision 

## road map
Time node |  target 
:----:| :-----: 
2025-04 | Complete the contract and issue it  
2025-05~2025-06 | Complete the white paper, official website 
2025-06~2025-08 | Effective address of tens of thousands
2025-09~2025-12 | Plan to get listed on Gate.io or MEXC
2026-01~2026-12 | Become the star token of the exchange
2027-01~2027-12 | List on Binance and other top-tier exchanges
2028-01~2028-12 | Generating global influence, DAO governance

## Governance and Community
- The FC project will introduce DAO governance mechanism in the future.
- Community members can vote on proposals: 
    - Adjustment of handling fees.
    - Direction of Community Fund Use.
    - Introduction and removal of cooperative projects.
- All governance records are on chain to ensure transparency and openness.

## Safety and Compliance
- Smart contracts will undergo comprehensive audits by third-party auditing agencies.
- The project complies with the regulations of its jurisdiction and avoids regulatory risks.
- Open team or multi signature control to enhance community trust.

## Risk statement
- Investing in encrypted assets involves high volatility and risk. Although FC has designed a value growth mechanism, investors still need to assess the risks themselves and act within their capabilities.

## Contact Information and Community
- [official website](https://www.fcoin.me)
- [DAPP](https://fcoin.me)
- [GitHub](https://github.com/LessMyers/fcoin)
- [Twitter(X)](https://x.com/@FC_Project)
- [Telegram](https://t.me/+p4EShx_eOG41MWE1)
- [Email](contact@fcoin.me)