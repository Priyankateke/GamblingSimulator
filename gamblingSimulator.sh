#!/bin/bash -x

echo "Welcome To Gambling Simulation"

#constants
readonly EVERY_DAY_STAKE=100
readonly BET=1
LOWER_PERCENT=$((EVERY_DAY_STAKE-$((EVERY_DAY_STAKE * 50 /100)) ))
UPPER_PERCENT=$((EVERY_DAY_STAKE+$((EVERY_DAY_STAKE * 50 /100)) ))

#variables
cash=$EVERY_DAY_STAKE

#Function to check win or loss 
function dailyBet()
{
	while [ $cash -gt $LOWER_PERCENT ] && [ $cash -lt $UPPER_PERCENT ]
	do
		if [ $((RANDOM % 2)) -eq 1 ]
		then
			cash=$((cash+BET))
		else
			cash=$((cash-BET))
		fi
	done
}

dailyBet
