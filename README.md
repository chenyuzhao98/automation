# Automation
The purpose of this project is to use regular expression and the sed function to automate the process of adjusting variables. 

# please refer to netlist.log as template file for the following test cases

# case1: changing the 2nd argument using comma "," as seperator, manually adding the double quotation marks around 'second!'
before:		aele A = write_var("specs.txt","W","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));
after: 		aele A = write_var("specs.txt","second!","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));
./sedfile_auto.sh 'var(' '"second!"' netlist.log newnet.txt 2 ","

# case2: using "," as seperator, but without adding double quotation marks
before:		aele A = write_var("specs.txt","W","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));
after: 		aele A = write_var("specs.txt",second!,"! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));
./sedfile_auto.sh var\( second\! netlist.log newnet.txt 2 ","

# case3: changing the 1st argument (immediately after $1) using space " " as seperator
before: 	MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
after: 		MLIN2:TL18  N__999 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
./sedfile_auto.sh 'MLIN2:TL18  ' 'N__999' netlist.log newnet.txt 1 " "

# case4: please make sure the trailing spacing in $1 must be exact, otherwise it won't work
before: 	MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
after: 		MLIN2:TL18N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
./sedfile_auto.sh 'MLIN2:TL18' 'N__999' netlist.log newnet.txt 1 " "

# case5: please make sure the trailing spacing in $1 must be exact, otherwise it won't work
before: 	MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
after: 		MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1
./sedfile_auto.sh 'MLIN2:TL18    ' 'N__999' netlist.log newnet.txt 1 " "

# case6: changing the 3rd argument after $1
before: 	MLOC2:TL3  N__0 Subst="MSub1" W=30 um L=3270 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
after: 		MLOC2:TL3  N__0 Subst="MSub1" W=999 um L=3270 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1 
./sedfile_auto.sh 'MLOC2:TL3  ' 'W=999' netlist.log newnet.txt 3 " "

# case7: changing the 6th argument after $1
before: 	S2PMDIF:S4  N__11 0 N__10 0 File="fettm_noise.mdf" Type="s2pmdif" InterpMode="linear" InterpDom="ri" ExtrapMode="interpMode" CheckPassivity=0 iVar1=SAMPLE iVal1=sample iVar2="Vds" iVal2=4.0 iVar3="Ids" iVal3=0.02
after:  	S2PMDIF:S4  N__11 0 N__10 0 File="fettm_noise.mdf" Type="CHANGED" InterpMode="linear" InterpDom="ri" ExtrapMode="interpMode" CheckPassivity=0 iVar1=SAMPLE iVal1=sample iVar2="Vds" iVal2=4.0 iVar3="Ids" iVal3=0.02
./sedfile_auto.sh 'S2PMDIF:S4  ' 'Type="CHANGED"' netlist.log newnet.txt 6 " "

# case 8: changing what's immediately after $1
before: 	FET2_L1=261.487 noopt{ 10 to 550 }
after: 		FET2_L1=99.99 noopt{ 10 to 550 }
./sedfile_auto.sh 'FET2_L1=' '99.99' netlist.log newnet.txt 1 " "