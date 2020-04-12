# Automation
The purpose of this project is to use regular expression and the sed function to automate the process of adjusting variables. Please refer to netlist.log as template file for the following test cases  

#### Case1: changing the 2nd argument using comma "," as seperator, manually adding the double quotation marks around 'second!'  
Before:		aele A = write_var("specs.txt","W","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));<br/>
After: 		aele A = write_var("specs.txt","second!","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));<br/>
```
autosed 'var(' '"second!"' netlist.log newnet.txt 2 ","
```

#### Case2: using "," as seperator, but without adding double quotation marks  
Before:		aele A = write_var("specs.txt","W","! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));<br/>
After: 		aele A = write_var("specs.txt",second!,"! Freq dB(S21) dB(S22) NF(2)","\t", , , freq,dB(S21),dB(S11),nf(2));<br/>
```
autosed var\( second\! netlist.log newnet.txt 2 ","  
```

#### Case3: changing the 1st argument (immediately after $1) using space " " as seperator
Before: 	MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1<br/>
After: 		MLIN2:TL18  N__999 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1<br/>
```
autosed 'MLIN2:TL18  ' 'N__999' netlist.log newnet.txt 1 " "
```

#### Case4: please make sure the trailing spacing in $1 must be exact, otherwise it won't work
Before: 	MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1<br/>
After: 		MLIN2:TL18N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1<br/>
```
autosed 'MLIN2:TL18' 'N__999' netlist.log newnet.txt 1 " "
```

#### Case5: please make sure the trailing spacing in $1 must be exact, otherwise it won't work
Before: 	MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1<br/>
After: 		MLIN2:TL18  N__4 N__1 Subst="MSub1" W=10 um L=FET1_L3 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1<br/>
```
autosed 'MLIN2:TL18    ' 'N__999' netlist.log newnet.txt 1 " "
```

#### Case6: changing the 3rd argument after $1
Before: 	MLOC2:TL3  N__0 Subst="MSub1" W=30 um L=3270 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1<br/>
After: 		MLOC2:TL3  N__0 Subst="MSub1" W=999 um L=3270 um Wall1=2.5e+025 meter Wall2=2.5e+025 meter Mod=1<br/>
```
autosed 'MLOC2:TL3  ' 'W=999' netlist.log newnet.txt 3 " "
```

#### Case7: changing the 6th argument after $1
Before: 	S2PMDIF:S4  N__11 0 N__10 0 File="fettm_noise.mdf" Type="s2pmdif" InterpMode="linear" InterpDom="ri" ExtrapMode="interpMode" CheckPassivity=0 iVar1=SAMPLE iVal1=sample iVar2="Vds" iVal2=4.0 iVar3="Ids" iVal3=0.02<br/>
After:  	S2PMDIF:S4  N__11 0 N__10 0 File="fettm_noise.mdf" Type="CHANGED" InterpMode="linear" InterpDom="ri" ExtrapMode="interpMode" CheckPassivity=0 iVar1=SAMPLE iVal1=sample iVar2="Vds" iVal2=4.0 iVar3="Ids" iVal3=0.02<br/>
```
autosed 'S2PMDIF:S4  ' 'Type="CHANGED"' netlist.log newnet.txt 6 " "
```
#### Case 8: changing what's immediately after $1
Before: 	FET2_L1=261.487 noopt{ 10 to 550 }<br/>
After: 		FET2_L1=99.99 noopt{ 10 to 550 }<br/>
```
autosed 'FET2_L1=' '99.99' netlist.log newnet.txt 1 " "
```