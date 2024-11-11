#!/bin/bash

# Define constants
ADDRESS="YOUR ADDRESS HERE"
LS_API_KEY="LINEASCAN API KEY HERE" #refer https://docs.lineascan.build/getting-started/viewing-api-usage-statistics
contractUSDC="0x176211869cA2b568f2A7D4EE941E073a821EE1ff" #DONT EDIT

# Fetch USDC Balance
curl -s -X GET \
  "https://api.lineascan.build/api?module=account&action=tokenbalance&contractaddress=$contractUSDC&address=$ADDRESS&tag=latest&apikey=$LS_API_KEY" \
  -H 'accept: */*' -o json/usdc.json || true #If fetching fails, don't write & jump to the next command

# Fetch ETH Balance
curl -s -X GET \
  "https://api.lineascan.build/api?module=account&action=balance&address=$ADDRESS&tag=latest&apikey=$LS_API_KEY" \
  -H 'accept: */*' -o json/eth.json || true #If fetching fails, don't write & jump to the next command
  
