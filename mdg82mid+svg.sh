#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg82mid+svg.sh
#
#	USAGE:	mdg82mid+svg.sh n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 16
#
#		where n1-n16 are any of the 9 possible integers from the set {1,2, 3, 4, 5, 6, 7, 8, 9}
#
# DESCRIPTION:	Used for generating ABC and MIDI files 
#		of a particular Musical Dice Game (MDG) minuet based on Ludus Melothedicus
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.2
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2025/05/05 16:20:33
#    REVISION:	2025/05/15 14:46:30
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
notesS1G=("d=e^f2g2" "^fg{=a}g2^f2" "a2^f2d2" "{d}^c4A2" "(3=B^cA =BG=e2" "^c=a=E gd2" "A=B^c2d=e" "e6" "dAd^f=eg" "=a^cd4" "=e2g^f=ed" "^c2=B^cA2" "{=a}g4=ed" "^c2=B^cd2" "A2g=e^fd" "e6" "DdA^FDA," "^f{=e}d^c2d2" "^f=ag=e=B=e" "^c2=B^cA2" "=B2G2=e2" "^c=BA=e^f2" "A,g^fd^cd" "{^f}[Ae]6" "d2ddd=e" "A2=B^cd2" "=Bg=e^fg=B" "^cA=E ^C=A,2" "[G=B]2[G=B][G=B][G=B][G=B]" "^c2=BAd2" "A2g^f_a=e" "{^f}[Ae]6" "A2d=e{^f}=e2" "^fd^cAd2" "D^FG=E =ed" "^c2=e^GA2" "=B2=eg=ed" "^c=B^cAd2" "=A,2g2^f2" "e6" "Ad^f=ag2" "^f=a^c=ed2" "A2=BG=Bd" "^c2^G=BA2" "=B2g4" "^c=e^cAd2" "=BAG2^Fd" "e6" "D^FAd^f=a" "A^c=eg^f2" "a2^fd=B=e" "^c2 (3d^cd=e2" "G2=e^fg=e" "{d}^c4d2" "^f=bdA^cd" "e6" "D2d2=e2" "{g}^f4=e2" "a2(3g=a^f (3=e^fd" "^c2d^f=e2" "g^f=b2=ed" "^cAG=E ^Fd" "(3=b=agg2^fd" "e6" "d2d=e^fg" "^f2^c2d2" "^f2g^f=ed" "^cd=e^GA2" "=B4g{^f}=e" "^c=eA,^cd2" "=eAg2(3^fg=a" "[Ae]6")
#echo ${notesS1G[71]}

#----------------------------------------------------------------------------------
# define notesS1F, array of 72 possible measures bass clef notes for Part I
#----------------------------------------------------------------------------------
notesS1F=("D,2^F,2^C,2" "D,2A,,2D,2" "D,2^F,2D,2" "A,2G,2^F,2" "G,2G,2G,2" "A,,2^C,2D,2" "^C,2=E,2D,2" "A,,2A,,=B,,^C,A,," "D,2^F,2^C,2" "D,2=E,2^F,2" "G,2=E,2G,2" "A,2G,2^F,2" "=E,2^C,2=B,,2" "A,2G,2^F,2" "^C,2=E,2D,2" "A,2=E,2A,,2" "D,2^F,2D,2" "D,2=E,2^F,2" "D,2^F,2G,2" "A,2G,2^F,2" "G,2G,2G,2" "A,,2^C,2D,2" "^C,2D,2G,2" "A,2^F,A,,=B,,^C," "D,2^F,2D,2" "^C,2A,,2D,2" "G,2z2G,2" "A,2=E,2A,,2" "G,^F,=E,4" "A,2G,2^F,2" "^C,2D,2G,2" "A,2A,G,^F,=E," "D,=E,^F,2^C,2" "D,2A,,2D,2" "D,2=E,2G,2" "A,2=E,2A,,2" "G,2G,2G,2" "A,2G,2^F,2" "^C,2=E,2D,2" "A,,2A,,=B,,^C,A,," "D,2D,2=E,2" "D,2=E,2^F,2" "D,2G,2z2" "A,2=E,2A,,2" "zG,=E,D,^C,=B,," "A,2G,2^F,2" "G,2=E,2D,2" "A,2zA,,=B,,^C," "D,2^F,2D,2" "^C,2A,,2D,2" "D,2^F,2G,2" "A,2=E,2A,,2" "=E,2G,2G,2" "z^CA,G,^F,D," "=E,2G,2G,2" "A,2=E,2A,,2" "D,=E,^F,2^C,2" "D,2^C,2A,,2" "D,2=E,2G,2" "A,2=E,2A,,2" "^C,2A,,2D,2" "A,,2^C,2D,2" "G,2=E,2D,2" "A,2A,G,^F,=E," "D,=E,^F,2^C,2" "D,2=E,2^F,2" "D,2^F,2G,2" "A,2=E,2A,,2" "z=B,G,^F,=E,2" "A,2G,2^F,2" "^C,2=E,2D,2" "A,2=E,2A,,2")
#echo ${notesS1F[71]}

#----------------------------------------------------------------------------------
# define notesS2G, array of 72 possible measures of treble clef notes for Part II
#----------------------------------------------------------------------------------
notesS2G=("d2dddd" "=B2c=BG2" "=b2g2=e2" "^c=B^cd=e2" "=BG^cAd=B" "^cA=egd2" "=bg^f=ed^c" "DdD4" "(3=a^fdA2c2" "(3=Bd^FG4" "=B=e=egg=B" "^c2=B2A2" "=B2g^f=ed" "=eg (3^c=BA d2" "=BG^F2=E ^c" "D6" "DdA^FDc" "d2=B^FG2" "=B=eg=bd2" "^cd=e^GA2" "=B2g2=e2" "^c=B^cAd2" "(3=B^cd^F2=E D" "D6" "^f=a^fdAc" "=Bcd^FG2" "=e2=e=e=e=e" "(3^c=e^GA4" "[G=B]2[G=B][G=B][G=B][G=B]" "^c2=BAd2" "(3=BAG^F2=E ^C" "D6" "a4^fA" "^fd^cAd2" "=E ^G=B2=e2" "=e2^c^GA2" "(3=BAG =B=eg2" "^c2=B^cd2" "=BG^F2=E2" "D6" "(3^fg=a A=Bc2" "{d}c4=B2" "=Bd=e^fg=e" "(3^cd=e =B^ga2" "=B2g4" "(3^c=BA d4" "(3=B^cd A^F G=E" "DdD4" "^f=ad2c2" "(3=Bcd D^FG2" "g=b=B2d2" "{=e}d4^c2" "g2=e^fg=B" "^cAG=E ^F2" "=BG=E2A,^C" "D6" "a2^f2A2" "=Bd^F2G2" "=B2=B=B^cd" "^c=e^G2A2" "=BGg^f=eg" "^cA=E ^cd2" "(3=BAG (3F=ED (3^CD=E" "D^CD4" "Add^f^fA" "=B2^F2G2" "=bg=eg=Bd" "^cAD^C=A,2" "=B4(3g^f=e" "{d}^c4d2" "(3BAG ^Fd A,^c" "D6")
#echo ${notesS2G[71]}

#----------------------------------------------------------------------------------
# define notesS2F, array of 72 possible measures bass clef notes for Part II
#----------------------------------------------------------------------------------
notesS2F=("D,2=E,2^F,2" "G,2D,2G,,2" "G,2G,2G,2" "A,2=E,2A,,2" "G,2z2G,2" "A,2^C,2D,2" "G,2A,2A,,2" "D,4D,,2" "D,2D,2^F,2" "G,2D,2G,,2" "=E,2z2=E,2" "A,2G,2^F,2" "G,2G,2G,2" "A,2G,2^F,2" "G,2A,2A,,2" "D,2A,G,^F,=E," "D,2=E,2^F,2" "G,2D,2G,,2" "G,2z2G,2" "A,2=E,2A,,2" "G,2G,2G,2" "A,2G,2^F,2" "^C,2D,2G,2" "D,2z^C,A,,^C," "D,2=E,2^F,2" "G,2A,2=B,2" "=E,2^F,2^G,2" "A,2=E,2A,,2" "G,2z2G,2" "A,2G,2^F,2" "G,2A,2A,,2" "D,2A,,2D,,2" "D,2^F,2D,2" "G,2D,2G,,2" "=E,2^F,2^G,2" "A,2=E,2A,,2" "G,2=E,2D,2" "A,2G,2^F,2" "G,2A,2A,,2" "D,2zA,,=B,,^C," "D,2D,2^F,2" "zA,^F,D,G,G,," "G,2G,2G,2" "A,2=E,2A,,2" "zG,=E,D,^C,=B,," "A,2G,2^F,2" "G,2A,2A,,2" "D,4D,,2" "D,2D,2^F,2" "G,2A,2=B,2" "=E,2^F,2^G,2" "z=B,^G,=E,A,A,," "=E,4D,2" "A,2^C,2D,2" "G,2A,2A,,2" "D,2z^C,A,,^C," "D,2D,2^F,2" "G,2A,2=B,2" "G,2G,2G,2" "A,2=E,2A,,2" "G,2z2G,2" "A,2G,2^F,2" "G,4A,2" "D,2A,G,^F,=E," "D,2^F,2D,2" "G,2A,2=B,2" "G,4G,2" "A,2=E,2A,,2" "G,2=E,2D,2" "zA,G,A,D,D," "^C,2=E,2D,2" "D,2A,,2D,,2")
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
filen="ldmt-$fileInd.abc"

#-----------------------------------------------------------------------------------------------------
# calculate permutation number for the current dice toss (from 9^8*9^8 = 1,853,020,188,851,841 possibilities)
# Unique: 9^6*8*7 * 9^7*6 = 854,066,918,318,544 
# part I, measure 4: 2=3; measure 8: 1=5, 2=7
# part II, measure 8: 1=6, 2=7, 4=9
#-----------------------------------------------------------------------------------------------------
# adjust count for bar 4 for rolls beyond 3 (only 8 unique bars)
if [ "${diceS1[3]}" -gt "2" ]; then diceS1_3=${diceS1[3]}-1; fi
# adjust count for bar 8 for rolls after 5 (only 7 unique bars)
if [ "${diceS1[7]}" = "5" ]; then diceS1_7=1; fi
if [ "${diceS1[7]}" = "6" ]; then diceS1_7=5; fi
if [ "${diceS1[7]}" = "7" ]; then diceS1_7=2; fi
if [ "${diceS1[7]}" = "8" ]; then diceS1_7=6; fi
if [ "${diceS1[7]}" = "9" ]; then diceS1_7=7; fi
# adjust count for bar 16 for rolls after 6 (only 6 unique bars)
if [ "${diceS2[7]}" = "6" ]; then diceS2_7=1; fi
if [ "${diceS2[7]}" = "7" ]; then diceS2_7=2; fi
if [ "${diceS2[7]}" = "8" ]; then diceS2_7=6; fi
if [ "${diceS2[7]}" = "9" ]; then diceS2_7=4; fi
dbNum=$(( 1 + (${diceS1[0]}-1) + (${diceS1[1]}-1)*9 + (${diceS1[2]}-1)*9**2 + (${diceS1_3}-1)*9**3 + (${diceS1[4]}-1)*8*9**3 + (${diceS1[5]}-1)*8*9**4 + (${diceS1[6]}-1)*8*9**5 + (${diceS1_7}-1)*8*9**6 + (${diceS2[0]}-1)*8*7*9**6 + (${diceS2[1]}-1)*8*7*9**7 + (${diceS2[2]}-1)*8*7*9**8 + (${diceS2[3]}-1)*8*7*9**9 + (${diceS2[4]}-1)*8*7*9**10 + (${diceS2[5]}-1)*8*7*9**11 + (${diceS2[6]}-1)*8*7*9**12 + (${diceS2_7}-1)*8*7*9**13 ))
echo $dbNum


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
catToFile "%%scale 0.65
%%pagewidth 21.10cm
%%bgcolor white
%%topspace 0
%%composerspace 0
%%leftmargin 0.80cm
%%rightmargin 0.80cm
X:$dbNum
T:${fileInd}
%%setfont-1 Courier-Bold 12
T:\$1ldmt::$measPerm\$0
T:\$1Perm. No.: $dbNum\$0
M:3/4
L:1/8
Q:1/8=120
%%staves [1 2]
V:1 clef=treble
V:2 clef=bass
K:D
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
abcm2ps ./$filen -O ./"ldmt-$fileInd.svg" -g

# create MIDI
abc2midi ./$filen -quiet -silent -o ./"ldmt-$fileInd.mid"
#
##
###
