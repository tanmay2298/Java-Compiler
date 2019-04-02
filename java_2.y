%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex();
	int yyerror();
	extern FILE *yyin;
%}

%token DOT COMMA SEMICOLON CBYTE CINT SHORT LONG CHAR FLOAT DOUBLE EXTENDS SUPER CLASS PUBLIC PROTECTED PRIVATE ABSTRACT IMPORT STATIC FINAL FINALLY STRICTPF VOLATILE TRANSIENT BOOLEAN IMPLEMENTS VOID identifier THIS THROWS INTERFACE DEFAULT ATRATE INSTANCEOF QUESTION IF ELSE ASSERT NEW CASE SWITCH REF OR DIV EXP AND CMUL LT GT TILDE NOT Identifier CHARACTERS INTEGER FLOATING CNULL FOR WHILE PLUS MINUS OCB OBB OB CCB CBB CB EQUALS MOD ENUM CONTINUE BREAK COLON RETURN CATCH SYNCHRONIZED THROW DO TRY PACKAGE NATIVE
%%
Goal: CompilationUnit
	; 

Literal:	INTEGER
		|	FLOATING
		|	BOOLEAN
		|	Identifier
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
		|	Name OBB CBB
		|	ArrayType OBB CBB
		; 

Name:	SimpleName
	|	QualifiedName
	; 

SimpleName:	Identifier
			; 

QualifiedName:	Name DOT Identifier
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
					; 

TypeImportOnDemandDeclaration:	IMPORT Name DOT CMUL SEMICOLON

TypeDeclaration:	ClassDeclaration
				|	InterfaceDeclaration
				|	SEMICOLON 

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

ClassBodyDeclarations:	ClassBodyDeclarations
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
					; 

VariableDeclarators:	VariableDeclarator
					|	VariableDeclarators COMMA VariableDeclarator
					; 

VariableDeclarator:	VariableDeclaratorId
				|	VariableDeclaratorId EQUALS VariableInitializer
				; 

VariableDeclaratorId:	Identifier
					|	VariableDeclaratorId OBB CBB
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
			|	Modifiers VOID Identifier MethodDeclarator Throws
			|	Modifiers VOID Identifier MethodDeclarator
			|	VOID Identifier MethodDeclarator Throws
			|	VOID Identifier MethodDeclarator
			; 

MethodDeclarator:	Identifier OB FormalParameterList CB
				|	Identifier OB CB
				|	MethodDeclarator OBB CBB
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

ConstructorDeclarator:	SimpleName OB FormalParameterList CB
					| SimpleName OB CB
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
							; 


InterfaceDeclaration:	Modifiers INTERFACE Identifier ExtendsInterfaces InterfaceBody
						| INTERFACE Identifier ExtendsInterfaces InterfaceBody
						| Modifiers INTERFACE Identifier InterfaceBody
						| INTERFACE Identifier InterfaceBody
						; 

ExtendsInterfaces:	EXTENDS InterfaceType
				|	ExtendsInterfaces COMMA InterfaceType
				; 

InterfaceBody:	OCB InterfaceMemberDeclarations CCB
				|	OCB CCB
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
							; 

ArrayInitializer:	OCB VariableInitializers COMMA CCB
					| OCB COMMA CCB 
					| OCB VariableInitializers CCB 
					| OCB CCB 

VariableInitializers:	VariableInitializer
					|	VariableInitializers COMMA VariableInitializer
					; 

Block:	OCB BlockStatements CCB
		| OCB CCB 
		; 

BlockStatements:	BlockStatement
				|	BlockStatements BlockStatement
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
					; 

LabeledStatementNoShortIf:	Identifier COLON StatementNoShortIf
					; 

ExpressionStatement:	StatementExpression SEMICOLON
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
					; 

IfThenElseStatement:	IF OB Expression CB StatementNoShortIf ELSE Statement
						; 

IfThenElseStatementNoShortIf:	IF OB Expression CB StatementNoShortIf ELSE StatementNoShortIf
						; 

SwitchStatement:	SWITCH OB Expression CB SwitchBlock
					; 

SwitchBlock:	OCB SwitchBlockStatementGroups SwitchLabels CCB	
				| OCB SwitchBlockStatementGroups CCB	
				| OCB SwitchLabels CCB	
				| OCB CCB 
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
			|	DEFAULT COLON
			; 

WhileStatement:	WHILE OB Expression CB Statement
				; 

WhileStatementNoShortIf:	WHILE OB Expression CB StatementNoShortIf
						; 
DoStatement:	DO Statement WHILE OB Expression CB SEMICOLON
				; 
ForStatement:	FOR OB ForInit SEMICOLON Expression SEMICOLON ForUpdate CB
			| FOR OB SEMICOLON Expression SEMICOLON ForUpdate CB
			| FOR OB ForInit SEMICOLON Expression SEMICOLON CB
			| FOR OB ForInit SEMICOLON SEMICOLON ForUpdate CB
			| FOR OB ForInit SEMICOLON SEMICOLON CB
			| FOR OB SEMICOLON SEMICOLON ForUpdate CB
			| FOR OB SEMICOLON Expression SEMICOLON CB
			| FOR OB SEMICOLON SEMICOLON CB
			|	Statement
			; 

ForStatementNoShortIf:	FOR OB ForInit SEMICOLON Expression SEMICOLON ForUpdate CB
					| FOR OB SEMICOLON Expression SEMICOLON ForUpdate CB
					| FOR OB ForInit SEMICOLON Expression SEMICOLON CB
					| FOR OB ForInit SEMICOLON SEMICOLON ForUpdate CB
					| FOR OB ForInit SEMICOLON SEMICOLON CB
					| FOR OB SEMICOLON SEMICOLON ForUpdate CB
					| FOR OB SEMICOLON Expression SEMICOLON CB
					| FOR OB SEMICOLON SEMICOLON CB
					| StatementNoShortIf
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
				; 
ContinueStatement:	CONTINUE Identifier SEMICOLON
				| CONTINUE SEMICOLON
				; 
ReturnStatement:	RETURN Expression SEMICOLON
				| RETURN SEMICOLON
				; 

ThrowStatement:	THROW Expression SEMICOLON
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

FieldAccess:	Primary DOT Identifier
			|	SUPER DOT Identifier
			; 

MethodInvocation:	Name OB ArgumentList CB
				|	Name OB CB
				|	Primary DOT Identifier OB ArgumentList CB
				|	Primary DOT Identifier OB CB
				|	SUPER DOT Identifier OB ArgumentList CB
				|	SUPER DOT Identifier OB CB

ArrayAccess:	Name OBB Expression CBB
			|	PrimaryNoNewArray OBB Expression CBB
			; 

PostfixExpression:	Primary
				|	Name
				|	PostIncrementExpression
				|	PostDecrementExpression
				; 

PostIncrementExpression:	PostfixExpression PLUS PLUS
					; 

PostDecrementExpression:	PostfixExpression MINUS MINUS
					; 

UnaryExpression:	PreIncrementExpression
				|	PreDecrementExpression
				|	PLUS UnaryExpression
				|	MINUS UnaryExpression
				|	UnaryExpressionNotPlusMinus
				; 

PreIncrementExpression:	PLUS PLUS UnaryExpression
						; 

PreDecrementExpression:	MINUS MINUS UnaryExpression
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
						|	MultiplicativeExpression DIV UnaryExpression
						|	MultiplicativeExpression MOD UnaryExpression
						; 
AdditiveExpression:	MultiplicativeExpression
				|	AdditiveExpression PLUS MultiplicativeExpression
				|	AdditiveExpression MINUS MultiplicativeExpression
				; 

ShiftExpression:	AdditiveExpression
				|	ShiftExpression LT LT AdditiveExpression
				|	ShiftExpression GT GT AdditiveExpression
				|	ShiftExpression GT GT GT AdditiveExpression
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
						|	ConditionalAndExpression AND AND InclusiveOrExpression
						; 

ConditionalOrExpression:	ConditionalAndExpression
						|	ConditionalOrExpression OR OR ConditionalAndExpression
						; 

ConditionalExpression:	ConditionalOrExpression
					|	ConditionalOrExpression QUESTION Expression COLON ConditionalExpression
					; 

AssignmentExpression:	ConditionalExpression
					|	Assignment
					; 

Assignment:	LeftHandSide AssignmentOperator AssignmentExpression
			; 

LeftHandSide:	Name
			|	FieldAccess
			|	ArrayAccess
			; 

AssignmentOperator :	EQUALS
				|	CMUL EQUALS
				|	DIV EQUALS
				|	MOD EQUALS
				|	PLUS EQUALS
				|	MINUS EQUALS
				|	LT LT EQUALS
				|	GT GT EQUALS
				|	GT GT GT EQUALS
				|	AND  EQUALS
				|	EXP EQUALS
				|	OR EQUALS


Expression:	AssignmentExpression
			; 

ConstantExpression:	Expression
			; 
			
%%

int yyerror(char *msg) {
	printf("Invalid Expression\n");
	return 1;
}

void main() {
	yyin = fopen("input.java", "r");
	do{
		if( yyparse() ) {
			printf("\nFailure");
			exit(0);
		}
	} while( !feof(yyin) );
	printf("Success");
}