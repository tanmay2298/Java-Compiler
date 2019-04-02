%{

	#include <stdio.h>
	#include <stdlib.h>
	#include "yac.tab.h"
%}

%%

"static" {printf("%s\n", yytext); return static;}
"." {printf("%s\n", yytext); return DOT;}
"," {printf("%s\n", yytext); return COMMA;}
";" {printf("%s\n", yytext); return SEMICOLON;}
"package" {printf("%s\n", yytext); return package;}
"import" {printf("%s\n", yytext); return import;}
"void" {printf("%s\n", yytext); return void;}
"final" {printf("%s\n", yytext); return final;}
"+" {printf("%s\n", yytext); return PLUS;}
"*" {printf("%s\n", yytext); return MULTIPLY;}
"/" {printf("%s\n", yytext); return DIVIDE;}
"-" {printf("%s\n", yytext); return MINUS;}
"%" {printf("%s\n", yytext); return MODULUS;}
"^" {printf("%s\n", yytext); return POWER;}
"this" {printf("%s\n", yytext); return this;}
"case" {printf("%s\n", yytext); return case;}
"default" {printf("%s\n", yytext); return default;}
"byte" {printf("%s\n", yytext); return byte;}
"boolean" {printf("%s\n", yytext); return boolean;}
"short" {printf("%s\n", yytext); return short;}
"char" {printf("%s\n", yytext); return char;}
"int" {printf("%s\n", yytext); return int;}
"float" {printf("%s\n", yytext); return float;}
"double" {printf("%s\n", yytext); return double;}
"enum" {printf("%s\n", yytext); return enum;}
"long" {printf("%s\n", yytext); return long;}
"public" {printf("%s\n", yytext); return public;}
"private" {printf("%s\n", yytext); return private;}
"protected" {printf("%s\n", yytext); return protected;}
"abstract" {printf("%s\n", yytext); return abstract;}
"native" {printf("%s\n", yytext); return synchronized;}
"transient" {printf("%s\n", yytext); return transient;}
"volatile" {printf("%s\n", yytext); return volatile;}
"strictfp" {printf("%s\n", yytext); return strictfp;}
"<" {printf("%s\n", yytext); return LT;}
">" {printf("%s\n", yytext); return GT;}
"{" {printf("%s\n", yytext); return LCB;}
"}" {printf("%s\n", yytext); return RCB;}
"[" {printf("%s\n", yytext); return LSB;}
"]" {printf("%s\n", yytext); return RSB;}
"(" {printf("%s\n", yytext); return LRB;}
")" {printf("%s\n", yytext); return RRB;}
"?" {printf("%s\n", yytext); return QUESIONMARK;}
"&" {printf("%s\n", yytext); return AND;}
"|" {printf("%s\n", yytext); return OR;}
"<<" {printf("%s\n", yytext); return LEFTSHIFT;}
">>" {printf("%s\n", yytext); return RIGHTSHIFT;}
">>>" {printf("%s\n", yytext); return UNSIGNED_RIGHTSHIFT;}
"<=" {printf("%s\n", yytext); return LTE;}
">=" {printf("%s\n", yytext); return GTE;}
"for" {printf("%s\n", yytext); return for;}
"if" {printf("%s\n", yytext); return if;}
"else" {printf("%s\n", yytext); return else;}
"switch" {printf("%s\n", yytext); return switch;}
"while" {printf("%s\n", yytext); return while;}
"do" {printf("%s\n", yytext); return do;}
"break" {printf("%s\n", yytext); return break;}
"continue" {printf("%s\n", yytext); return continue;}
":" {printf("%s\n", yytext); return COLON;}
"throw" {printf("%s\n", yytext); return throw;}
"finally" {printf("%s\n", yytext); return finally;}
"=" {printf("%s\n", yytext); return EQUALS;}
"@" {printf("%s\n", yytext); return ATTHERATE;}
"~" {printf("%s\n", yytext); return TILD;}
"catch" {printf("%s\n", yytext); return catch;}
"return" {printf("%s\n", yytext); return RETURN;}
"throws" {printf("%s\n", yytext); return throws;}
"interface" {printf("%s\n", yytext); return throws;}
"new" {printf("%s\n", yytext); return new;}
"try" {printf("%s\n", yytext); return try;}
"super" {printf("%s\n", yytext); return super;}
"instanceof" {printf("%s\n", yytext); return instanceof;}
"!" {printf("%s\n", yytext); return NOT;}
"assert" {printf("%s\n", yytext); return assert;}
"extends" {printf("%s\n", yytext); return extends;}
"class" {printf("%s\n", yytext); return class;}
"implements" {printf("%s\n", yytext); return implements;}
[0-9]* {printf("%s\n", yytext); return IntegerLiteral;}
[0-9]*.[0-9]* {printf("%s\n", yytext); return FloatingPointLiteral;}
"true"|"false" {printf("%s\n", yytext); return BooleanLiteral;}
"[a-zA-Z]" {printf("%s\n", yytext); return CharacterLiteral;}
"[a-zA-Z][a-zA-Z]+" {printf("%s\n", yytext); return StringLiteral;}
"NULL" {printf("%s\n", yytext); return NullLiteral;}
[a-zA-Z][a-zA-Z_]* {printf("%s\n", yytext); return IDENTIFIER;}
\n|\t|" " {printf("%s\n", yytext);}

%%
int yywrap()
{
	return 1;
}