#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg82midRndN+svg.sh
#
#	USAGE:	mdg82midRndN+svg.sh <num>
#
#		where <num> is the number of random MDG minuets to be generated, e.g., 20.
#		*** NOTE:  This script has to be in the same directory as mdg82mid+svg.sh. ***
#
# DESCRIPTION:	Used for generating ABC and MIDI files 
#		of a particular Musical Dice Game (MDG) minuet based on Ludus Melothedicus
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.1
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2025/05/06 03:50:24
#    REVISION:	2025/05/15 12:46:25
#==================================================================================

#----------------------------------------------------------------------------------
# define the function genS() that randomly chooses an integer from 1 to 9, inclusive
#----------------------------------------------------------------------------------
genS() { # RANDOM randomly generates an integer from 0 to 32765
	rnd=32759
	until [ $rnd -lt 32759 ]
	do
		rnd=$[RANDOM]
		if [ $rnd -lt 32759 ]; then echo $[rnd%9+1]; fi
	done
}

#----------------------------------------------------------------------------------
# declare the variables "diceR" as an array
# diceS - array containing the 16 outcomes from input line
#----------------------------------------------------------------------------------
declare -a diceR

#----------------------------------------------------------------------------------
# generate the <num> random minuets
#----------------------------------------------------------------------------------
i=1
while [ $i -le $1 ]; do

#----------------------------------------------------------------------------------
# generate the random 16-sequence of outcomes of the 16 throws of a 9-sided die/top  
# for the measures of the minuet:
#		n1-n8 for the 1st part 
#		n9-n16 for the 2nd part
#----------------------------------------------------------------------------------
	for j in {0..15}; do
		diceR[$j]=`genS`
	done
echo ${diceR[*]}
	
#----------------------------------------------------------------------------------
# generate a minuet in ABC notation and corresponding MIDI and svg for the current 
# diceR using mdg82mid+svg.sh
#----------------------------------------------------------------------------------
	./mdg82mid+svg.sh ${diceR[*]}
	i=`expr $i + 1`
done
#
##
####
