# #a function to find and replace text in quotes after $1 with $2 in $3 file and save it to $4
# #given that it's separated by " , ". e.g: 
# # aele A = write_var("specs.txt","W","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));
# #could become:
# # aele A = write_var("spec_1.txt","W","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));
# # replace_string_in_doublequote_after_keyword(){
#     # sed 's/\(.*'$1'\)[^,]*\(,.*\)/\1"'$2'"\2/' $3 > $4
# # }

# standard input using " " as seperator
# ./sedfile.sh 'var(' 'first!' duplicate.txt newdup.txt 1 " "
# standard input using "," as seperator with double quotes '"'
# ./sedfile.sh 'var(' '"second!"' netlist.log newnet.txt 2 ","

# # change first argument
# if [ $5 -eq 1 ]
# then
# 	if [[ $6 = [[:space:]] ]]
# 	then
# 		sed 's/\(.*'$1'\)[^ ]*\( .*\)/\1'$2'\2/' $3 > $4
# 	else
# 		sed 's/\(.*'$1'\)[^'$6']*\('$6'.*\)/\1'$2'\2/' $3 > $4
# 	fi


# if [[ $6 = [[:space:]] ]]
# then
# 	sed 's/\(.*'$1'\)\([^ ]* \)[^ ]*\( .*\)/\1\2'$2'\3/' $3 > $4
# else
# 	s='s/\(.*'$1'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/\1\2'$2'\3/' 
# 	# sed s $3 > $4
# 	echo $s
# fi
n=$5
s='s/\(.*'$1'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/'
for i in $( eval echo {1..$n} )
do
	s=$s'\'$i
done
s=$s$2'\'$(($n+1))
echo $s
# use for loop in bash & concat

# # change third argument
# elif [ $5 -eq 3 ]
# then
# 	if [[ $6 = [[:space:]] ]]
# 	then
# 		sed 's/\(.*'$1'\)\([^ ]* \)\([^ ]* \)[^ ]*\( .*\)/\1\2\3'$2'\4/' $3 > $4
# 	else
# 		sed 's/\(.*'$1'\)\([^'$6']*'$6'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/\1\2\3'$2'\4/' $3 > $4
# 	fi

# # change the fourth argument
# elif [ $5 -eq 4 ]
# then
# 	if [[ $6 = [[:space:]] ]]
# 	then
# 		sed 's/\(.*'$1'\)\([^ ]* \)\([^ ]* \)\([^ ]* \)[^ ]*\( .*\)/\1\2\3\4'$2'\5/' $3 > $4
# 	else
# 		sed 's/\(.*'$1'\)\([^'$6']*'$6'\)\([^'$6']*'$6'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/\1\2\3\4'$2'\5/' $3 > $4
# 	fi
# fi