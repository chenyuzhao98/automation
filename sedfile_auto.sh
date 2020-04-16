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
autosed 'foo(' '"second!"' targetfile.txt output.txt 2 ","
# autosed foo1\( third\! targetfile.txt output.txt 3 ","
# autosed 'foo2(' '999' targetfile.txt output.txt 1 " "
# autosed 'foobar( ' 'FIRST' targetfile.txt output.txt 1 " "
# autosed 'foobar(			' 'FIRST' targetfile.txt output.txt 1 " "
# autosed 'FOOBAR:' 'Bar="BAR!"' targetfile.txt output.txt 3 " "
