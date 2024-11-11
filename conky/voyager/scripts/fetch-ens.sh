#!/bin/bash

fetch_linea_ens() {
  local address="$1"
  
  local query='{
    "query": "query getNamesForAddress {domains(first: 1, where: {and: [{or: [{owner: \"'"$address"'\"}, {registrant: \"'"$address"'\"}, {wrappedOwner: \"'"$address"'\"}]}, {parent_not: \"0x91d1777781884d03a6757a803996e38de2a42967fb37eeaca72729271025a9e2\"}, {or: [{expiryDate_gt: \"1721033912\"}, {expiryDate: null}]}, {or: [{owner_not: \"0x0000000000000000000000000000000000000000\"}, {resolver_not: null}, {and: [{registrant_not: \"0x0000000000000000000000000000000000000000\"}, {registrant_not: null}]}]}]}) {...DomainDetailsWithoutParent}} fragment DomainDetailsWithoutParent on Domain {name}"
  }'

  local response
  response=$(curl -s -X POST "https://api.studio.thegraph.com/query/69290/ens-linea-mainnet/version/latest" \
    -H "Content-Type: application/json" \
    -d "$query")

  local name
  name=$(echo "$response" | jq -r '.data.domains[0].name // empty')

  if [ -z "$name" ]; then
    echo "undefined"
  else
    echo "$name"
  fi
}

# Example usage
address="YOUR ADDRESS HERE"
result=$(fetch_linea_ens "$address")
echo "Domain name: $result"

# Fetch ENS Domains
curl -s -X POST \
  https://api.studio.thegraph.com/query/69290/ens-linea-mainnet/version/latest \
  -H "Content-Type: application/json" \
  -d '{
    "query": "
      query getNamesForAddress {
        domains(
          first: 1,
          where: {
            and: [
              {
                or: [
                  { owner: "'"$ADDRESS"'" },
                  { registrant: "'"$ADDRESS"'" },
                  { wrappedOwner: "'"$ADDRESS"'" }
                ]
              },
              { parent_not: \"0x91d1777781884d03a6757a803996e38de2a42967fb37eeaca72729271025a9e2\" },
              {
                or: [
                  { expiryDate_gt: \"1721033912\" },
                  { expiryDate: null }
                ]
              },
              {
                or: [
                  { owner_not: \"0x0000000000000000000000000000000000000000\" },
                  { resolver_not: null },
                  {
                    and: [
                      { registrant_not: \"0x0000000000000000000000000000000000000000\" },
                      { registrant_not: null }
                    ]
                  }
                ]
              }
            ]
          }
        ) {
          ...DomainDetailsWithoutParent
        }
      }
      fragment DomainDetailsWithoutParent on Domain {
        name
      }
    "
  }' -o ens-domains.json || true
