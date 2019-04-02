

%token DOT COMMA SEMICOLON

%% 
// Packages 

CompilationUnit :	OBB PackageDeclaration CBB OCB ImportDeclaration CCB OCB TypeDeclaration CCB
					;

PackageDeclaration :	OCB PackageModifier CCB package Identifier OCB  DOT Identifier CCB SEMICOLON
					;
PackageModifier :	Annotation
					; 
ImportDeclaration :	SingleTypeImportDeclaration
				|	TypeImportOnDemandDeclaration
				|	SingleStaticImportDeclaration
				|	StaticImportOnDemandDeclaration
				;

SingleTypeImportDeclaration :	import TypeName SEMICOLON
								; 

TypeImportOnDemandDeclaration :	import PackageOrTypeName DOT * SEMICOLON
								; 

SingleStaticImportDeclaration :	import static TypeName DOT Identifier SEMICOLON
								; 

StaticImportOnDemandDeclaration :	import static TypeName DOT * SEMICOLON
									; 

TypeDeclaration :	ClassDeclaration
				|	InterfaceDeclaration
				|	SEMICOLON
				;

// Lexical Structure 

Literal :	IntegerLiteral
		|	FloatingPointLiteral
		|	BooleanLiteral
		|	CharacterLiteral
		|	StringLiteral
		|	NullLiteral
		;

// Types COMMA Values and Variables 


Type :	PrimitiveType
	|	ReferenceType
	;

PrimitiveType :	OCB Annotation CCB NumericType
			|	OCB Annotation CCB boolean
			;

NumericType :	IntegralType
			|	FloatingPointType
			;

IntegralType :	byte
			|	short
			|	int
			|	long
			|	char
			;

FloatingPointType : float
				|	 double
				;

ReferenceType:	ClassOrInterfaceType
			|	TypeVariable
			|	ArrayType
			;

ClassOrInterfaceType :	ClassType
					|	InterfaceType

ClassType :		OCB Annotation CCB Identifier OBB TypeArguments OCB
			|	ClassOrInterfaceType DOT OCB Annotation CCB Identifier OBB TypeArguments OCB
			;

InterfaceType :	ClassType

TypeVariable :	OCB Annotation CCB Identifier
			;

ArrayType :		PrimitiveType Dims
			|	ClassOrInterfaceType Dims
			|	TypeVariable Dims 
			;

Dims :	OCB Annotation CCB OBB CBB OCB OCB Annotation CCB OBB CBB CCB
		; 

TypeParameter :	OCB TypeParameterModifier CCB Identifier OBB TypeBound CBB
			; 

TypeParameterModifier :	Annotation
			;

TypeBound :	extends TypeVariable
		|	extends ClassOrInterfaceType OCB AdditionalBound CCB
		;

AdditionalBound :	AND InterfaceType
		;

TypeArguments :	LT TypeArgumentList GT

TypeArgumentList :	TypeArgument OCB  COMMA TypeArgument CCB

TypeArgument :	ReferenceType
		|	Wildcard
		;


Wildcard :	OCB Annotation CCB QUESTION OBB WildcardBounds CBB

WildcardBounds :	extends ReferenceType
			|	super ReferenceType
			;


// Names 

TypeName :	Identifier
		|	PackageOrTypeName DOT Identifier
		;

PackageOrTypeName :	Identifier
				| PackageOrTypeName DOT Identifier
				;

ExpressionName :	Identifier
				|	AmbiguousName DOT Identifier
				;

MethodName :	Identifier
			;

PackageName :	Identifier
			|	PackageName DOT Identifier
			;

AmbiguousName :	Identifier
			|	AmbiguousName DOT Identifier
			;


// Classes 


ClassDeclaration :	NormalClassDeclaration
				|	EnumDeclaration
				;

NormalClassDeclaration :	OCB ClassModifier CCB class Identifier OBB TypeParameters CBB OBB Superclass CBB OBB Superinterfaces CBB ClassBody
					;

ClassModifier :	 Annotation public protected private
			|	abstract static final strictfp
			;

TypeParameters :	< TypeParameterList >
				;

TypeParameterList :	TypeParameter OCB  COMMA TypeParameter CCB
				;

Superclass :	extends ClassType
			; 

Superinterfaces:	implements InterfaceTypeList
			; 

InterfaceTypeList:	InterfaceType OCB  COMMA InterfaceType CCB
			 ;

ClassBody:	OCB  OCB ClassBodyDeclaration CCB  CCB
			; 

ClassBodyDeclaration:	ClassMemberDeclaration
					|	InstanceInitializer
					|	StaticInitializer
					|	ConstructorDeclaration
					;


ClassMemberDeclaration:	FieldDeclaration
					|	MethodDeclaration
					|	ClassDeclaration
					|	InterfaceDeclaration
					|	SEMICOLON
					;

FieldDeclaration:	OCB FieldModifier CCB UnannType VariableDeclaratorList ;
					 ; 

FieldModifier:	Annotation public protected private
			|	static final transient volatile
			;

VariableDeclaratorList:	VariableDeclarator OCB  COMMA VariableDeclarator CCB
					; 

VariableDeclarator:	VariableDeclaratorId OBB  = VariableInitializer CBB
					; 

VariableDeclaratorId:	Identifier OBB Dims CBB
					; 

VariableInitializer:	Expression
					|	ArrayInitializer
					; 

UnannType:	UnannPrimitiveType
		|	UnannReferenceType
		; 

UnannPrimitiveType:	NumericType
				|	boolean
				;

UnannReferenceType:	UnannClassOrInterfaceType
				|	UnannTypeVariable
				|	UnannArrayType
				;

UnannClassOrInterfaceType:	UnannClassType
						|	UnannInterfaceType
						;

UnannClassType:	Identifier OBB TypeArguments CBB
			|	UnannClassOrInterfaceType DOT OCB Annotation CCB Identifier OBB TypeArguments CBB
			;

UnannInterfaceType:	UnannClassType
				; 

UnannTypeVariable:	Identifier
				; 

UnannArrayType:	UnannPrimitiveType Dims
			|	UnannClassOrInterfaceType Dims
			|	UnannTypeVariable Dims
			;


MethodDeclaration:	OCB MethodModifier CCB MethodHeader MethodBody
				; 

MethodModifier:	Annotation public protected private
			|	abstract static final synchronized native strictfp
			; 

MethodHeader:	Result MethodDeclarator OBB Throws CBB
			|	TypeParameters OCB Annotation CCB Result MethodDeclarator OBB Throws CBB
			; 

Result:	UnannType
	|	void
	; 

MethodDeclarator:	Identifier ( OBB FormalParameterList CBB ) OBB Dims CBB
			; 

FormalParameterList:	ReceiverParameter
					|	FormalParameters COMMA LastFormalParameter
					|	LastFormalParameter
					;

FormalParameters:	FormalParameter OCB  COMMA FormalParameter CCB
				|	ReceiverParameter OCB  COMMA FormalParameter CCB
				;

FormalParameter:	OCB VariableModifier CCB UnannType VariableDeclaratorId
					; 

VariableModifier :	Annotation
				|	final
				;

LastFormalParameter:	OCB VariableModifier CCB UnannType OCB Annotation CCB DOT VariableDeclaratorId
					|	FormalParameter
					;

ReceiverParameter:	OCB Annotation CCB UnannType OBB Identifier DOT  CBB this
					; 


Throws:	throws
	|	ExceptionTypeList
	;

ExceptionTypeList:	ExceptionType OCB  COMMA ExceptionType CCB
			; 

ExceptionType:	ClassType
			|	TypeVariable
			; 

MethodBody:	Block
		|	SEMICOLON
		; 

InstanceInitializer:	Block
					; 

StaticInitializer:	static Block
					; 

ConstructorDeclaration:	OCB ConstructorModifier CCB ConstructorDeclarator OBB Throws CBB ConstructorBody
						; 

ConstructorModifier:	Annotation 
					|	public 
					|	protected 
					|	private
						;

ConstructorDeclarator:	OBB TypeParameters CBB SimpleTypeName ( OBB FormalParameterList CBB )
						; 

SimpleTypeName:	Identifier
				; 

ConstructorBody:	OCB  OBB ExplicitConstructorInvocation CBB OBB BlockStatements CBB  CCB
				;  

ExplicitConstructorInvocation:	OBB TypeArguments CBB this ( OBB ArgumentList CBB ) SEMICOLON
							|	OBB TypeArguments CBB super ( OBB ArgumentList CBB ) SEMICOLON
							|	ExpressionName DOT OBB TypeArguments CBB super ( OBB ArgumentList CBB ) SEMICOLON
							|	Primary DOT OBB TypeArguments CBB super ( OBB ArgumentList CBB ) SEMICOLON
							; 

EnumDeclaration:	OCB ClassModifier CCB enum Identifier OBB Superinterfaces CBB EnumBody
					; 

EnumBody:	OCB  OBB EnumConstantList CBB OBB  COMMA  CBB OBB EnumBodyDeclarations CBB  CCB		
			; 

EnumConstantList:	EnumConstant OCB  COMMA EnumConstant CCB
				; 

EnumConstant:	OCB EnumConstantModifier CCB Identifier OBB  ( OBB ArgumentList CBB )  CBB OBB ClassBody CBB
				; 

EnumConstantModifier:	Annotation
				; 

EnumBodyDeclarations:	SEMICOLON OCB ClassBodyDeclaration CCB
				; 

// Interfaces 


InterfaceDeclaration:	NormalInterfaceDeclaration
					|	AnnotationTypeDeclaration
					; 

NormalInterfaceDeclaration:	{InterfaceModifier} interface Identifier [TypeParameters]
						|	[ExtendsInterfaces] InterfaceBody
						; 

InterfaceModifier:	Annotation 
				|	public 
				|	protected 
				|	private
				|	abstract
				|	static 
				|	strictfp
				; 

ExtendsInterfaces:	extends InterfaceTypeList
					; 

InterfaceBody:	{ {InterfaceMemberDeclaration} }

InterfaceMemberDeclaration:	ConstantDeclaration
						|	InterfaceMethodDeclaration
						|	ClassDeclaration
						|	InterfaceDeclaration
						|	SEMICOLON
						;

ConstantDeclaration:	{ConstantModifier} UnannType VariableDeclaratorList SEMICOLON
					; 
ConstantModifier:	Annotation 
				|	public
				|	static
				|	final
				; 

InterfaceMethodDeclaration:	{InterfaceMethodModifier} MethodHeader MethodBody	
					; 

InterfaceMethodModifier:	Annotation 
						|	public
						|	abstract
						|	default
						|	static
						|	strictfp
						; 

AnnotationTypeDeclaration:	{InterfaceModifier} @ interface Identifier AnnotationTypeBody
						; 

AnnotationTypeBody:	{ {AnnotationTypeMemberDeclaration} }
					; 
AnnotationTypeMemberDeclaration:	AnnotationTypeElementDeclaration
								|	ConstantDeclaration
								|	ClassDeclaration
								|	InterfaceDeclaration
								|	SEMICOLON
								; 

AnnotationTypeElementDeclaration:	{AnnotationTypeElementModifier} UnannType Identifier ( ) [Dims] [DefaultValue] SEMICOLON
								; 

AnnotationTypeElementModifier:	Annotation
							|	public
							|	abstract
							; 

DefaultValue:	default ElementValue
				; 

Annotation :	NormalAnnotation
		|	MarkerAnnotation
		|	SingleElementAnnotation
		; 

NormalAnnotation :	@ TypeName ( [ElementValuePairList] )
					; 

ElementValuePairList :	ElementValuePair { , ElementValuePair}
					; 

ElementValuePair :	Identifier = ElementValue
					; 

ElementValue:	ConditionalExpression
			|	ElementValueArrayInitializer
			|	Annotation
			; 

ElementValueArrayInitializer:	{ [ElementValueList] [ , ] }
						; 

ElementValueList:	ElementValue { , ElementValue}
					; 

MarkerAnnotation:	@ SimpleTypeName
					; 

SingleElementAnnotation:	@ TypeName ( ElementValue )
					; 

// Arrays 
ArrayInitializer:	{ [VariableInitializerList] [ , ] }
				; 

VariableInitializerList:	VariableInitializer { , VariableInitializer}
				; 

// Blocks 

Block:	{ [BlockStatements] }

BlockStatements:	BlockStatement {BlockStatement}

BlockStatement:	LocalVariableDeclarationStatement
ClassDeclaration
Statement

LocalVariableDeclarationStatement:	LocalVariableDeclaration ;

LocalVariableDeclaration:	{VariableModifier} UnannType VariableDeclaratorList

Statement:	StatementWithoutTrailingSubstatement
LabeledStatement
IfThenStatement
IfThenElseStatement
WhileStatement
ForStatement

StatementNoShortIf:	StatementWithoutTrailingSubstatement
LabeledStatementNoShortIf
IfThenElseStatementNoShortIf
WhileStatementNoShortIf
ForStatementNoShortIf


StatementWithoutTrailingSubstatement:	Block
EmptyStatement
ExpressionStatement
AssertStatement
SwitchStatement
DoStatement
BreakStatement
ContinueStatement
ReturnStatement
SynchronizedStatement
ThrowStatement
TryStatement

EmptyStatement:	;

LabeledStatement:	Identifier : Statement	LabeledStatementNoShortIf:	Identifier : StatementNoShortIf	ExpressionStatement:	StatementExpression ;

StatementExpression:	Assignment
PreIncrementExpression
PreDecrementExpression
PostIncrementExpression
PostDecrementExpression
MethodInvocation
ClassInstanceCreationExpression


IfThenStatement:	if ( Expression ) Statement

IfThenElseStatement:	if ( Expression ) StatementNoShortIf else Statement

IfThenElseStatementNoShortIf:	if ( Expression ) StatementNoShortIf else StatementNoShortIf

AssertStatement:	assert Expression ;

assert Expression : Expression ;	SwitchStatement:	switch ( Expression ) SwitchBlock

SwitchBlock:	{ {SwitchBlockStatementGroup} {SwitchLabel} }

SwitchBlockStatementGroup:	SwitchLabels BlockStatements

SwitchLabels:	SwitchLabel {SwitchLabel}

SwitchLabel:	case ConstantExpression :	case EnumConstantName :	default :	EnumConstantName:	Identifier

WhileStatement:	while ( Expression ) Statement

WhileStatementNoShortIf:	while ( Expression ) StatementNoShortIf

DoStatement:	do Statement while ( Expression ) ;


ForStatement:	BasicForStatement
EnhancedForStatement

ForStatementNoShortIf:	BasicForStatementNoShortIf
EnhancedForStatementNoShortIf

BasicForStatement:	for ( [ForInit] ; [Expression] ; [ForUpdate] ) Statement

BasicForStatementNoShortIf:	for ( [ForInit] ; [Expression] ; [ForUpdate] ) StatementNoShortIf

ForInit:	StatementExpressionList
LocalVariableDeclaration

ForUpdate:	StatementExpressionList

StatementExpressionList:	StatementExpression { , StatementExpression}

EnhancedForStatement:	for ( {VariableModifier} UnannType VariableDeclaratorId

: Expression )	Statement

EnhancedForStatementNoShortIf:	for ( {VariableModifier} UnannType VariableDeclaratorId

: Expression )	StatementNoShortIf

BreakStatement:	break [Identifier] ;

ContinueStatement:	continue [Identifier] ;

ReturnStatement:	return [Expression] ;


ThrowStatement:	throw Expression ;

SynchronizedStatement:	synchronized ( Expression ) Block

TryStatement:	try Block Catches
try Block [Catches] Finally
TryWithResourcesStatement

Catches:	CatchClause {CatchClause}

CatchClause:	catch ( CatchFormalParameter ) Block

CatchFormalParameter:	{VariableModifier} CatchType VariableDeclaratorId

CatchType:	UnannClassType { | ClassType}

Finally:	finally
Block

TryWithResourcesStatement:	try ResourceSpecification Block [Catches] [Finally]

ResourceSpecification:	( ResourceList [ ; ] )

ResourceList:	Resource { ; Resource}

Resource:	{VariableModifier} UnannType VariableDeclaratorId = Expression

// Expressions 


Primary:	PrimaryNoNewArray
ArrayCreationExpression

PrimaryNoNewArray:	Literal
ClassLiteral
this
TypeName . this
( Expression )
ClassInstanceCreationExpression
FieldAccess
ArrayAccess
MethodInvocation
MethodReference

ClassLiteral:	TypeName { [ ] } . class
NumericType { [ ] } . class
boolean { [ ] } . class
void . class

ClassInstanceCreationExpression:	UnqualifiedClassInstanceCreationExpression
ExpressionName . UnqualifiedClassInstanceCreationExpression
Primary . UnqualifiedClassInstanceCreationExpression

UnqualifiedClassInstanceCreationExpression:	new [TypeArguments]
ClassOrInterfaceTypeToInstantiate ( [ArgumentList] ) [ClassBody]

ClassOrInterfaceTypeToInstantiate:	{Annotation} Identifier { . {Annotation} Identifier}
[TypeArgumentsOrDiamond]

TypeArgumentsOrDiamond:	TypeArguments
<>


FieldAccess:	Primary . Identifier
super . Identifier
TypeName . super . Identifier

ArrayAccess:	ExpressionName [ Expression ]
PrimaryNoNewArray [ Expression ]

MethodInvocation:	MethodName ( [ArgumentList] )
TypeName . [TypeArguments] Identifier ( [ArgumentList] )
ExpressionName . [TypeArguments] Identifier ( [ArgumentList] )
Primary . [TypeArguments] Identifier ( [ArgumentList] )
super . [TypeArguments] Identifier ( [ArgumentList] )
TypeName . super . [TypeArguments] Identifier ( [ArgumentList] )

ArgumentList:	Expression { , Expression}

MethodReference:	ExpressionName :: [TypeArguments] Identifier	ReferenceType :: [TypeArguments] Identifier	Primary :: [TypeArguments] 
Identifier	super :: [TypeArguments] Identifier	TypeName . super :: [TypeArguments] Identifier	ClassType :: [TypeArguments] new	
ArrayType :: new	ArrayCreationExpression:	new PrimitiveType DimExprs [Dims]
new ClassOrInterfaceType DimExprs [Dims]
new PrimitiveType Dims ArrayInitializer
new ClassOrInterfaceType Dims ArrayInitializer

DimExprs:	DimExpr {DimExpr}

DimExpr:	{Annotation} [ Expression ]


Expression:	LambdaExpression
AssignmentExpression

LambdaExpression:	LambdaParameters -> LambdaBody

LambdaParameters:	Identifier
( [FormalParameterList] )
( InferredFormalParameterList )

InferredFormalParameterList:	Identifier { , Identifier}

LambdaBody:	Expression
Block

AssignmentExpression:	ConditionalExpression
Assignment

Assignment:	LeftHandSide AssignmentOperator Expression

LeftHandSide:	ExpressionName
FieldAccess
ArrayAccess

AssignmentOperator:	(one of)
=
*=
/=
%=
+=
-=
<<=
>>=
>>>=
&=
^=
|=


ConditionalExpression:	ConditionalOrExpression

ConditionalOrExpression ? Expression : ConditionalExpression	ConditionalOrExpression ? Expression : LambdaExpression	
ConditionalOrExpression:	ConditionalAndExpression
ConditionalOrExpression || ConditionalAndExpression

ConditionalAndExpression:	InclusiveOrExpression
ConditionalAndExpression && InclusiveOrExpression

InclusiveOrExpression:	ExclusiveOrExpression
InclusiveOrExpression | ExclusiveOrExpression

ExclusiveOrExpression:	AndExpression
ExclusiveOrExpression ^ AndExpression

AndExpression:	EqualityExpression
AndExpression & EqualityExpression

EqualityExpression:	RelationalExpression
EqualityExpression == RelationalExpression
EqualityExpression != RelationalExpression

RelationalExpression:	ShiftExpression
RelationalExpression < ShiftExpression
RelationalExpression > ShiftExpression
RelationalExpression <= ShiftExpression
RelationalExpression >= ShiftExpression
RelationalExpression instanceof ReferenceType


ShiftExpression:	AdditiveExpression
ShiftExpression << AdditiveExpression
ShiftExpression >> AdditiveExpression
ShiftExpression >>> AdditiveExpression

AdditiveExpression:	MultiplicativeExpression
AdditiveExpression + MultiplicativeExpression
AdditiveExpression - MultiplicativeExpression

MultiplicativeExpression:	UnaryExpression
MultiplicativeExpression * UnaryExpression
MultiplicativeExpression / UnaryExpression
MultiplicativeExpression % UnaryExpression

UnaryExpression:	PreIncrementExpression
PreDecrementExpression
+ UnaryExpression
- UnaryExpression
UnaryExpressionNotPlusMinus

PreIncrementExpression:	++ UnaryExpression

PreDecrementExpression:	-- UnaryExpression

UnaryExpressionNotPlusMinus:	PostfixExpression
~ UnaryExpression
! UnaryExpression
CastExpression

PostfixExpression:	Primary
ExpressionName
PostIncrementExpression
PostDecrementExpression


PostIncrementExpression:	PostfixExpression ++

PostDecrementExpression:	PostfixExpression --

CastExpression:	( PrimitiveType ) UnaryExpression
( ReferenceType {AdditionalBound} ) UnaryExpressionNotPlusMinus
( ReferenceType {AdditionalBound} ) LambdaExpression

ConstantExpression:	Expression







%%

