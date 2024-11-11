#!/bin/sh
sleep 20s
killall conky
cd "$HOME/.conky/voyager"
conky -c "$HOME/.conky/voyager/voyager" &
cd "$HOME/.conky/balance"
conky -c "$HOME/.conky/balance/balance" &
cd "$HOME/.conky/coin"
conky -c "$HOME/.conky/coin/coin" &
cd "$HOME/.conky/EthBtc"
conky -c "$HOME/.conky/EthBtc/EthBtc" &
cd "$HOME/.conky/gas"
conky -c "$HOME/.conky/gas/gas" &
cd "$HOME/.conky/tvl"
conky -c "$HOME/.conky/tvl/tvl" &
exit 0
