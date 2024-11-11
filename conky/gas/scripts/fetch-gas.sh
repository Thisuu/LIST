#!/bin/bash

# Define constants
LS_API_KEY="LINEASCAN API KEY HERE" #refer https://docs.lineascan.build/getting-started/viewing-api-usage-statistics

curl -s "https://api.lineascan.build/api?module=proxy&action=eth_gasPrice&apikey=VCP215W1R1V4D3SW4GZM6732E9F79PHJCC" | jq -r '.result' | sed 's/^0x//' | xargs -I {} sh -c 'decimal_price=$(echo "ibase=16; {}" | bc); gwei_price=$(echo "scale=9; $decimal_price / 1000000000" | bc); jq -n --arg gwei "$gwei_price" "{\"gasPriceGwei\": \$gwei}" > json/gas.json'

