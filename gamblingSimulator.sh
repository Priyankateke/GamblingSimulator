#!/bin/bash -x

echo "Welcome To Gambling Simulation"

#constants
readonly EVERY_DAY_STAKE=100
readonly BET=1
readonly TOTAL_DAYS=20
readonly LOWER_PERCENT=$((EVERY_DAY_STAKE-$((EVERY_DAY_STAKE * 50 /100)) ))
readonly UPPER_PERCENT=$((EVERY_DAY_STAKE+$((EVERY_DAY_STAKE * 50 /100)) ))

#Variables
cash=$EVERY_DAY_STAKE
totalAmount=0

#dictionary
declare -A sumOfBets

#Function for Daily Betting
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
	gainCash=$((cash-EVERY_DAY_STAKE))
	echo $gainCash
}

#function for Monthly Bet
function monthlyGambling() 
{
	for ((day=1;day<=TOTAL_DAYS;day++))
	do
		#storing Each Day amount in Dictionary
		sumOfBets[Day$day]=$((${sumOfBets[Day$((day-1))]} + $(dailyBet) ))
		echo "Amount On Day-$day : ${sumOfBets[Day$day]}"
	done
}

#!Starting game
monthlyGambling
