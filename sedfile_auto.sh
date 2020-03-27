if [ $5 -eq 1 ]
then
	a=''
else
	a='\([^'$6']*'$6'\)'
fi

n=$5

s='s/\(.*'$1'\)'

s=$s$a

# for i in $( eval echo {0..$(($n-3))} )
# for i in {1..$5}
for (( c=3; c<=$5; c++ ))
do
	s=$s$a
	# echo $s
done

s=$s'[^'$6']*\('$6'.*\)/'

for i in $( eval echo {1..$n} )
do
	s=$s'\'$i
done
s=$s$2'\'$(($n+1))'/'

sed "$s" $3 > $4



# # Tests for auto generated regex

# # auto generated output
# echo $s

# # target: change first argument
# echo 's/\(.*'$1'\)[^'$6']*\('$6'.*\)/\1'$2'\2/'

# # target: change second argument
# echo 's/\(.*'$1'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/\1\2'$2'\3/'

# # change third argument
# echo 's/\(.*'$1'\)\([^'$6']*'$6'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/\1\2\3'$2'\4/'

# # change the fourth argument
# echo 's/\(.*'$1'\)\([^'$6']*'$6'\)\([^'$6']*'$6'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/\1\2\3\4'$2'\5/'

# # standard input using " " as seperator
# ./sedfile_auto.sh 'var(' 'first!' duplicate.txt newdup.txt 1 " "

# # standard input using "," as seperator with double quotes '"'
# ./sedfile_auto.sh 'var(' '"second!"' netlist.log newnet.txt 2 ","
