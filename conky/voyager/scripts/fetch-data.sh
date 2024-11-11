#!/bin/bash

# Define constants
ADDRESS="YOUR ADDRESS HERE"
contractLXP="0xd83af4fbd77f3ab65c3b1dc4b38d7e67aecf599a" # DONT EDIT
contractLXPL="0x96B3a15257c4983A6fE9073D8C91763433124B82" # DONT EDIT
LS_API_KEY="LINEASCAN API KEY HERE" #refer https://docs.lineascan.build/getting-started/viewing-api-usage-statistics

# Fetch LXP Balance
curl -s -X GET \
  "https://api.lineascan.build/api?module=account&action=tokenbalance&contractaddress=$contractLXP&address=$ADDRESS&tag=latest&apikey=$LS_API_KEY" \
  -H 'accept: */*' -o json/lxp.json || true #If fetching fails, don't write & jump to the next command

# Fetch LXP-L Balance
curl -s -X GET \
  "https://api.lineascan.build/api?module=account&action=tokenbalance&contractaddress=$contractLXPL&address=$ADDRESS&tag=latest&apikey=$LS_API_KEY" \
  -H 'accept: */*' -o json/lxpl.json || true

# Fetch POH Status
curl -s -X GET \
  "https://linea-xp-poh-api.linea.build/poh/$ADDRESS" \
  -H 'accept: */*' -o json/poh.json || true

# Fetch OpenBlock score (specific error handling for 'errorType')
response=$(curl -s -X GET \
  "https://lxp-snap-api.netlify.app/.netlify/functions/global-api-v2?address=$ADDRESS" \
  -H 'accept: */*')
# Only write to lxpl-openblock.json if no 'errorType' is present AND response is not empty
if ! echo "$response" | grep -q '"errorType"' && [ -n "$response" ]; then
  echo "$response" > json/lxpl-openblock.json
fi
# Now extract the openBlockScore value from lxpl-openblock.json and write to lxpl.json
grep -o '"openBlockScore":[^,}]*' json/lxpl-openblock.json | sed 's/"openBlockScore"://' > json/lxpl-openblock-formatted.json

# You can also extract other data from the responses as needed

