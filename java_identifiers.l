%{

	#include <stdio.h>
	#include <stdlib.h>
	#include "java_grammar.tab.h"
%}

%% 
"//".*\n { printf("Ignore Comments "); } 
"/*".*"*/" { printf("Ignore Comments "); } 
"." { printf("\n . "); return DOT ; }
";" { printf("\n ; "); return SEMICOLON ; }
":" { printf("\n : "); return COLON ; }
"++" { printf("\n ++ "); return INCREMENT ; }
"--" { printf("\n -- "); return DECREMENT ; }
"+" { printf("\n + "); return PLUS ; }
"-" { printf("\n - "); return MINUS ; }
"*" { printf("\n * "); return CMUL ; }
"/" { printf("\n / "); return CDIV ; }
"||" { printf("\n DOR "); return DOR ; }
"|" { printf("\n OR "); return OR ; }
"&&" { printf("\n && "); return DAND ; }
"&" { printf("\n & "); return AND ; }
"<<" { printf("\n << "); return SHIFTLEFT ; }
">>>" { printf("\n >>> "); return USHIFTRIGHT ; }
">>" { printf("\n >> "); return SHIFTRIGHT ; }
"<" { printf("\n < "); return LT ; }
">" { printf("\n > "); return GT ; }
"~" { printf("\n ~ "); return TILDE ; }
"!" { printf("\n ! "); return NOT ; }
"^" { printf("\n ^ "); return EXP ; }
"?" { printf("\n ? "); return QUESTION ; }
"=" { printf("\n = "); return EQUALS ; }
"%" { printf("\n Modulus "); return MOD ; }

"byte" { printf("\n byte "); return CBYTE ; }
"String" { printf("\n string "); return STRING ; }
"int" { printf("\n int "); return CINT ; }
"short" { printf("\n short "); return SHORT ; }
"long" { printf("\n long "); return LONG ; }
"char" { printf("\n char "); return CHAR ; }
"break" { printf("\n break "); return BREAK ;}
"continue" { printf("\n continue "); return CONTINUE ;}
"float" { printf("\n float "); return FLOAT ; }
"double" { printf("\n double "); return DOUBLE ; }
"do" { printf("\n do "); return DO ; }
"try" { printf("\n try "); return TRY ; }
"package" { printf("\n package "); return PACKAGE ;  }
"native" {printf("\n native "); return NATIVE ; }
"extends" { printf("\n extends "); return EXTENDS ; }
"super" { printf("\n super "); return SUPER ; }
"class" { printf("\n class "); return CLASS ; }
"public" { printf("\n public "); return PUBLIC ; }
"private" { printf("\n private "); return PRIVATE ; }
"protected" { printf("\n protected "); return PROTECTED ; }
"catch" { printf("\n catch") ; return CATCH;} 
"synchronized" { printf("\n synchronized") ; return SYNCHRONIZED;} 
"throw" {printf("\n throw") ; return THROW;}
"abstract" { printf("\n abstract "); return ABSTRACT ; }
"static" { printf("\n static "); return STATIC ; }
"import" { printf("\n import "); return IMPORT ; }
"final" { printf("\n final "); return FINAL ; }
"finally" { printf("\n finally "); return FINALLY ; }
"volatile" { printf("\n volatile "); return VOLATILE ; }
"transient" { printf("\n transient "); return TRANSIENT ; }
"return" {  printf("\n return "); return RETURN ; }
"implements" { printf("\n implements "); return IMPLEMENTS ; }
"instanceof" { printf("\n instanceof "); return INSTANCEOF ; }
"void" { printf("\n void "); return VOID ; }
"default" { printf("\n default "); return DEFAULT ; }
"throws" { printf("\n throws "); return THROWS ; }
"this" { printf("\n this "); return THIS ; }
"interface" { printf("\n interface "); return INTERFACE ; }
"new" { printf("\n new "); return NEW ; }
"if" { printf("\n if "); return IF; }
"else" { printf("\n else "); return ELSE ; }
"case" { printf("\n case "); return CASE ; }
"switch" { printf("\n switch "); return SWITCH ; }
"for" { printf("\n for "); return FOR ; }
"while" { printf("\n while "); return WHILE ; }
"null" { printf("\n null "); return CNULL ; }

"true"|"false" { printf("\n %s" , yytext) ; return BOOLEAN ;}
"[" { printf("\n [ "); return OBB ; }
"{" { printf("\n { "); return OCB ; }
"(" { printf("\n ( "); return OB ; }
")" { printf("\n ) "); return CB ; }
"}" { printf("\n } "); return CCB ; }
"]" { printf("\n ] "); return CBB ; }
 
[0-9]+ { printf("\n %s" , yytext) ; return INTEGER ; }
[0-9]+"."[0-9]+ { printf("\n %s" , yytext) ; return FLOATING ; }
[a-zA-Z]+ { printf("\n %s" , yytext) ; return Identifier ; }

%%
int yywrap() {
	return 1 ; 
}	