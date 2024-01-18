#!/bin/bash

$RANDOM= 'date +%s'

let NUM=( $RANDOM % 20 + 1 )

clear

echo "I have chosen a number between 1 and 20"
echo "Can you guess what it is?"

read GUESS

while [ $GUESS -gt $NUM ]
do
        if [ $GUESS -gt $NUM ]
                then echo "No - try lower"
                else echo "No - try higher"
        fi
        read GUESS
done

echo "Yes the number is $NUM
