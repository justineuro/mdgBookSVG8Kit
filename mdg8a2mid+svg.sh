#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg8a2mid+svg.sh
#
#	USAGE:	mdg8a2mid+svg.sh n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 16
#
#		where n1-n16 are any of the 9 possible integers from the set {1,2, 3, 4, 5, 6, 7, 8, 9}
#
# DESCRIPTION:	Used for generating ABC,SVG, and MIDI files 
#		of a particular Musical Dice Game (MDG) minuet based on Ludus Melothedicus (en A mi la)
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.5
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2025/05/05 16:20:33
#    REVISION:	2025/05/27 16:35:34
#==================================================================================

#----------------------------------------------------------------------------------
# declare the variables "diceS1", "diceS2", and "measNR" as arrays
# diceS1 - array containing the 8 9-sided top outcomes from input line for Part I
# diceS2 - array containing the 8 9-sided top outcomes from input line for Part II
# measNR - array of all possible measure notes for a specific outcome
#----------------------------------------------------------------------------------
declare -a diceS1 diceS2 measNR  

#----------------------------------------------------------------------------------
# input 8-sequence of tosses as given in the command line
#----------------------------------------------------------------------------------
diceS1=($1 $2 $3 $4 $5 $6 $7 $8)
diceS2=($9 ${10} ${11} ${12} ${13} ${14} ${15} ${16})

#----------------------------------------------------------------------------------
# input rule table to determine corresponding G/F measures for each toss outcome
#----------------------------------------------------------------------------------
ruletab() {
	case $1 in
	1) measNR=(1 2 3 4 5 6 7 8);;
	2) measNR=(9 10 11 12 13 14 15 16);;
	3) measNR=(17 18 19 20 21 22 23 24);;
	4) measNR=(25 26 27 28 29 30 31 32);;
	5) measNR=(33 34 35 36 37 38 39 40);;
	6) measNR=(41 42 43 44 45 46 47 48);;
	7) measNR=(49 50 51 52 53 54 55 56);;
	8) measNR=(57 58 59 60 61 62 63 64);;
	9) measNR=(65 66 67 68 69 70 71 72);;
	esac
}

#----------------------------------------------------------------------------------
# input notes
# declare variables "notesG" and "notesF" as arrays
# notesS1G - array that contains the possible treble clef notes per measure for Part I
# notesS1F - array that contains the possible bass clef notes per measure for Part I
# measPerm - string that contains the measures corresponding to the dice toss outcomes
#----------------------------------------------------------------------------------
declare -a notesG notesF

#----------------------------------------------------------------------------------
# define notesS1G, array of 72 possible measures of treble clef notes for Part I
#----------------------------------------------------------------------------------
notesS1G=("a2A2f2" "=e^GA4" "d2=E2c=B" "c^GA4" "d=BG2f2" "gf=edc2" "d2=edc=B" "c6" "
=e2A2f2" "=e2a2A2" "=B2=E2d2" "c2=BcA2" "df=B4" "=egc4" "d2G2=B2" "c6" "
=e2A2f2" "=e2^f^ga2" "=edc2=B2" "c^GA4" "fd=B2AG" "=ecd=Bc2" "d=eG,2=B2" "c6" "
A4f2" "A2=B^cd2" "=e2=a^ga2" "cc=B^GA2" "d2=B2AG" "=efg=Bc2" "d2G2=B2" "c6" "
=e2A2df" "=e2=a^g=aA" "d2=edc=B" "c=BA^GA2" "d2=BAG2" "=e=Bc4" "d=eG2=B2" "c6" "
a2A2f2" "=e2^f^g=aA" "=E2d2c=B" "A2C=B,=A,2" "G2df=ed" "=e2=B2c2" "d2G,2=B2" "c6" "
=e2A2f2" "=e2a2=e2" "d2c2=B2" "c2=BcA2" "d2=B2AG" "cd=efg2" "d2=edc=B" "c6" "
A=Bc2d2" "=e2c=BA2" "d=B^G=ed2" "cd=e^GA2" "(3gg=ag2f2" "=ed=efg2" "G2Adc=B" "c6" "
a2=e2df" "=e2A2a2" "=E2d2=B2" "c=Bc=BA2" "d2=B2AG" "=edc=Bc2" "d2G2=B2" "c6")
#echo ${notesS1G[71]}

#----------------------------------------------------------------------------------
# define notesS1F, array of 72 possible measures bass clef notes for Part I
#----------------------------------------------------------------------------------
notesS1F=("A,,=B,,C,2D,2" "C,2z2C,2" "=B,,4=E,2" "A,4z2" "G,4G,,2" "C,2z2=E,2" "F,2G,2G,,2" "C,4C,=B,," "
A,,=B,,C,2D,2" "C,2z2C,2" "=B,,4=E,2" "A,4z2" "G,4G,,2" "C,2z2=E,2" "F,2G,2G,,2" "C,2zA,=E,C," "
A,,=B,,C,2D,2" "=B,,4=E,2" "D,2^F,2G,2" "A,4z2" "G,4G,,2" "C,2z2=E,2" "F,2G,2G,,2" "C,2=E,D,C,=B,," "
A,,=B,,C,2D,2" "C,2z2C,2" "=B,,4=E,2" "A,4z2" "G,4G,,2" "C,2z2=E,2" "F,2G,2G,,2" "C,2zD,C,=B,," "
A,,=B,,C,2D,2" "C,2z2C,2" "=B,,4=E,2" "A,4z2" "G,4G,,2" "C,2z2=E,2" "F,2G,2G,,2" "C,4C,=B,," "
A,,=B,,C,2D,2" "C,2z2C,2" "=B,,4=E,2" "A,4z2" "G,4G,,2" "C,2z2=E,2" "F,2G,2G,,2" "C,2zA,=E,C," "
A,,=B,,C,2D,2" "C,2z2C,2" "=B,,4=E,2" "A,4z2" "G,4G,,2" "C,2z2=E,2" "F,2G,2G,,2" "C,2=E,D,C,=B,," "
A,,4=B,,2" "C,2=E,2A,,2" "=B,,4=E,2" "A,2=E,2A,,2" "=B,,2G,,2=B,,2" "C,2z2=E,2" "=E,2F,2G,2" "C,2z2C,=B,," "
A,,=B,,C,2D,2" "C,2z2C,2" "=B,,4A,2" "A,4z2" "G,4G,,2" "C,2z2=E,2" "F,2G,2G,,2" "C,2zD,C,=B,,")
#echo ${notesS1F[71]}

#----------------------------------------------------------------------------------
# define notesS2G, array of 72 possible measures of treble clef notes for Part II
#----------------------------------------------------------------------------------
notesS2G=("=e2A2a2" "f2^c2d2" "_b2=agf=e" "d2D2f2" "=e2=E2d2" "c=Bc=BA2" "=B2c=BA^G" "A6" "
=e2a2A2" "f2=e2d2" "=e2A2^c2" "d4f2" "=e^g=bdc=B" "c2=BcA2" "=B2=E2^G2" "A6" "
A2_b2=ag" "f^cd4" "=e2f=ed^c" "d2Df=ed" "=e2=edc=B" "c2=E2A2" "=Bc=E2^G2" "A6" "
A2e4" "f2^c2d2" "=efA2^c2" "d4f2" "=e=ed2c=B" "c2^G2A2" "=B2c=BA^G" "A6" "
=e2A2A2" "f=ed^cd2" "_b2f2=e2" "d2D2_e2" "=e2=edc=B" "c2d2=e2" "f2=B2A=B" "A6" "
=e2A2a2" "=agf=ed2" "g_bA2^c2" "d4f2" "=e^g=b2d2" "c=BA^GA2" "=B2c=BA^G" "A6" "
=e2A2f2" "f2=efd2" "=e2A2^c2" "d2f=efd" "=e2=E2d2" "c2=BcA2" "=B2=E2^G2" "A6" "
=e2A2g2" "f=efga2" "=e2f=ed^c" "d2=efd2" "=e^F^GA=B2" "c=Bcd=e2" "=E2^F=BA^G" "A6" "
A=B^c2d=e" "f=ed^cd2" "=efA2^c2" "d4f2" "=e=a=E2d2" "c=e=E2A2" "=Bc=E2^G2" "A6")
#echo ${notesS2G[71]}

#----------------------------------------------------------------------------------
# define notesS2F, array of 72 possible measures bass clef notes for Part II
#----------------------------------------------------------------------------------
notesS2F=("A,,4^C,2" "D,4F,2" "G,2A,2A,,2" "D,4D,2" "C,4=B,,2" "A,,4C,2" "D,2=E,2=E,2" "A,4A,,2" "
A,,4^C,2" "D,4F,2" "G,2A,2A,,2" "D,2F,=E,D,2" "C,4=B,,2" "A,,4C,2" "D,2=E,2=E,2" "A,,2=E,2A,,2" "
A,,4^C,2" "D,4F,2" "G,2A,2A,,2" "D,4D,2" "C,4=B,,2" "A,,4C,2" "D,2=E,2=E,2" "A,,2z=B,,C,=B,," "
A,,4^C,2" "D,4F,2" "G,2A,2A,,2" "D,2F,=E,D,2" "C,4=B,,2" "A,,4C,2" "D,2=E,2=E,2" "A,,=B,,C,2=B,,2" "
A,,4^C,2" "D,4F,2" "G,2A,2A,,2" "D,4D,2" "C,4=B,,2" "A,,4C,2" "D,2=E,2=E,2" "A,4A,,2" "
A,,4^C,2" "D,4F,2" "G,2A,2A,,2" "D,2F,=E,D,2" "C,4=B,,2" "A,,4C,2" "D,2=E,2=E,2" "A,,2=E,2A,,2" "
A,,=B,,C,2D,2" "D,4F,2" "G,2A,2A,,2" "D,4D,2" "C,4=B,,2" "A,,4C,2" "D,2=E,2=E,2" "A,,2z=B,,C,=B,," "
A,,4^C,2" "D,4F,2" "G,2A,2A,,2" "D,4D,2" "A,2^G,2=E,2" "A,,4C,2" "C,2D,2=E,2" "A,,2z=B,,C,=B,," "
A,2=E,2^C,2" "D,4F,2" "G,2A,2A,,2" "D,2F,=E,D,2" "C,4=B,,2" "A,,4C,2" "D,2=E,2=E,2" "A,,4(3=E,^F,^G,")
#echo ${notesS2F[71]}

#----------------------------------------------------------------------------------
# create cat-to-output-file function
#----------------------------------------------------------------------------------
catToFile(){
	cat >> $filen << EOT
$1
EOT
}

#----------------------------------------------------------------------------------
# create empty ABC file
# set header info: generic index number, filename
#----------------------------------------------------------------------------------
fileInd=$1-$2-$3-$4-$5-$6-$7-$8-$9-${10}-${11}-${12}-${13}-${14}-${15}-${16}
filen="ldmta-$fileInd.abc"

#-----------------------------------------------------------------------------------------------------
# calculate permutation number for the current dice toss (from 9^8*9^8 = 1,853,020,188,851,841 possibilities)
# Unique: Unique: (6*9*9*7*7*9*5*5) * (8*7*6*6*7*8*5*5) = (9^3*7^2*6*5^2) * (8^2*7^2*6^2*5^2) 
#		= 15,122,842,560,000 (~15.1 trillions)  
# part I - measure 1: 1=6, 2=3=7; measure 4: 1=3; 2=7; measure 5: 4=5=7; measure 7: 1=7, 2=4=6=9; 
#		measure 8: 1=5, 2=6, 3=7, 4=9 
# part II - measure 1: 1=6; measure 2: 1=4, 5=9; measure 3: 2=7; 3=8, 4=9; measure 4: 2=4=6=9; measure 5: 1=7, 3=5; 
# 	measure 6: 2=7; measure 7: 1=4=6, 2=7, 3=9; measure 8: 1=5, 2=6, 3=7=8
#-----------------------------------------------------------------------------------------------------
# adjust count for Part I,bar 1 for rolls beyond 2 (only 6 unique bars; 1=6, 2=3=7)
if [ "${diceS1[0]}" = "3" ]; then diceS1[0]=2; fi
if [ "${diceS1[0]}" = "4" ]; then diceS1[0]=3; fi
if [ "${diceS1[0]}" = "5" ]; then diceS1[0]=4; fi
if [ "${diceS1[0]}" = "6" ]; then diceS1[0]=1; fi
if [ "${diceS1[0]}" = "7" ]; then diceS1[0]=2; fi
if [ "${diceS1[0]}" = "8" ]; then diceS1[0]=5; fi
if [ "${diceS1[0]}" = "9" ]; then diceS1[0]=6; fi
# adjust count for Part I,bar 4 for rolls beyond 2 (only 7 unique bars; 1=3, 2=7)
if [ "${diceS1[3]}" = "3" ]; then diceS1[3]=1; fi
if [ "${diceS1[3]}" = "4" ]; then diceS1[3]=3; fi
if [ "${diceS1[3]}" = "5" ]; then diceS1[3]=4; fi
if [ "${diceS1[3]}" = "6" ]; then diceS1[3]=5; fi
if [ "${diceS1[3]}" = "7" ]; then diceS1[3]=2; fi
if [ "${diceS1[3]}" = "8" ]; then diceS1[3]=6; fi
if [ "${diceS1[3]}" = "9" ]; then diceS1[3]=7; fi
# adjust count for Part I,bar 5 for rolls beyond 4 (only 7 unique bars; 4=5=7)
if [ "${diceS1[4]}" = "5" ]; then diceS1[4]=4; fi
if [ "${diceS1[4]}" = "6" ]; then diceS1[4]=5; fi
if [ "${diceS1[4]}" = "7" ]; then diceS1[4]=4; fi
if [ "${diceS1[4]}" = "8" ]; then diceS1[4]=6; fi
if [ "${diceS1[4]}" = "9" ]; then diceS1[4]=7; fi
# adjust count for Part I,bar 7 for rolls beyond 3 (only 5 unique bars; 1=7, 2=4=6=9)
if [ "${diceS1[6]}" = "4" ]; then diceS1[6]=2; fi
if [ "${diceS1[6]}" = "5" ]; then diceS1[6]=4; fi
if [ "${diceS1[6]}" = "6" ]; then diceS1[6]=2; fi
if [ "${diceS1[6]}" = "7" ]; then diceS1[6]=1; fi
if [ "${diceS1[6]}" = "8" ]; then diceS1[6]=5; fi
if [ "${diceS1[6]}" = "9" ]; then diceS1[6]=2; fi
# adjust count for Part I,bar 8 for rolls beyond 4 (only 5 unique bars; 1=5, 2=6, 3=7, 4=9)
if [ "${diceS1[7]}" = "5" ]; then diceS1[7]=1; fi
if [ "${diceS1[7]}" = "6" ]; then diceS1[7]=2; fi
if [ "${diceS1[7]}" = "7" ]; then diceS1[7]=3; fi
if [ "${diceS1[7]}" = "8" ]; then diceS1[7]=5; fi
if [ "${diceS1[7]}" = "9" ]; then diceS1[7]=4; fi
# part II - measure 1: 1=6; measure 2: 1=4, 5=9; measure 3: 2=7; 3=8, 4=9; measure 4: 2=4=6=9; measure 5: 1=7, 3=5; measure 6: 2=7; measure 7: 1=4=6, 2=7, 3=9; measure 8: 1=5, 2=6, 3=7=8
# adjust count for Part II,bar 1 for rolls beyond 5 (only 8 unique bars; 1=6)
if [ "${diceS2[0]}" = "6" ]; then diceS2[0]=1; fi
if [ "${diceS2[0]}" = "7" ]; then diceS2[0]=6; fi
if [ "${diceS2[0]}" = "8" ]; then diceS2[0]=7; fi
if [ "${diceS2[0]}" = "9" ]; then diceS2[0]=8; fi
# adjust count for Part II,bar 2 for rolls beyond 3 (only 7 unique bars; 1=4, 5=9)
if [ "${diceS2[1]}" = "4" ]; then diceS2[1]=1; fi
if [ "${diceS2[1]}" = "5" ]; then diceS2[1]=4; fi
if [ "${diceS2[1]}" = "6" ]; then diceS2[1]=5; fi
if [ "${diceS2[1]}" = "7" ]; then diceS2[1]=6; fi
if [ "${diceS2[1]}" = "8" ]; then diceS2[1]=7; fi
if [ "${diceS2[1]}" = "9" ]; then diceS2[1]=5; fi
# adjust count for Part II,bar 3 for rolls beyond 6 (only 6 unique bars; 2=7; 3=8, 4=9)
if [ "${diceS2[2]}" = "7" ]; then diceS2[2]=2; fi
if [ "${diceS2[2]}" = "8" ]; then diceS2[2]=3; fi
if [ "${diceS2[2]}" = "9" ]; then diceS2[2]=4; fi
# adjust count for Part II,bar 4 for rolls beyond 3 (only 6 unique bars; 2=4=6=9)
if [ "${diceS2[3]}" = "4" ]; then diceS2[3]=2; fi
if [ "${diceS2[3]}" = "5" ]; then diceS2[3]=4; fi
if [ "${diceS2[3]}" = "6" ]; then diceS2[3]=2; fi
if [ "${diceS2[3]}" = "7" ]; then diceS2[3]=5; fi
if [ "${diceS2[3]}" = "8" ]; then diceS2[3]=6; fi
if [ "${diceS2[3]}" = "9" ]; then diceS2[3]=2; fi
# adjust count for Part II,bar 5 for rolls beyond 4 (only 7 unique bars; 1=7, 3=5)
if [ "${diceS2[4]}" = "5" ]; then diceS2[4]=3; fi
if [ "${diceS2[4]}" = "6" ]; then diceS2[4]=5; fi
if [ "${diceS2[4]}" = "7" ]; then diceS2[4]=1; fi
if [ "${diceS2[4]}" = "8" ]; then diceS2[4]=6; fi
if [ "${diceS2[4]}" = "9" ]; then diceS2[4]=7; fi
# adjust count for Part II,bar 6 for rolls beyond 6 (only 8 unique bars; 2=7)
if [ "${diceS2[5]}" = "7" ]; then diceS2[5]=2; fi
if [ "${diceS2[5]}" = "8" ]; then diceS2[5]=7; fi
if [ "${diceS2[5]}" = "9" ]; then diceS2[5]=8; fi
# adjust count for Part II,bar 7 for rolls beyond 3 (only 5 unique bars; 1=4=6, 2=7, 3=9)
if [ "${diceS2[6]}" = "4" ]; then diceS2[6]=1; fi
if [ "${diceS2[6]}" = "5" ]; then diceS2[6]=4; fi
if [ "${diceS2[6]}" = "6" ]; then diceS2[6]=1; fi
if [ "${diceS2[6]}" = "7" ]; then diceS2[6]=2; fi
if [ "${diceS2[6]}" = "8" ]; then diceS2[6]=5; fi
if [ "${diceS2[6]}" = "9" ]; then diceS2[6]=3; fi
# adjust count for Part II,bar 8 for rolls beyond 4 (only 5 unique bars; 1=5, 2=6, 3=7=8)
if [ "${diceS2[7]}" = "5" ]; then diceS2[7]=1; fi
if [ "${diceS2[7]}" = "6" ]; then diceS2[7]=2; fi
if [ "${diceS2[7]}" = "7" ]; then diceS2[7]=3; fi
if [ "${diceS2[7]}" = "8" ]; then diceS2[7]=3; fi
if [ "${diceS2[7]}" = "9" ]; then diceS2[7]=5; fi
# calculate dbNum
dbNum=$(( 1 + (${diceS1[0]}-1) + (${diceS1[1]}-1)*6 + (${diceS1[2]}-1)*6*9 + (${diceS1[3]}-1)*6*9**2 + (${diceS1[4]}-1)*6*9**2*7 + (${diceS1[5]}-1)*6*9**2*7**2 + (${diceS1[6]}-1)*6*9**3*7**2 + (${diceS1[7]}-1)*6*9**3*7**2*5 + (${diceS2[0]}-1)*6*9**3*7**2*5**2 + (${diceS2[1]}-1)*6*9**3*7**2*5**2*8 + (${diceS2[2]}-1)*6*9**3*7**3*5**2*8 + (${diceS2[3]}-1)*6**2*9**3*7**3*5**2*8 + (${diceS2[4]}-1)*6**3*9**3*7**3*5**2*8 + (${diceS2[5]}-1)*6**3*9**3*7**4*5**2*8 + (${diceS2[6]}-1)*6**3*9**3*7**4*5**2*8**2 + (${diceS2[7]}-1)*6**3*9**3*7**4*5**3*8**2 ))
echo $dbNum

# restore original toss values
diceS1=[0]=$1;diceS1[3]=$4;diceS1[4]=$5;diceS1[6]=$7; diceS1[7]=$8;
diceS2=[0]=$9;diceS2[1]=${10};diceS2[2]=${11};diceS2[3]=${12};diceS2[4]=${13};diceS2[5]=${14};diceS2[6]=${15};diceS2[7]=${16}; 


#----------------------------------------------------------------------------------
# determine the sequence of bar numbers to be played for Parts I and II
#----------------------------------------------------------------------------------
measPerm1=""
measPerm2=""
measPerm=""
for ind in 1 2 3 4 5 6 7 8; do
	measj1=${diceS1[$ind-1]} 
	ruletab $measj1
	measPerm1="$measPerm1${measNR[$ind-1]}:"
	#echo $measPerm1
	measj2=${diceS2[$ind-1]} 
	ruletab $measj2
	measPerm2="$measPerm2${measNR[$ind-1]}:"
	#echo $measPerm2
done
measPerm="$measPerm1:$measPerm2:"

#----------------------------------------------------------------------------------
# if output abc file already exists, then make a back-up copy
#----------------------------------------------------------------------------------
if [ -f $filen ]; then 
	mv $filen $filen."bak"
fi

#----------------------------------------------------------------------------------
# generate the header of the ABC file
#----------------------------------------------------------------------------------
catToFile "%%scale 0.60
%%pagewidth 21.10cm
%%bgcolor white
%%topspace 0
%%composerspace 0
%%leftmargin 0.80cm
%%rightmargin 0.80cm
X:$dbNum
T:${fileInd}
%%setfont-1 Courier-Bold 12
T:\$1ldmta::$measPerm\$0
T:\$1Perm. No.: $dbNum\$0
M:3/4
L:1/8
Q:1/8=140
%%staves [1 2]
V:1 clef=treble
V:2 clef=bass
K:Amin
%
%%MIDI program 1 40       % Instrument 41 Violin
%%MIDI program 2 42       % Instrument 43 Cello"

#----------------------------------------------------------------------------------
# write the notes of the ABC file
#----------------------------------------------------------------------------------
p1V1="";p1V2=""
p2V1="";p2V2=""
for col in 1 2 3 4 5 6 7; do
	#for Part I
	ruletab ${diceS1[$col-1]}
	measN=${measNR[$col-1]}
	p1V1=${p1V1}" "${notesS1G[$measN-1]}" |"
	p1V2=${p1V2}" "${notesS1F[$measN-1]}" |"
	#for Part II
	ruletab ${diceS2[$col-1]}
	measN=${measNR[$col-1]}
	p2V1=${p2V1}" "${notesS2G[$measN-1]}" |"
	p2V2=${p2V2}" "${notesS2F[$measN-1]}" |"
done
# add the 8th bar
ruletab ${diceS1[7]}
p1V1=${p1V1}" "${notesS1G[${measNR[7]}-1]}" :|"
p1V2=${p1V2}" "${notesS1F[${measNR[7]}-1]}" :|"
ruletab ${diceS2[7]}
p2V1=${p2V1}" "${notesS2G[${measNR[7]}-1]}" :|]"
p2V2=${p2V2}" "${notesS2F[${measNR[7]}-1]}" :|]"

echo -e "[V:1] ${p1V1}" >> ./$filen
echo -e "[V:2] ${p1V2}" >> ./$filen
echo -e "[V:1]|: ${p2V1}" >> ./$filen
echo -e "[V:2]|: ${p2V2}" >> ./$filen

# create SVG
abcm2ps ./$filen -O ./"ldmta-$fileInd.svg" -g

# create MIDI
abc2midi ./$filen -quiet -silent -o ./"ldmta-$fileInd.mid"
#
##
###
