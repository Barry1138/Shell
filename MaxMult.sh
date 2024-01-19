#!/bin/bash

maxMultiple() {
    divisor=$1
    bound=$2
    
    largest_multiple=$((bound / divisor * divisor))
    
    echo $largest_multiple
    }
    
maxMultiple $1 $2
