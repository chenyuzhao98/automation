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

####### please refer to netlist.log as template file for the following test cases
# # before: 	aele A = write_var(specs.txt,W,! Freq dB(S21) dB(S22) NF(2),\t);
# # after:		aele A = write_var("spec_1.txt",W,! Freq dB(S21) dB(S22) NF(2),\t);
# ./sedfile_auto.sh 'var(' '"second!"' netlist.log newnet.txt 2 ","

# # before: 	MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
# # after: 		MLIN2:TL18  N__999 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
# ./sedfile_auto.sh 'MLIN2:TL18  ' 'N__999' netlist.log newnet.txt 1 " "

# # before: 	MLOC2:TL3  N__0 Subst="MSub1" W=30 um L=3270 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
# # after: 		MLOC2:TL3  N__0 Subst="MSub1" W=999 um L=3270 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
# ./sedfile_auto.sh 'MLOC2:TL3  ' 'W=999' netlist.log newnet.txt 3 " "

# # before: 	S2PMDIF:S4  N__11 0 N__10 0 File="fettm_noise.mdf" Type="s2pmdif" InterpMode="linear" InterpDom="ri" ExtrapMode="interpMode" CheckPassivity=0 iVar1=SAMPLE iVal1=sample iVar2="Vds" iVal2=4.0 iVar3="Ids" iVal3=0.02
# # after:  	S2PMDIF:S4  N__11 0 N__10 0 File="fettm_noise.mdf" Type="CHANGED" InterpMode="linear" InterpDom="ri" ExtrapMode="interpMode" CheckPassivity=0 iVar1=SAMPLE iVal1=sample iVar2="Vds" iVal2=4.0 iVar3="Ids" iVal3=0.02
# ./sedfile_auto.sh 'S2PMDIF:S4  ' 'Type="CHANGED"' netlist.log newnet.txt 6 " "

# # before: 	FET2_L1=261.487 noopt{ 10 to 550 }
# # after: 		FET2_L1=99.99 noopt{ 10 to 550 }
# ./sedfile_auto.sh 'FET2_L1=' '99.99' netlist.log newnet.txt 1 " "


