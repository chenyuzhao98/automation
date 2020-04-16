# Automation
The purpose of this project is to use regular expression and the sed function to automate the process of adjusting variables. Please refer to netlist.log as template file for the following test cases  

#### Case1: changing the 2nd argument using comma "," as seperator, manually adding the double quotation marks around 'second!'  
###### Before:  
f0 = foo("a","b","c","d")  
###### After:  
f0 = foo("a","second","c","d")  
```
autosed 'foo(' '"second!"' targetfile.txt output.txt 2 ","
```

#### Case2: using "," as seperator, but without adding double quotation marks  
###### Before:  
f1 = foo1(a,b,c,d)  
###### After:  
f1 = foo1(a,b,third!,d)
```
autosed foo1\( third\! targetfile.txt output.txt 3 ","
```

#### Case3: changing the 1st argument (immediately after $1) using space " " as seperator
###### Before:  
f2 = foo2(a b c d)  
###### After:  
f2 = foo2(999 b c d)  
```
autosed 'foo2(' '999' targetfile.txt output.txt 1 " "
```

#### Case4: please make sure the trailing spacing in $1 must be exact, otherwise it won't work
###### Before:  
f3 = foobar( a b c d )
###### After: 		
f3 = foobar( FIRST b c d )
```
autosed 'foobar( ' 'FIRST' targetfile.txt output.txt 1 " "
```

#### Case5: please make sure the trailing spacing in $1 must be exact, otherwise it won't work
###### Before:  
f3 = foobar( a b c d)
###### After: 		
f3 = foobar( a b c d)
```
autosed 'foobar(        ' 'FIRST' targetfile.txt output.txt 1 " "
```

#### Case6: changing the 3rd argument after $1
###### Before:  
FOOBAR:CASE=0 Foo="Foo1" Bar=0
###### After: 		
FOOBAR:CASE=0 Foo="Foo1" Bar="BAR!"
```
autosed 'FOOBAR:' 'Bar="BAR!"' targetfile.txt output.txt 3 " "
```