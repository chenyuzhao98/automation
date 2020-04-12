#!/bin/bash

function autosed {
	if [ $5 -eq 1 ]
	then
		a=''
	else
		a='\([^'$6']*'$6'\)'
	fi

	n=$5

	s='s/\(.*'$1'\)'

	s=$s$a

	for (( c=3; c<=$5; c++ ))
	do
		s=$s$a
	done

	s=$s'[^'$6']*\('$6'.*\)/'

	for i in $( eval echo {1..$n} )
	do
		s=$s'\'$i
	done

	s=$s$2'\'$(($n+1))'/'

	sed "$s" $3 > $4
	# to modify the original file (with backup)
	# sed -i .bak "$s" $3
}

# Please refer to README for test case explanation
autosed 'var(' '"second!"' netlist.log newnet.txt 2 ","
# autosed var\( second\! netlist.log newnet.txt 2 ","
# autosed 'MLIN2:TL18  ' 'N__999' netlist.log newnet.txt 1 " "
# autosed 'MLIN2:TL18' 'N__999' netlist.log newnet.txt 1 " "
# autosed 'MLIN2:TL18    ' 'N__999' netlist.log newnet.txt 1 " "
# autosed 'MLOC2:TL3  ' 'W=999' netlist.log newnet.txt 3 " "
# autosed 'S2PMDIF:S4  ' 'Type="CHANGED"' netlist.log newnet.txt 6 " "
# autosed 'FET2_L1=' '99.99' netlist.log newnet.txt 1 " "