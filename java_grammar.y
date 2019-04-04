%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex();
	int yyerror();
	extern FILE *yyin;
%}

%token LITERAL COMMA SEMICOLON CBYTE CINT SHORT LONG CHAR FLOAT DOUBLE EXTENDS SUPER CLASS PUBLIC PROTECTED PRIVATE ABSTRACT IMPORT STATIC FINAL FINALLY VOLATILE TRANSIENT BOOLEAN IMPLEMENTS VOID THIS THROWS INTERFACE DEFAULT INSTANCEOF QUESTION IF ELSE NEW CASE SWITCH INTEGER FLOATING CNULL FOR WHILE CCB CBB CB CONTINUE BREAK COLON RETURN CATCH SYNCHRONIZED THROW DO TRY PACKAGE NATIVE STRING
%left LT GT EQUALS
%left EXP MOD
%left PLUS MINUS
%left NOT TILDE
%left AND OR
%left DAND DOR
%left CMUL CDIV
%left SHIFTLEFT SHIFTRIGHT 
%left USHIFTRIGHT
%left INCREMENT DECREMENT
%left Identifier
%left DOT 
%left OBB OB OCB 
%expect 25
%define parse.trace
%%
Goal: CompilationUnit
	; 

Name:	Identifier DOT Name
	|	Identifier
	; 

Literal:	INTEGER
		|	FLOATING
		|	CNULL
		;

Type:	PrimitiveType
	|	ReferenceType
	; 

PrimitiveType: NumericType
			|	BOOLEAN
			; 

NumericType:	IntegralType
			|	FloatingPointType
			; 

IntegralType:	CBYTE
			|	SHORT
			|	CINT 
			|	LONG
			|	CHAR
			|	STRING
			;


FloatingPointType: FLOAT
				|	DOUBLE
				; 

ReferenceType:	ClassOrInterfaceType
			|	ArrayType
			; 

ClassOrInterfaceType: Name
					; 

ClassType:	ClassOrInterfaceType
			; 

InterfaceType:	ClassOrInterfaceType
				; 

ArrayType:	PrimitiveType OBB CBB
		| 	PrimitiveType OBB error { printf("\n Syntax Error, missing paranthesis ") ; }
		| 	PrimitiveType error CBB { printf("\n Syntax Error, missing paranthesis ") ; }
		|	Name OBB CBB
		|	Name OBB error { printf("\n Syntax Error, missing paranthesis ") ; }
		|	ArrayType OBB CBB
		| 	ArrayType OBB error { printf("\n Syntax Error, missing paranthesis ") ; }
		; 



CompilationUnit:	PackageDeclaration ImportDeclarations TypeDeclarations
				| ImportDeclarations TypeDeclarations
				| PackageDeclaration TypeDeclarations
				| TypeDeclarations
				| 
				; 

ImportDeclarations:	ImportDeclaration
				|	ImportDeclarations ImportDeclaration
				; 

TypeDeclarations:	TypeDeclaration
				|	TypeDeclarations TypeDeclaration
				; 

PackageDeclaration:	PACKAGE Name SEMICOLON
				; 
ImportDeclaration:	SingleTypeImportDeclaration
				|	TypeImportOnDemandDeclaration
				; 

SingleTypeImportDeclaration:	IMPORT Name SEMICOLON
					|	IMPORT Name error { printf("\n Missing semicolon ") ; }
					|	IMPORT error SEMICOLON { printf("\n Missing Identifier ") ; }
					; 

TypeImportOnDemandDeclaration:	IMPORT Name DOT CMUL SEMICOLON
					|	IMPORT Name DOT CMUL error { printf("\n Missing semicolon ") ; }
					|	IMPORT Name error CMUL SEMICOLON { printf("\n Missing . ") ; }
					|	IMPORT error DOT CMUL SEMICOLON { printf("\n Missing Identifier ") ; }
					; 
TypeDeclaration:	ClassDeclaration
				|	InterfaceDeclaration
				|	SEMICOLON 
				; 
Modifiers:	Modifier
		|	Modifiers Modifier
		; 

Modifier: PUBLIC 
	|	PROTECTED
	|	PRIVATE
	|	STATIC
	|	ABSTRACT 
	|	FINAL
	|	NATIVE
	|	SYNCHRONIZED
	|	TRANSIENT
	|	VOLATILE
	; 


ClassDeclaration: Modifiers CLASS Identifier Super Interfaces ClassBody
			|	CLASS Identifier Super Interfaces  ClassBody
			|	CLASS Identifier Super ClassBody 
			|	CLASS Identifier Interfaces ClassBody
			| 	CLASS Identifier ClassBody
			| 	Modifiers CLASS Identifier Super ClassBody
			|	Modifiers CLASS Identifier Interfaces ClassBody
			|	Modifiers CLASS Identifier ClassBody
			; 

Super: EXTENDS ClassType
	; 

Interfaces: IMPLEMENTS InterfaceTypeList
			; 

InterfaceTypeList: InterfaceType
				|	InterfaceTypeList COMMA InterfaceType
				; 	

ClassBody:	OCB ClassBodyDeclarations CCB
			| OCB CCB 
	;	

ClassBodyDeclarations:	ClassBodyDeclaration
					|	ClassBodyDeclarations ClassBodyDeclaration
					; 

ClassBodyDeclaration:	ClassMemberDeclaration
					|	StaticInitializer
					|	ConstructorDeclaration
					; 

ClassMemberDeclaration:	FieldDeclaration
					|	MethodDeclaration
					; 

FieldDeclaration:	Modifiers Type VariableDeclarators SEMICOLON
					|	Type VariableDeclarators SEMICOLON
					|	Modifiers Type VariableDeclarators error { printf(" \n Missing semicolon ") ; }
					|	Type VariableDeclarators error { printf(" \n Missing semicolon ") ; }
					; 

VariableDeclarators:	VariableDeclarator
					|	VariableDeclarators COMMA VariableDeclarator
					|	VariableDeclarators COMMA error  { printf(" \n Missing variable, after comma ") ; }
					; 

VariableDeclarator:	VariableDeclaratorId
				|	VariableDeclaratorId EQUALS VariableInitializer
				|	VariableDeclaratorId EQUALS error { printf(" \n Missing variable, after equals ") ; }
				; 

VariableDeclaratorId:	Identifier
					|	VariableDeclaratorId OBB CBB
					|	VariableDeclaratorId OBB error { printf(" \n Missing closing bracket "); }
					; 

VariableInitializer:	Expression
					|	ArrayInitializer
					; 

MethodDeclaration:	MethodHeader MethodBody
					;

MethodHeader:	Modifiers Type MethodDeclarator Throws
			|	Modifiers Type MethodDeclarator
			|	Type MethodDeclarator Throws
			|	Type MethodDeclarator
			|	Modifiers VOID MethodDeclarator Throws
			|	Modifiers VOID MethodDeclarator
			|	VOID Identifier MethodDeclarator Throws
			|	VOID Identifier MethodDeclarator
			|	VOID Identifier OB CB 
			; 

MethodDeclarator:	Identifier OB FormalParameterList CB
				|	Identifier OB CB
				|	MethodDeclarator OBB CBB
				|	Identifier OB error {printf("\n Missing parameters or bracket ") ; }
				; 

FormalParameterList:	FormalParameter
					|	FormalParameterList COMMA FormalParameter
					; 

FormalParameter:	Type VariableDeclaratorId
				; 
Throws:	THROWS ClassTypeList
		; 
ClassTypeList:	ClassType
			|	ClassTypeList COMMA ClassType
			; 

MethodBody:	Block 
		|	SEMICOLON
		; 

StaticInitializer:	STATIC Block
					; 

ConstructorDeclaration:	Modifiers ConstructorDeclarator Throws ConstructorBody
					|	Modifiers ConstructorDeclarator ConstructorBody
					|	ConstructorDeclarator Throws ConstructorBody
					|	ConstructorDeclarator ConstructorBody
					; 

ConstructorDeclarator:	Identifier OB FormalParameterList CB
					| Identifier OB CB
					; 

ConstructorBody:	OCB ExplicitConstructorInvocation BlockStatements CCB
					|	OCB BlockStatements CCB
					|	OCB ExplicitConstructorInvocation CCB
					|	OCB CCB
					; 

ExplicitConstructorInvocation:	THIS OB ArgumentList CB SEMICOLON
							|	THIS OB CB SEMICOLON
							|	SUPER OB ArgumentList CB SEMICOLON
							|	SUPER OB CB SEMICOLON
							|	SUPER OB error { printf("\n missing semicolon"); }
							|	THIS OB error { printf("\n missing semicolon"); }
							; 


InterfaceDeclaration:	Modifiers INTERFACE Identifier ExtendsInterfaces InterfaceBody
						| INTERFACE Identifier ExtendsInterfaces InterfaceBody
						| Modifiers INTERFACE Identifier InterfaceBody
						| INTERFACE Identifier InterfaceBody
						| Modifiers INTERFACE error { printf("\n Bad interface declaration ");}
						; 

ExtendsInterfaces:	EXTENDS InterfaceType
				|	ExtendsInterfaces COMMA InterfaceType
				; 

InterfaceBody:	OCB InterfaceMemberDeclarations CCB
				|	OCB CCB
				|	OCB error {printf("\n Error in Interface Body declaration "); }
				; 

InterfaceMemberDeclarations:	InterfaceMemberDeclaration
							|	InterfaceMemberDeclarations InterfaceMemberDeclaration
							; 
InterfaceMemberDeclaration:	ConstantDeclaration
						|	AbstractMethodDeclaration
						; 

ConstantDeclaration:	FieldDeclaration
					; 

AbstractMethodDeclaration:	MethodHeader SEMICOLON
							| MethodHeader error { printf("\n Missing semicolon") ; }
							; 

ArrayInitializer:	OCB VariableInitializers COMMA CCB
					| OCB COMMA CCB 
					| OCB VariableInitializers CCB 
					| OCB CCB 
					| OCB error {printf("\n Incorrect Array Initialization "); }


VariableInitializers:	VariableInitializer
					|	VariableInitializers COMMA VariableInitializer
					; 

Block:	OCB BlockStatements CCB
		| OCB CCB 
		; 

BlockStatements:	BlockStatement BlockStatements
				| 	BlockStatement
				; 

BlockStatement:	LocalVariableDeclarationStatement
			|	Statement
			; 

LocalVariableDeclarationStatement:	LocalVariableDeclaration SEMICOLON
								; 

LocalVariableDeclaration:	Type VariableDeclarators
							; 

Statement:	StatementWithoutTrailingSubstatement
		|	LabeledStatement
		|	IfThenStatement
		|	IfThenElseStatement
		|	WhileStatement
		|	ForStatement
		; 

StatementNoShortIf:	StatementWithoutTrailingSubstatement
				|	LabeledStatementNoShortIf
				|	IfThenElseStatementNoShortIf
				|	WhileStatementNoShortIf
				|	ForStatementNoShortIf
				; 

StatementWithoutTrailingSubstatement:	Block
									|	EmptyStatement
									|	ExpressionStatement
									|	SwitchStatement
									|	DoStatement
									|	BreakStatement
									|	ContinueStatement
									|	ReturnStatement	
									|	SynchronizedStatement
									|	ThrowStatement
									|	TryStatement
									; 

EmptyStatement: SEMICOLON 
				; 

LabeledStatement:	Identifier COLON Statement
					| Identifier COLON error {printf("\n missing statement ") ; }
					; 

LabeledStatementNoShortIf:	Identifier COLON StatementNoShortIf
						| Identifier COLON error {printf("\n missing statement ") ; }
					; 

ExpressionStatement:	StatementExpression SEMICOLON
					|	StatementExpression error { printf("\n Missing semicolon ") ; }
					; 

StatementExpression:	Assignment
					|	PreIncrementExpression
					|	PreDecrementExpression	
					|	PostIncrementExpression
					|	PostDecrementExpression
					|	MethodInvocation
					|	ClassInstanceCreationExpression
					; 
IfThenStatement:	IF OB Expression CB Statement
					|	IF OB error CB Statement {printf("\n Incorrect Expression "); }
					|	IF error Expression CB Statement { printf("\n Missing bracket"); }
					|	IF OB Expression error Statement { printf("\n Missing bracket"); }
					|	IF OB Expression CB error { printf("\n Missing statement"); }
 					; 

IfThenElseStatement:	IF OB Expression CB StatementNoShortIf ELSE Statement
					|	IF OB error CB StatementNoShortIf ELSE Statement {printf("\n Incorrect Expression "); }
					|	IF error Expression CB StatementNoShortIf ELSE Statement { printf("\n Missing bracket"); }
					|	IF OB Expression error StatementNoShortIf ELSE Statement { printf("\n Missing bracket"); }
					|	IF error Expression CB error ELSE Statement{ printf("\n Missing statement"); }
					| 	IF OB Expression CB StatementNoShortIf ELSE error{ printf("\n Missing else statement"); }
					| 	IF OB Expression CB StatementNoShortIf error Statement{ printf("\n Missing else "); }
						; 

IfThenElseStatementNoShortIf:	IF OB Expression CB StatementNoShortIf ELSE StatementNoShortIf
					|	IF OB error CB StatementNoShortIf ELSE StatementNoShortIf {printf("\n Incorrect Expression "); }
					|	IF error Expression CB StatementNoShortIf ELSE StatementNoShortIf { printf("\n Missing bracket"); }
					|	IF OB Expression error StatementNoShortIf ELSE StatementNoShortIf  { printf("\n Missing bracket"); }
					|	IF error Expression CB error ELSE StatementNoShortIf { printf("\n Missing statement"); }
					| 	IF OB Expression CB StatementNoShortIf ELSE error{ printf("\n Missing else statement"); }
					| 	IF OB Expression CB StatementNoShortIf error StatementNoShortIf { printf("\n Missing else "); }
						; 
						; 

SwitchStatement:	SWITCH OB Expression CB SwitchBlock
					|	SWITCH error Expression CB SwitchBlock { printf("\n Missing bracket") ; }
					|	SWITCH OB Expression error SwitchBlock { printf("\n Missing bracket") ; }
					; 

SwitchBlock:	OCB SwitchBlockStatementGroups SwitchLabels CCB	
				| OCB SwitchBlockStatementGroups CCB	
				| OCB SwitchLabels CCB	
				| OCB CCB 
				| OCB error { printf ("Missing closing bracket"); }	
				;

SwitchBlockStatementGroups:	SwitchBlockStatementGroup
						|	SwitchBlockStatementGroups SwitchBlockStatementGroup
						; 

SwitchBlockStatementGroup:	SwitchLabels BlockStatements
							; 
SwitchLabels:	SwitchLabel
			|	SwitchLabels SwitchLabel
			;  					

SwitchLabel:	CASE ConstantExpression COLON
			|	CASE ConstantExpression error {printf (" \n missing colon") ; }
			|	DEFAULT COLON
			|	DEFAULT error {printf (" \n missing colon") ; }
			; 

WhileStatement:	WHILE OB Expression CB Statement
				|	WHILE error Expression CB Statement { printf (" missing bracket"); }
				|	WHILE OB Expression error Statement { printf (" missing bracket"); }
				; 

WhileStatementNoShortIf:	WHILE OB Expression CB StatementNoShortIf
						; 
DoStatement:	DO Statement WHILE OB Expression CB SEMICOLON
				; 
ForStatement:	FOR OB ForInit SEMICOLON Expression SEMICOLON ForUpdate CB Statement
			| FOR OB SEMICOLON Expression SEMICOLON ForUpdate CB Statement
			| FOR OB ForInit SEMICOLON Expression SEMICOLON CB Statement
			| FOR OB ForInit SEMICOLON SEMICOLON ForUpdate CB Statement
			| FOR OB ForInit SEMICOLON SEMICOLON CB Statement
			| FOR OB SEMICOLON SEMICOLON ForUpdate CB Statement
			| FOR OB SEMICOLON Expression SEMICOLON CB Statement
			| FOR OB SEMICOLON SEMICOLON CB Statement
			| FOR OB ForInit error Expression SEMICOLON ForUpdate CB Statement { printf("\n Missing semicolon"); }
			| FOR OB ForInit SEMICOLON Expression error ForUpdate CB Statement { printf("\n Missing semicolon"); }	
			; 

ForStatementNoShortIf:	FOR OB ForInit SEMICOLON Expression SEMICOLON ForUpdate CB StatementNoShortIf
					| FOR OB SEMICOLON Expression SEMICOLON ForUpdate CB StatementNoShortIf
					| FOR OB ForInit SEMICOLON Expression SEMICOLON CB StatementNoShortIf
					| FOR OB ForInit SEMICOLON SEMICOLON ForUpdate CB StatementNoShortIf
					| FOR OB ForInit SEMICOLON SEMICOLON CB StatementNoShortIf
					| FOR OB SEMICOLON SEMICOLON ForUpdate CB StatementNoShortIf
					| FOR OB SEMICOLON Expression SEMICOLON CB StatementNoShortIf
					| FOR OB SEMICOLON SEMICOLON CB StatementNoShortIf
					| FOR OB ForInit error Expression SEMICOLON ForUpdate CB StatementNoShortIf { printf("\n Missing semicolon"); }
					| FOR OB ForInit SEMICOLON Expression error ForUpdate CB StatementNoShortIf { printf("\n Missing semicolon"); }	
					; 

ForInit:	StatementExpressionList
		|	LocalVariableDeclaration
		; 

ForUpdate:	StatementExpressionList
			; 

StatementExpressionList:	StatementExpression
						|	StatementExpressionList COMMA StatementExpression
						; 

BreakStatement:	BREAK Identifier SEMICOLON
				| BREAK SEMICOLON
				|	BREAK Identifier error {printf (" Missing semicolon ") ; }
				; 
ContinueStatement:	CONTINUE Identifier SEMICOLON
				| CONTINUE SEMICOLON
				|	CONTINUE Identifier error {printf (" Missing semicolon ") ; }
				; 
ReturnStatement:	RETURN Expression SEMICOLON
				| RETURN SEMICOLON
				|	RETURN Expression error {printf (" Missing semicolon ") ; }
				; 

ThrowStatement:	THROW Expression SEMICOLON
				| THROW Expression error {printf (" Missing semicolon ") ; }
				; 
SynchronizedStatement:	SYNCHRONIZED OB Expression CB Block
				; 

TryStatement:	TRY Block Catches
			|	TRY Block Catches Finally
			|	TRY Block Finally
			; 

Catches:	CatchClause
		|	Catches CatchClause
		; 

CatchClause:	CATCH OB FormalParameter CB Block
				; 

Finally:	FINALLY Block
			; 

Primary:	PrimaryNoNewArray	
		|	ArrayCreationExpression
		; 

PrimaryNoNewArray:	Literal
				|	THIS
				|	OB Expression CB
				|	ClassInstanceCreationExpression
				|	FieldAccess
				|	MethodInvocation
				|	ArrayAccess
				; 

ClassInstanceCreationExpression:	NEW ClassType OB ArgumentList CB
								|	NEW ClassType OB CB
								; 

ArgumentList:	Expression
			|	ArgumentList COMMA Expression
			; 

ArrayCreationExpression:	NEW PrimitiveType DimExprs Dims
						|	NEW PrimitiveType DimExprs
						|	NEW ClassOrInterfaceType DimExprs Dims
						|	NEW ClassOrInterfaceType DimExprs 
						; 

DimExprs:	DimExpr
		|	DimExprs DimExpr
		; 

DimExpr:	OBB Expression CBB
			; 

Dims:	OBB CBB
	|	Dims OBB CBB
	; 


MethodInvocation:	Name OB ArgumentList CB
				|	Name OB CB
				|	Name OB LITERAL CB 
				|	Primary DOT Identifier OB ArgumentList CB
				|	Primary DOT Identifier OB CB
				|	SUPER DOT Identifier OB ArgumentList CB
				|	SUPER DOT Identifier OB CB


ArrayAccess:	Name OBB INTEGER CBB
			| 	Name OBB FLOATING CBB
			|	Name OBB Identifier CBB
			|	PrimaryNoNewArray OBB INTEGER  CBB
			|	PrimaryNoNewArray OBB FLOATING CBB 
			|	PrimaryNoNewArray OBB Identifier CBB 
			; 

PostfixExpression:	Primary
				|	Name
				|	PostIncrementExpression
				|	PostDecrementExpression
				; 

PostIncrementExpression:	PostfixExpression INCREMENT
					; 

PostDecrementExpression:	PostfixExpression DECREMENT
					; 

UnaryExpression:	PreIncrementExpression
				|	PreDecrementExpression
				|	PLUS UnaryExpression
				|	MINUS UnaryExpression
				|	UnaryExpressionNotPlusMinus
				; 

PreIncrementExpression:	INCREMENT UnaryExpression
						; 

PreDecrementExpression: DECREMENT UnaryExpression
						; 

UnaryExpressionNotPlusMinus:	PostfixExpression
							|	TILDE UnaryExpression
							|	NOT UnaryExpression
							|	CastExpression
							; 

CastExpression:	OB PrimitiveType Dims CB UnaryExpression
			|	OB PrimitiveType CB UnaryExpression
			|	OB Expression CB UnaryExpressionNotPlusMinus
			|	OB Name Dims CB UnaryExpressionNotPlusMinus
			; 

MultiplicativeExpression:	UnaryExpression
						|	MultiplicativeExpression CMUL UnaryExpression
						|	MultiplicativeExpression CDIV UnaryExpression
						|	MultiplicativeExpression MOD UnaryExpression
						; 
AdditiveExpression:	MultiplicativeExpression
				|	AdditiveExpression PLUS MultiplicativeExpression
				|	AdditiveExpression MINUS MultiplicativeExpression
				; 

ShiftExpression:	AdditiveExpression
				|	ShiftExpression SHIFTLEFT AdditiveExpression
				|	ShiftExpression SHIFTRIGHT AdditiveExpression
				|	ShiftExpression USHIFTRIGHT AdditiveExpression
				; 

RelationalExpression:	ShiftExpression
					|	RelationalExpression LT ShiftExpression
					|	RelationalExpression GT ShiftExpression
					|	RelationalExpression LT EQUALS ShiftExpression
					|	RelationalExpression GT EQUALS ShiftExpression
					|	RelationalExpression INSTANCEOF ReferenceType
					;

EqualityExpression:	RelationalExpression
				|	EqualityExpression EQUALS EQUALS RelationalExpression
				|	EqualityExpression NOT EQUALS RelationalExpression
				; 

AndExpression:	EqualityExpression
			|	AndExpression AND EqualityExpression
			; 

ExclusiveOrExpression:	AndExpression
					|	ExclusiveOrExpression EXP AndExpression
					; 

InclusiveOrExpression:	ExclusiveOrExpression
					|	InclusiveOrExpression OR ExclusiveOrExpression
					; 

ConditionalAndExpression:	InclusiveOrExpression
						|	ConditionalAndExpression DAND InclusiveOrExpression
						; 

ConditionalOrExpression:	ConditionalAndExpression
						|	ConditionalOrExpression DOR ConditionalAndExpression
						; 

ConditionalExpression:	ConditionalOrExpression
					|	ConditionalOrExpression QUESTION Expression COLON ConditionalExpression
					; 

AssignmentExpression:	ConditionalExpression
					|	Assignment
					; 

Assignment:	Name AssignmentOperator ConditionalExpression
			; 


FieldAccess:	Primary DOT Identifier
			|	SUPER DOT Identifier
			; 

AssignmentOperator :	EQUALS
				|	CMUL EQUALS
				|	CDIV EQUALS
				|	MOD EQUALS
				|	PLUS EQUALS
				|	MINUS EQUALS
				|	SHIFTLEFT EQUALS
				|	SHIFTRIGHT EQUALS
				|	USHIFTRIGHT EQUALS
				|	AND  EQUALS
				|	EXP EQUALS
				|	OR EQUALS


Expression:	AssignmentExpression
			; 

ConstantExpression:	Expression
			; 
			
%%

int yyerror(char *msg) {
	printf("\n %s ", msg);
	return 1;
}

void main() {
	yyin = fopen("input.java", "r");
	//yydebug = 1 ; 
	do{
		if( yyparse() ) {
			printf("\nFailure");
			exit(0);
		}
	} while( !feof(yyin) );
	printf("Success");
}