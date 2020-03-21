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
	done

	#finding luckiest and unluckiest day by calling sortDictionary function
	echo "Luckiest Day is : $( sortDictionary | head -1 ) "
	echo "Unluckiest Day is : $( sortDictionary | tail -1 ) "
}

#function to sort all values of dictionary
function sortDictionary()
{
	for day in ${!sumOfBets[@]}
	do
		echo "$day : ${sumOfBets[$day]}"
	done | sort -k3 -rn
}

function playNextMonth()
{
	monthlyGambling
	
	#checking Previous month balance of Gambler and Decides He/She will be playing or not
	while [ ${sumOfBets[Day20]} -gt 0 ]
	do
		#Printing a colored output
		echo -e "\e[1;34m Last Month Balance = ${sumOfBets[Day20]} \e[0m \n"
		read -p "You Won. Do you want to play for the next month?. If yes press 'y' Otherwise press any key : " playAgain
		if [ $playAgain == "y" ]; then
			monthlyGambling
		else
			exit
		fi
	done
		echo -e "\e[1;35m Last Month Balance = ${sumOfBets[Day20]} \e[0m \nNot Playing Next Month"
}

#Starting game
playNextMonth
