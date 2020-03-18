#a function to find and replace text in quotes after $1 with $2 in $3 file and save it to $4
#given that it's separated by " , ". e.g: 
# aele A = write_var("specs.txt","W","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));
#could become:
# aele A = write_var("spec_1.txt","W","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));
# replace_string_in_doublequote_after_keyword(){
    # sed 's/\(.*'$1'\)[^,]*\(,.*\)/\1"'$2'"\2/' $3 > $4
# }


# add if statement
# let user choose which arg to alter
# make sure it works on " " as well
# user choose "arg" vs arg

# change first argument
if [ $5 -eq 1 ]
then
	sed 's/\(.*'$1'\)[^,]*\(,.*\)/\1'$2'\2/' $3 > $4
# change second argument
elif [ $5 -eq 2 ]
then
	sed 's/\(.*'$1'\)\([^,]*,\)[^,]*\(,.*\)/\1\2"'$2'"\3/' $3 > $4
# change third argument
elif [ $5 -eq 3 ]
then
	sed 's/\(.*'$1'\)\([^'$6']*'$6'\)\([^'$6']*'$6'\)[^'$6']*\('$6'.*\)/\1\2\3"'$2'"\4/' $3 > $4
fi