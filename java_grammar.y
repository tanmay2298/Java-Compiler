%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex();
	int yyerror();
	extern FILE *yyin;
%}

%token DOT COMMA SEMICOLON CBYTE CINT SHORT LONG CHAR FLOAT DOUBLE EXTENDS SUPER CLASS PUBLIC PROTECTED PRIVATE ABSTRACT IMPORT STATIC FINAL FINALLY STRICTPF VOLATILE TRANSIENT BOOLEAN IMPLEMENTS VOID THIS THROWS INTERFACE DEFAULT ATRATE INSTANCEOF QUESTION IF ELSE ASSERT NEW CASE SWITCH REF OR DIV EXP AND MUL LT GT TILDE NOT ID CHARACTERS INTEGER FLOATING CNULL FOR WHILE PLUS MINUS OCB OBB OB CCB CBB CB EQUALS MOD ENUM CONTINUE BREAK COLON RETURN CATCH SYNCHRONIZED THROW DO TRY PACKAGE NATIVE
%% 
// Packages 

CompilationUnit :	OBB PackageDeclaration CBB OCB ImportDeclaration CCB OCB TypeDeclaration CCB
					;

PackageDeclaration :	OCB PackageModifier CCB PACKAGE Identifier OCB  DOT Identifier CCB SEMICOLON
					;
PackageModifier :	Annotation
					; 
ImportDeclaration :	SingleTypeImportDeclaration
				|	TypeImportOnDemandDeclaration
				|	SingleStaticImportDeclaration
				|	StaticImportOnDemandDeclaration
				;

SingleTypeImportDeclaration :	IMPORT TypeName SEMICOLON
								; 

TypeImportOnDemandDeclaration :	IMPORT TypeName DOT MUL SEMICOLON
								; 

SingleStaticImportDeclaration :	IMPORT STATIC TypeName DOT Identifier SEMICOLON
								; 

StaticImportOnDemandDeclaration :	IMPORT STATIC TypeName DOT MUL SEMICOLON
									; 

TypeDeclaration :	ClassDeclaration
				|	InterfaceDeclaration
				|	SEMICOLON
				;

// Lexical Structure 

Literal :	INTEGER
		|	FLOATING
		|	BOOLEAN
		|	ID
		|	CNULL
		;

Identifier : ID 
			; 

// Types COMMA Values and Variables 

PrimitiveType :	OCB Annotation CCB NumericType
			|	OCB Annotation CCB BOOLEAN
			;

NumericType :	IntegralType
			|	FloatingPointType
			;

IntegralType :	CBYTE
			|	SHORT
			|	CINT 
			|	LONG
			|	CHAR
			;

FloatingPointType : FLOAT 
				|	 DOUBLE 
				;

ReferenceType :	ClassType
			|	TypeVariable
			|	ArrayType
			;



ClassType :		OCB Annotation CCB Identifier OBB TypeArguments OCB
			|	ClassType DOT OCB Annotation CCB Identifier OBB TypeArguments OCB
			;


TypeVariable :	OCB Annotation CCB Identifier
			;

ArrayType :		PrimitiveType Dims
			|	ClassType Dims
			|	TypeVariable Dims 
			;

Dims :	OCB Annotation CCB OBB CBB OCB OCB Annotation CCB OBB CBB CCB
		; 

TypeParameter :	OCB TypeParameterModifier CCB Identifier OBB TypeBound CBB
			; 

TypeParameterModifier :	Annotation
			;

TypeBound :	EXTENDS TypeVariable
		|	EXTENDS ClassType OCB AdditionalBound CCB
		;

AdditionalBound :	AND ClassType
		;

TypeArguments :	LT TypeArgumentList GT

TypeArgumentList :	TypeArgument OCB  COMMA TypeArgument CCB

TypeArgument :	ReferenceType
		|	Wildcard
		;


Wildcard :	OCB Annotation CCB QUESTION OBB WildcardBounds CBB

WildcardBounds :	EXTENDS ReferenceType
			|	SUPER ReferenceType
			;


// Names 

TypeName :	Identifier
		|	TypeName DOT Identifier
		;

ExpressionName :	Identifier
				|	ExpressionName DOT Identifier
				;

MethodName :	Identifier
			;


// Classes 


ClassDeclaration :	NormalClassDeclaration
				|	EnumDeclaration
				;

NormalClassDeclaration :	OCB ClassModifier CCB CLASS Identifier OBB TypeParameters CBB OBB Superclass CBB OBB Superinterfaces CBB ClassBody
					;

ClassModifier :	 ABSTRACT 
			| STATIC 
			| FINAL 
			| STRICTPF
			| Security
			;

TypeParameters :	LT TypeParameterList GT
				;

TypeParameterList :	TypeParameter OCB  COMMA TypeParameter CCB
				;

Superclass :	EXTENDS ClassType
			; 

Superinterfaces : 	IMPLEMENTS InterfaceTypeList
			; 

InterfaceTypeList :	ClassType OCB  COMMA ClassType CCB
			 ;

ClassBody :	OCB  OCB ClassBodyDeclaration CCB  CCB
			; 

ClassBodyDeclaration :	ClassMemberDeclaration
					|	InstanceInitializer
					|	StaticInitializer
					|	ConstructorDeclaration
					;


ClassMemberDeclaration :	FieldDeclaration
					|	MethodDeclaration
					|	ClassDeclaration
					|	InterfaceDeclaration
					|	SEMICOLON
					;

FieldDeclaration :	OCB FieldModifier CCB UnannType VariableDeclaratorList ;
					 ; 

FieldModifier :	Annotation 
			|	PUBLIC 
			|	PROTECTED 
			|	PRIVATE
			|	STATIC 
			|	FINAL
			| 	TRANSIENT
			| 	VOLATILE
			;

VariableDeclaratorList :	VariableDeclarator OCB  COMMA VariableDeclarator CCB
					; 

VariableDeclarator :	VariableDeclaratorId OBB   EQUALS VariableInitializer CBB
					; 

VariableDeclaratorId :	Identifier OBB Dims CBB
					; 

VariableInitializer :	Expression
					|	ArrayInitializer
					; 

UnannType :	UnannPrimitiveType
		|	UnannReferenceType
		; 

UnannPrimitiveType :	NumericType
				|	BOOLEAN
				;

UnannReferenceType :	UnannClassType
				|	UnannTypeVariable
				|	UnannArrayType
				;


UnannClassType :	Identifier OBB TypeArguments CBB
			|	UnannClassType DOT OCB Annotation CCB Identifier OBB TypeArguments CBB
			;

UnannTypeVariable :	Identifier
				; 

UnannArrayType :	UnannPrimitiveType Dims
			|	UnannClassType Dims
			|	UnannTypeVariable Dims
			;


MethodDeclaration :	OCB MethodModifier CCB MethodHeader MethodBody
				; 

MethodModifier :	ABSTRACT 
				|	STATIC 
				|	FINAL 
				|	SYNCHRONIZED
				|	NATIVE
				|	STRICTPF
				| 	Security
			; 
			
Security		:	Annotation 
				|	PUBLIC
				|	PROTECTED
				|	PRIVATE
				; 

MethodHeader :	Result MethodDeclarator OBB Throws CBB
			|	TypeParameters OCB Annotation CCB Result MethodDeclarator OBB Throws CBB
			; 

Result :	UnannType
	|	VOID
	; 

MethodDeclarator :	Identifier OB OBB FormalParameterList CBB CB OBB Dims CBB
			; 

FormalParameterList :	ReceiverParameter
					|	FormalParameters COMMA LastFormalParameter
					|	LastFormalParameter
					;

FormalParameters :	FormalParameter OCB  COMMA FormalParameter CCB
				|	ReceiverParameter OCB  COMMA FormalParameter CCB
				;

FormalParameter :	OCB VariableModifier CCB UnannType VariableDeclaratorId
					; 

VariableModifier :	Annotation
				|	FINAL
				;

LastFormalParameter :	OCB VariableModifier CCB UnannType OCB Annotation CCB DOT VariableDeclaratorId
					|	FormalParameter
					;

ReceiverParameter :	OCB Annotation CCB UnannType OBB Identifier DOT  CBB THIS
					; 


Throws :	THROWS
	|	ExceptionTypeList
	;

ExceptionTypeList :	ExceptionType OCB  COMMA ExceptionType CCB
			; 

ExceptionType :	ClassType
			|	TypeVariable
			; 

MethodBody :	Block
		|	SEMICOLON
		; 

InstanceInitializer :	Block
					; 

StaticInitializer :	STATIC Block
					; 

ConstructorDeclaration :	OCB ConstantModifier CCB ConstructorDeclarator OBB Throws CBB ConstructorBody
						; 

ConstructorDeclarator :	OBB TypeParameters CBB SimpleTypeName OB OBB FormalParameterList CBB CB
						; 

SimpleTypeName :	Identifier
				; 

ConstructorBody :	OCB  OBB ExplicitConstructorInvocation CBB OBB BlockStatements CBB  CCB
				;  

ExplicitConstructorInvocation :	OBB TypeArguments CBB THIS OB OBB ArgumentList CBB CB SEMICOLON
							|	OBB TypeArguments CBB SUPER OB OBB ArgumentList CBB CB SEMICOLON
							|	ExpressionName DOT OBB TypeArguments CBB SUPER OB OBB ArgumentList CBB CB SEMICOLON
							|	Primary DOT OBB TypeArguments CBB SUPER OB OBB ArgumentList CBB CB SEMICOLON
							; 

EnumDeclaration :	OCB ClassModifier CCB ENUM Identifier OBB Superinterfaces CBB EnumBody
					; 

EnumBody :	OCB  OBB EnumConstantList CBB OBB  COMMA  CBB OBB EnumBodyDeclarations CBB  CCB		
			; 

EnumConstantList :	EnumConstant OCB  COMMA EnumConstant CCB
				; 

EnumConstant :	OCB Annotation CCB Identifier OBB  OB OBB ArgumentList CBB CB  CBB OBB ClassBody CBB
				; 

EnumBodyDeclarations :	SEMICOLON OCB ClassBodyDeclaration CCB
				; 

// Interfaces 


InterfaceDeclaration :	NormalInterfaceDeclaration
					|	AnnotationTypeDeclaration
					; 

NormalInterfaceDeclaration :	OCB InterfaceModifier CCB INTERFACE Identifier OBB TypeParameters CBB
						|	OBB ExtendsInterfaces CBB InterfaceBody
						; 

InterfaceModifier :	
				|	ABSTRACT
				|	STATIC 
				|	STRICTPF
				| 	Security
				; 

ExtendsInterfaces :	EXTENDS InterfaceTypeList
					; 

InterfaceBody :	OCB  OCB InterfaceMemberDeclaration CCB  CCB
				; 

InterfaceMemberDeclaration :	ConstantDeclaration
						|	InterfaceMethodDeclaration
						|	ClassDeclaration
						|	InterfaceDeclaration
						|	SEMICOLON
						;

ConstantDeclaration :	OCB ConstantModifier CCB UnannType VariableDeclaratorList SEMICOLON
					; 
ConstantModifier :	Annotation 
				|	PUBLIC
				|	STATIC
				|	FINAL
				; 

InterfaceMethodDeclaration :	OCB InterfaceMethodModifier CCB MethodHeader MethodBody	
					; 

InterfaceMethodModifier :	Annotation 
						|	PUBLIC
						|	ABSTRACT
						|	DEFAULT
						|	STATIC
						|	STRICTPF
						; 

AnnotationTypeDeclaration :	OCB InterfaceModifier CCB ATRATE INTERFACE Identifier AnnotationTypeBody
						; 

AnnotationTypeBody :	OCB  OCB AnnotationTypeMemberDeclaration CCB  CCB
					;  
AnnotationTypeMemberDeclaration :	AnnotationTypeElementDeclaration
								|	ConstantDeclaration
								|	ClassDeclaration
								|	InterfaceDeclaration
								|	SEMICOLON
								; 

AnnotationTypeElementDeclaration :	OCB AnnotationTypeElementModifier CCB UnannType Identifier OB CB OBB Dims CBB OBB DefaultValue CBB SEMICOLON
								; 

AnnotationTypeElementModifier :	Annotation
							|	PUBLIC
							|	ABSTRACT
							; 

DefaultValue:	DEFAULT ElementValue
				; 

Annotation :	NormalAnnotation
		|	MarkerAnnotation
		|	SingleElementAnnotation
		; 

NormalAnnotation :	ATRATE TypeName OB OBB ElementValuePairList CBB CB
					; 

ElementValuePairList :	ElementValuePair OCB  COMMA ElementValuePair CCB
					; 

ElementValuePair :	Identifier  EQUALS ElementValue
					; 

ElementValue :	ConditionalExpression
			|	ElementValueArrayInitializer
			|	Annotation
			; 

ElementValueArrayInitializer :	OCB  OBB ElementValueList CBB OBB  COMMA  CBB  CCB
						; 

ElementValueList :	ElementValue OCB  COMMA ElementValue CCB
					; 

MarkerAnnotation :	ATRATE SimpleTypeName
					; 

SingleElementAnnotation :	ATRATE TypeName OB ElementValue CB
					; 

// Arrays 
ArrayInitializer :	OCB  OBB VariableInitializerList CBB OBB  COMMA  CBB  CCB
				; 

VariableInitializerList :	VariableInitializer OCB  COMMA VariableInitializer CCB
				; 

// Blocks 

Block :	OCB  OBB BlockStatements CBB  CCB
	; 

BlockStatements :	BlockStatement OCB BlockStatement CCB
	; 

BlockStatement :	LocalVariableDeclarationStatement
			|	ClassDeclaration
			|	Statement
			; 
LocalVariableDeclarationStatement :	LocalVariableDeclaration SEMICOLON
									; 	

LocalVariableDeclaration :	OCB VariableModifier CCB UnannType VariableDeclaratorList
							; 

Statement :	StatementWithoutTrailingSubstatement
		|	LabeledStatement
		|	IfThenStatement
		|	IfThenElseStatement
		|	WhileStatement
		|	ForStatement
		; 

StatementNoShortIf :	StatementWithoutTrailingSubstatement
				|	LabeledStatementNoShortIf
				|	IfThenElseStatementNoShortIf
				|	WhileStatementNoShortIf
				|	ForStatementNoShortIf
				;  

StatementWithoutTrailingSubstatement :	Block
									| 	EmptyStatement
									| 	ExpressionStatement
									|	AssertStatement
									|	SwitchStatement
									|	DoStatement
									|	BreakStatement
									|	ContinueStatement
									|	ReturnStatement
									|	SynchronizedStatement
									|	ThrowStatement
									|	TryStatement
									; 

EmptyStatement :	SEMICOLON
				; 

LabeledStatement :	Identifier COLON Statement	
				; 

LabeledStatementNoShortIf :	Identifier COLON StatementNoShortIf	
				; 

ExpressionStatement :	StatementExpression SEMICOLON

StatementExpression:	Assignment
					|	PreIncrementExpression
					|	PreDecrementExpression
					|	PostIncrementExpression
					|	PostDecrementExpression
					|	MethodInvocation
					|	ClassInstanceCreationExpression
					; 

IfThenStatement : 	IF OB Expression CB Statement
				; 

IfThenElseStatement :	IF OB Expression CB StatementNoShortIf ELSE Statement
					; 

IfThenElseStatementNoShortIf :	IF OB Expression CB StatementNoShortIf ELSE StatementNoShortIf
					; 

AssertStatement :	ASSERT Expression SEMICOLON
				|	ASSERT Expression COLON Expression SEMICOLON
				; 

SwitchStatement :	SWITCH OB Expression CB SwitchBlock
				; 

SwitchBlock :	OCB  OCB SwitchBlockStatementGroup CCB OCB SwitchLabel CCB  CCB
				; 

SwitchBlockStatementGroup :	SwitchLabels BlockStatements
							; 

SwitchLabels :	SwitchLabel OCB SwitchLabel CCB
				; 

SwitchLabel :	CASE Expression COLON
			|	CASE Identifier COLON	
			|	DEFAULT COLON
			; 



WhileStatement :	WHILE OB Expression CB Statement
				; 

WhileStatementNoShortIf :	WHILE OB Expression CB StatementNoShortIf
				; 

DoStatement :	DO Statement WHILE OB Expression CB SEMICOLON
				; 

ForStatement :	BasicForStatement
			|	EnhancedForStatement
			; 

ForStatementNoShortIf :	BasicForStatementNoShortIf
					|	EnhancedForStatementNoShortIf
					; 

BasicForStatement :	FOR OB OBB ForInit CBB SEMICOLON OBB Expression CBB SEMICOLON OBB ForUpdate CBB CB Statement
					; 

BasicForStatementNoShortIf :	FOR OB OBB ForInit CBB SEMICOLON OBB Expression CBB SEMICOLON OBB ForUpdate CBB CB StatementNoShortIf
					; 

ForInit :	StatementExpressionList
		|	LocalVariableDeclaration
		; 

ForUpdate :	StatementExpressionList
		; 

StatementExpressionList :	StatementExpression OCB  COMMA StatementExpression  CCB
						; 

EnhancedForStatement :	FOR OB OCB VariableModifier CCB UnannType VariableDeclaratorId COLON Expression CB	Statement
						; 

EnhancedForStatementNoShortIf :	FOR OB OCB VariableModifier CCB UnannType VariableDeclaratorId COLON Expression CB StatementNoShortIf
								; 

BreakStatement :	BREAK OBB Identifier CBB SEMICOLON
				; 

ContinueStatement :	CONTINUE OBB Identifier CBB SEMICOLON
					; 

ReturnStatement :	RETURN OBB Expression CBB SEMICOLON
					; 


ThrowStatement :	THROW Expression SEMICOLON
				; 

SynchronizedStatement :	SYNCHRONIZED OB Expression CB Block
					; 

TryStatement :	TRY Block Catches
			|	TRY Block OBB Catches CBB Finally
			|	TryWithResourcesStatement
			; 

Catches :	CatchClause OCB CatchClause CCB
			; 

CatchClause :	CATCH OB CatchFormalParameter CB Block
			; 

CatchFormalParameter :	OCB VariableModifier CCB CatchType VariableDeclaratorId
				; 

CatchType :	UnannClassType OCB  OR ClassType CCB
			; 

Finally :	FINALLY
		|	Block
		; 

TryWithResourcesStatement :	TRY ResourceSpecification Block OBB Catches CBB OBB Finally CBB
				; 

ResourceSpecification :	OB ResourceList OBB  SEMICOLON  CBB CB
				; 

ResourceList :	Resource OCB  SEMICOLON Resource CCB
				; 

Resource :	OCB VariableModifier CCB UnannType VariableDeclaratorId EQUALS Expression
				; 

// Expressions 


Primary :	PrimaryNoNewArray
		|	ArrayCreationExpression
		; 

AccessCommon :	FieldAccess
			|	ArrayAccess
			; 


PrimaryNoNewArray :	Literal
				|	ClassLiteral
				|	THIS
				|	TypeName DOT THIS
				|	OB Expression CB
				|	ClassInstanceCreationExpression
				|	AccessCommon
				|	MethodInvocation
				|	MethodReference
				; 

ClassLiteral :	TypeName OCB  OBB   CBB  CCB DOT CLASS
			|	NumericType OCB  OBB   CBB  CCB DOT CLASS
			|	BOOLEAN OCB  OBB   CBB  CCB DOT CLASS
			|	VOID DOT CLASS
			; 

ClassInstanceCreationExpression :	UnqualifiedClassInstanceCreationExpression
								|	ExpressionName DOT UnqualifiedClassInstanceCreationExpression
								|	Primary DOT UnqualifiedClassInstanceCreationExpression
								; 

UnqualifiedClassInstanceCreationExpression :	NEW OBB TypeArguments CBB
										|	ClassOrInterfaceTypeToInstantiate OB OBB ArgumentList CBB CB OBB ClassBody CBB
										; 

ClassOrInterfaceTypeToInstantiate :	OCB Annotation CCB Identifier OCB DOT OCB Annotation CCB Identifier CCB
								|	OBB TypeArgumentsOrDiamond CBB
								; 

TypeArgumentsOrDiamond :	TypeArguments
					|	LT GT
					; 


FieldAccess :	Primary DOT Identifier
			|	SUPER DOT Identifier
			|	TypeName DOT SUPER DOT Identifier
			; 

ArrayAccess :	ExpressionName OBB  Expression  CBB
			|	PrimaryNoNewArray OBB  Expression  CBB
			; 


MethodInvocation :	MethodName OB OBB ArgumentList CBB CB
				|	TypeName DOT OBB TypeArguments CBB Identifier OB OBB ArgumentList CBB CB
				|	ExpressionName DOT OBB TypeArguments CBB Identifier OB OBB ArgumentList CBB CB
				|	Primary DOT OBB TypeArguments CBB Identifier OB OBB ArgumentList CBB CB
				|	SUPER DOT OBB TypeArguments CBB Identifier OB OBB ArgumentList CBB CB
				|	TypeName DOT SUPER DOT OBB TypeArguments CBB Identifier OB OBB ArgumentList CBB CB
				; 
				

ArgumentList :	Expression OCB  COMMA Expression CCB
				; 
								
MethodReference :	ExpressionName COLON COLON OBB TypeArguments CBB Identifier
				|	ReferenceType COLON COLON OBB TypeArguments CBB Identifier
				|	Primary COLON COLON OBB TypeArguments CBB Identifier
				|	SUPER COLON COLON OBB TypeArguments CBB Identifier
				|	TypeName DOT SUPER COLON COLON OBB TypeArguments CBB Identifier
				|	ClassType COLON COLON OBB TypeArguments CBB NEW	
				|	ArrayType COLON COLON NEW	
				;

ArrayCreationExpression :	NEW PrimitiveType DimExprs OBB Dims CBB
						|	NEW ClassType DimExprs OBB Dims CBB
						|	NEW PrimitiveType Dims ArrayInitializer
						|	NEW ClassType Dims ArrayInitializer
						;

DimExprs :	DimExpr OCB DimExpr CCB
			; 

DimExpr :	OCB Annotation CCB OBB  Expression  CBB
			; 


Expression :	LambdaExpression
		|	AssignmentExpression
		; 

LambdaExpression :	LambdaParameters REF LambdaBody
				; 

LambdaParameters :	Identifier
				|	OB OBB FormalParameterList CBB CB
				|	OB InferredFormalParameterList CB
				; 

InferredFormalParameterList :	Identifier OCB  COMMA Identifier CCB
							; 

LambdaBody :	Expression
		|	Block
		;

AssignmentExpression :	ConditionalExpression
					|	Assignment
					; 

Assignment :	LeftHandSide AssignmentOperator Expression
			; 



LeftHandSide :	ExpressionName
				| AccessCommon
			; 



AssignmentOperator :	EQUALS
				|	MUL EQUALS
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

ConditionalExpression :	ConditionalOrExpression
					|	ConditionalOrExpression QUESTION Expression COLON ConditionalExpression	
					|	ConditionalOrExpression QUESTION Expression COLON LambdaExpression	
					; 

ConditionalOrExpression :	ConditionalAndExpression
						|	ConditionalOrExpression OR OR ConditionalAndExpression


ConditionalAndExpression :	InclusiveOrExpression
						|	ConditionalAndExpression AND AND InclusiveOrExpression
						; 

InclusiveOrExpression : 	ExclusiveOrExpression
					|	InclusiveOrExpression OR ExclusiveOrExpression
					; 

ExclusiveOrExpression :	AndExpression
					|	ExclusiveOrExpression EXP AndExpression
					; 

AndExpression :	EqualityExpression
			|	AndExpression AND  EqualityExpression
			; 

EqualityExpression :	RelationalExpression
					|	EqualityExpression  EQUALS RelationalExpression
					|	EqualityExpression NOT EQUALS RelationalExpression
					; 

RelationalExpression :	ShiftExpression
					|	RelationalExpression LT ShiftExpression
					|	RelationalExpression GT ShiftExpression
					|	RelationalExpression LT EQUALS ShiftExpression
					|	RelationalExpression GT EQUALS ShiftExpression
					|	RelationalExpression INSTANCEOF ReferenceType
					; 


ShiftExpression :	AdditiveExpression
				|	ShiftExpression LT LT AdditiveExpression
				|	ShiftExpression GT GT AdditiveExpression
				|	ShiftExpression GT GT GT AdditiveExpression
				; 

AdditiveExpression :	MultiplicativeExpression
				|	AdditiveExpression PLUS MultiplicativeExpression
				|	AdditiveExpression MINUS MultiplicativeExpression
				; 

MultiplicativeExpression :	UnaryExpression
						|	MultiplicativeExpression MUL UnaryExpression
						|	MultiplicativeExpression DIV UnaryExpression
						|	MultiplicativeExpression MOD UnaryExpression
						;

UnaryExpression :	PreIncrementExpression
				|	PreDecrementExpression
				|	PLUS UnaryExpression
				|	MINUS UnaryExpression
				|	UnaryExpressionNotPlusMinus
				; 

PreIncrementExpression :	PLUS PLUS UnaryExpression
					; 

PreDecrementExpression :	MINUS MINUS UnaryExpression
					; 

UnaryExpressionNotPlusMinus :	PostfixExpression
							|	TILDE UnaryExpression
							|	NOT UnaryExpression
							|	CastExpression
							;

PostfixExpression :	Primary
				|	ExpressionName
				|	PostIncrementExpression
				|	PostDecrementExpression
				; 

PostIncrementExpression :	PostfixExpression PLUS PLUS
						; 

PostDecrementExpression :	PostfixExpression MINUS MINUS
						; 

CastExpression :	OB PrimitiveType CB UnaryExpression
			|	OB ReferenceType OCB AdditionalBound CCB CB UnaryExpressionNotPlusMinus
			|	OB ReferenceType OCB AdditionalBound CCB CB LambdaExpression
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