# standard input using " " as seperator
# ./sedfile.sh 'var(' 'first!' duplicate.txt newdup.txt 1 " "
# standard input using "," as seperator with double quotes '"'
# ./sedfile.sh 'var(' '"second!"' netlist.log newnet.txt 2 ","

n=$5
s='s/\(.*'$1'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/'
for i in $( eval echo {1..$n} )
do
	s=$s'\'$i
done
s=$s$2'\'$(($n+1))
echo $s