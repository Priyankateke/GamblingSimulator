#!/bin/bash -x

echo "Welcome To Gambling Simulation"

#constants
readonly EVERY_DAY_STAKE=100
readonly BET=1

#variables
cash=$EVERY_DAY_STAKE

#Function to check win or loss 
function dailyBet()
{
	if [ $((RANDOM % 2)) -eq 1 ]
	then
		echo "Win"
		cash=$((cash+BET))
	else
		echo "Loss"
		cash=$((cash-BET))
	fi
}

dailyBet
