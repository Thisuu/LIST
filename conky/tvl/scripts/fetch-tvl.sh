#!/bin/sh

contractL1="0xd19d4B5d358258f05D7B411E21A1460D11B0876F" #DONT EDIT/Linea L1
escrowL1="0x051F1D88f0aF5763fB888eC4378b4D8B29ea3319" #DONT EDIT
ES_API_KEY="ETHERSCAN API KEY HERE" #Get through https://etherscan.io/myapikey

contractWBTC="0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599" #DONT EDIT
contractUSDT="0xdAC17F958D2ee523a2206206994597C13D831ec7" #DONT EDIT
contractwstETH="0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0" #DONT EDIT
contractDAI="0x6B175474E89094C44Da98b954EedeAC495271d0F" #DONT EDIT
contractLUSD="0x5f98805A4E8be255a32880FDeC7F6728C6568bA0" #DONT EDIT
contractSIS="0xd38BB40815d2B0c2d2c866e0c72c5728ffC76dd9" #DONT EDIT
contractUNI="0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984" #DONT EDIT
contractSHIB="0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE" #DONT EDIT
contractKNC="0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202" #DONT EDIT
contractPEPE="0x6982508145454Ce325dDbE47a25d4ec3d2311933" #DONT EDIT

#ETH amount locked on canonical
ETH_L1=$(curl -s -X GET "https://api.etherscan.io/api?module=account&action=balance&address=$contractL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')
#ETH Price
ETH_PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd" | jq -r '.ethereum.usd')

## Rest of the tokens bridged ##
#WBTC
WBTC_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractWBTC&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')
BTC_PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" | jq -r '.bitcoin.usd')

#USDT (pegged)
USDT_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractUSDT&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')

#wstETH
wstETH_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractwstETH&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')

#DAI (pegged)
DAI_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractDAI&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')

#LUSD (pegged)
LUSD_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractLUSD&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')

#SIS
SIS_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractSIS&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')
SIS_PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=symbiosis-finance&vs_currencies=usd" | jq -r '.["symbiosis-finance"].usd')

#UNI
UNI_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractUNI&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')
UNI_PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=uniswap&vs_currencies=usd" | jq -r '.uniswap.usd')

#SHIB
SHIB_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractSHIB&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')
SHIB_PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=shiba-inu&vs_currencies=usd" | jq -r '.["shiba-inu"].usd')

#KNC
KNC_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractKNC&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')
KNC_PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=kyber-network-crystal&vs_currencies=usd" | jq -r '.["kyber-network-crystal"].usd')

#PEPE
PEPE_L1=$(curl -s -X GET "https://api.etherscan.io/v2/api?chainid=1&module=account&action=tokenbalance&contractaddress=$contractPEPE&address=$escrowL1&tag=latest&apikey=$ES_API_KEY" | jq -r '.result | tonumber / 1e18')
PEPE_PRICE=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=pepe&vs_currencies=usd" | jq -r '.pepe.usd') 

wait

# Calculate the USD value of ETH+ERC20 locked, and convert to Millions(scale=floating points). For USD pegged tokens, assume TVL=AMOUNT LOCKED
TVL_CANONICAL=$(echo "scale=1; ($ETH_L1 * $ETH_PRICE)  / 1000000" | bc) && TVL_CANONICAL="${TVL_CANONICAL} M"

cat <<EOF > json/tvl-canonical-eth.json
{
  "eth_balance": "$ETH_L1",
  "tvl": "$TVL_CANONICAL"
}
EOF
