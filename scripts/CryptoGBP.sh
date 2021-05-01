#/bin/sh
# Insert CryptoGBP Symbols
( cd ../
# Insert Stock Exchange
./symbol.py --exchange=CryptoGBP
# Insert Stock Symbols
./symbol.py --exchange="CryptoGBP" --symbol="ADA-GBP" --name="Cardano"
#./symbol.py --exchange="CryptoGBP" --symbol="BNB-GBP" --name="BinanceCoin"
./symbol.py --exchange="CryptoGBP" --symbol="BTC-GBP" --name="Bitcoin"
#./symbol.py --exchange="CryptoGBP" --symbol="CAKE-GBP" --name="PancakeSwap"
./symbol.py --exchange="CryptoGBP" --symbol="CHZ-GBP" --name="Chiliz"
./symbol.py --exchange="CryptoGBP" --symbol="DOGE-GBP" --name="DogeCoin"
./symbol.py --exchange="CryptoGBP" --symbol="DOT-GBP" --name="Polkadot"
./symbol.py --exchange="CryptoGBP" --symbol="ENJ-GBP" --name="Enjin"
./symbol.py --exchange="CryptoGBP" --symbol="ETH-GBP" --name="Ethereum"
./symbol.py --exchange="CryptoGBP" --symbol="LINK-GBP" --name="Chainlink"
./symbol.py --exchange="CryptoGBP" --symbol="LTC-GBP" --name="Litecoin"
./symbol.py --exchange="CryptoGBP" --symbol="SXP-GBP" --name="SwipeCoin"
./symbol.py --exchange="CryptoGBP" --symbol="VET-GBP" --name="VeChain"
./symbol.py --exchange="CryptoGBP" --symbol="XRP-GBP" --name="Ripple"
) #END of Change Directory
