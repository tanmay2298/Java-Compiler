# Java-Compiler

Implemented using bison and flex. 
Basic error recovery strategy implemented as well. 
Missing semicolons in for statements, are detected, missing paranthesis are taken care of. 

To run, 

bison -d java_grammar.c
flex java_identifiers.l
gcc java_grammar.c lex.yy.c -o run
./run 

Make changes in the file input.java, and keep running ./run to keep checking new files.
