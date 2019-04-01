// Bison File
%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex();
	int yyerror();
	extern FILE *yyin;
%}

%token DOT COMMA SEMICOLON package import static void final PLUS MULTIPLY DIVIDE MINUS MODULUS POWER this case default byte boolean short char int float double enum long public private protected abstract native synchronized transient volatile strictfp LCB RCB LSB RSB LRB RRB QUESTIONMARK AND OR LEFTSHIFT RIGHTSHIFT UNSIGNED_RIGHTSHIFT LT LTE GT GTE for if else switch while do break continue COLON throw finally EQUALS ATTHERATE TILD catch RETURN IDENTIFIER throws interface new try super instanceof NOT FloatingPointLiteral IntegerLiteral CharacterLiteral BooleanLiteral assert StringLiteral NullLiteral extends class implements

%% 

// -----------------------------------------------
Identifier : IDENTIFIER
			;
QualifiedIdentifier : Identifier A1
			;
A1 : DOT Identifier A1
			| 
			;
QualifiedIdentifierList : QualifiedIdentifier A2
			;
A2 : COMMA QualifiedIdentifier A2
			|
			;

// -----------------------------------------------
CompilationUnit : A3 A4 A5
			;
A3 : A6 package QualifiedIdentifier SEMICOLON
			|
			;
A6 : Annotations
			|
			;
A4 : ImportDeclaration A4
			|
			;
A5 : TypeDeclaration
			|
			;
ImportDeclaration : import A7 QualifiedIdentifier A8 SEMICOLON
			;
A7 : static
			|
			;
A8 : DOT MULTIPLY
			|
			;
TypeDeclaration : ClassOrInterfaceDeclaration
			| SEMICOLON
			;
ClassOrInterfaceDeclaration : A9 ClassDeclaration
			| A9 InterfaceDeclaration
			;
A9 : Modifier A9
			|
			;
ClassDeclaration : NormalClassDeclaration
			| EnumDeclaration
			;
InterfaceDeclaration : NormalInterfaceDeclaration
			| AnnotationTypeDeclaration
			;
NormalClassDeclaration : class Identifier A10 A11 A12 ClassBody
			;
A10 : TypeParameters
			;
A11 : extends Type
			;
A12 : implements TypeList
			;
EnumDeclaration : enum Identifier A12 EnumBody
			;
NormalInterfaceDeclaration : interface Identifier A10 A13 InterfaceBody
			;
A13 : extends TypeList
			;
AnnotationTypeDeclaration : ATTHERATE interface Identifier AnnotationTypeBody
			;

// -----------------------------------------------
Type : BasicType A14
			| ReferenceType A14
			;
A14 : LSB RSB A14
			|
			;
BasicType : byte
			| short
			| char
			| int
			| long
			| float
			| double
			| boolean
			;
ReferenceType : Identifier A15 A16
			;
A15 : TypeArguments
			|
			;
A16 : DOT Identifier A15 A16
			|
			;
TypeArguments : LT TypeArgument A17 GT
			;
A17 : COMMA TypeArgument A17
			|
			;
TypeArgument : ReferenceType
			| QUESTIONMARK A18
			;
A18 : extends ReferenceType
			| super ReferenceType
			|
			;

// -----------------------------------------------
NonWildcardTypeArguments : LT TypeList GT
			;
TypeList : ReferenceType A19
			;
A19 : COMMA ReferenceType A19
			|
			;
TypeArgumentsOrDiamond: LT GT
			| TypeArguments
			;
NonWildcardTypeArgumentsOrDiamonds : LT GT
			| NonWildcardTypeArguments
			;
TypeParameters : LT TypeParameter A20 GT
			;
A20 : COMMA TypeParameter A20
			|
			;
TypeParameter : Identifier A21
			;
A21 : extends Bound
			|
			;
Bound : ReferenceType A22
			;
A22 : AND ReferenceType A22
			|
			;

// -----------------------------------------------
Modifier : Annotation
			| public
			| protected
			| private
			| static
			| abstract
			| final
			| native
			| synchronized
			| transient
			| volatile
			| strictfp
			;
Annotations : Annotation A23
			;
A23 : Annotation A23
			|
			;
Annotation : ATTHERATE QualifiedIdentifier A24
			;
A24 : LCB A25 RCB
			|
			;
A25 : AnnotationElement
			|
			;
AnnotationElement : ElementValuePairs
			| ElementValue
			;
ElementValuePairs : ElementValuePair A26
			;
A26 : COMMA ElementValuePair A26
			|
			;
ElementValuePair : Identifier EQUALS ElementValue
			;
ElementValue : Annotation
			| Expression1
			| ElementValueArrayInitializer
			;
ElementValueArrayInitializer : A27
			;
A27 : A28 A29 A27
			|
			;
A28 : ElementValues
			|
			;
A29 : COMMA
			|
			;
ElementValues : ElementValue A30
			;
A30 : COMMA ElementValue A30
			|
			;

// -----------------------------------------------
ClassBody : LCB A31 RCB
			;
A31 : ClassBodyDeclaration A31
			|
			;
ClassBodyDeclaration : SEMICOLON
			| A32 MemberDec1
			| A33 Block
			;
A32 : Modifier A32
			|
			;
A33 : static
			|
			;
MemberDec1 : MethodOrFieldDec1
			| void Identifier VoidMethodDeclaratorRest
			| Identifier ConstructorDeclaratorRest
			| GenericMethodOrConstructorDec1
			| ClassDeclaration
			| InterfaceDeclaration
			;
MethodOrFieldDec1 : Type Identifier MethodOrFieldRest
			;
MethodOrFieldRest : FieldDeclaratorsRest SEMICOLON
			| MethodDeclaratorRest
			;
FieldDeclaratorsRest : VariableDeclaratorRest A34
			;
A34 : COMMA VariableDeclarator A34
			|
			;
MethodDeclaratorRest : FormalParameters A35 A36 Block
			| FormalParameters A35 A36 SEMICOLON
			;
A35 : LSB RSB A35
			|
			;
A36 : throws QualifiedIdentifierList
			|
			;
VoidMethodDeclaratorRest : FormalParameters A36 Block
			| FormalParameters A36 SEMICOLON
			;
ConstructorDeclaratorRest: FormalParameters A36 Block
			;
GenericMethodOrConstructorDec1 : TypeParameters GenericMethodOrConstructorRest
			;
GenericMethodOrConstructorRest : A37 Identifier MethodDeclaratorRest
			| Identifier ConstructorDeclaratorRest
			;
A37 : Type
			| void
			;

// -----------------------------------------------
InterfaceBody : LCB A38 RCB
			;
A38 : InterfaceBodyDeclaration A38
			|
			;
InterfaceBodyDeclaration : SEMICOLON
			| A39 InterfaceMemberDec1
			;
A39 : Modifier A39
			|
			;
InterfaceMemberDec1 : InterfaceMethodOrFieldDec1
			| void Identifier VoidInterfaceMethodDeclaratorRest
			| InterfaceGenericMethodDec1
			| ClassDeclaration
			| InterfaceDeclaration
			;
InterfaceMethodOrFieldDec1 : Type Identifier InterfaceMethodOrFieldRest
			;
InterfaceMethodOrFieldRest : ConstantDeclaratorsRest SEMICOLON
			| InterfaceMethodDeclaratorRest
			;
ConstantDeclaratorsRest : ConstantDeclaratorRest A40
			;
A40 : COMMA ConstantDeclarator A40
			|
			;
ConstantDeclaratorRest: A41 EQUALS VariableInitializer
			;
A41 : LSB RSB A41
			|
			;
ConstantDeclarator : Identifier ConstantDeclaratorRest
			;
InterfaceMethodDeclaratorRest : FormalParameters A41 A36 SEMICOLON
			;
VoidInterfaceMethodDeclaratorRest : FormalParameters A36 SEMICOLON
			;
InterfaceGenericMethodDec1 : TypeParameters A42 Identifier InterfaceMethodDeclaratorRest
			;
A42 : Type
			| void
			;

// -----------------------------------------------
FormalParameters : LRB A43 RRB
			;
A43 : FormalParameterDecls
			;
FormalParameterDecls : A44 Type FormalParameterDeclsRest
			;
A44 : VariableModifier A44
			|
			;
VariableModifier : final
			| Annotation
			;
FormalParameterDeclsRest : VariableDeclaratorId A45
			| DOT DOT DOT VariableDeclaratorId
			;
A45 : COMMA FormalParameterDecls
			|
			;
VariableDeclaratorId : Identifier A46
			;
A46 : LSB RSB A46
			|
			;
VariableDeclarators : VariableDeclarator A47
			;
A47 : COMMA VariableDeclarator A47
			|
			;
VariableDeclarator: Identifier VariableDeclaratorRest
			;
VariableDeclaratorRest : A46 A47
			;
A47 : EQUALS VariableInitializer
			;
VariableInitializer : ArrayInitializer
			| Expression
			;
ArrayInitializer : LCB A48 RCB
			;
A48 : VariableInitializer A49 A50
			;
A49 : COMMA VariableInitializer A49
			|
			;
A50 : COMMA
			|
			;

// -----------------------------------------------
Block : LCB BlockStatements RCB
			;
BlockStatements : A51
			;
A51 : BlockStatement A51
			|
			;
BlockStatement : LocalVariableDeclarationStatement
			| ClassOrInterfaceDeclaration
			| A52 Statement
			;
A52 : Identifier COLON
			;
LocalVariableDeclarationStatement : A53 Type VariableDeclarators SEMICOLON
			;
A53 : VariableModifier A53
			|
			;
Statement : Block
			| SEMICOLON
			| Identifier COLON Statement
			| StatementExpression SEMICOLON
			| if ParExpression Statement A54
			| assert Expression A55 SEMICOLON
			| switch ParExpression LCB SwitchBlockStatementGroups RCB
			| while ParExpression Statement
			| do Statement while ParExpression SEMICOLON
			| for LRB ForControl RRB Statement
			| break A57 SEMICOLON
			| continue A57 SEMICOLON
			| RETURN A58 SEMICOLON
			| throw Expression SEMICOLON
			| synchronized ParExpression Block
			| try Block Catches
			| try A59 Finally
			| try ResourceSpecification Block A59 A60
			;
A54 : else Statement
			|
			;
A55 : COLON Expression
			|
			;
A57 : Identifier
			|
			;
A58 : Expression
			|
			;
A59 : Catches
			|
			;
A60 : Finally
			|
			;
StatementExpression : Expression
			;

// -----------------------------------------------
Catches : CatchClause A61
			;
A61 : CatchClause A61
			|
			;
CatchClause : catch LRB A53 CatchType Identifier RRB Block
			;
CatchType : QualifiedIdentifier A62
			;
A62 : OR QualifiedIdentifier A62
			|
			;
Finally : finally Block
			;
ResourceSpecification : LRB Resources A63 RRB
			;
A63 : SEMICOLON
			|
			;
Resources : Resource A64
			;
A64 : SEMICOLON Resource A64
			|
			;
Resource : A53 ReferenceType VariableDeclaratorId EQUALS Expression
			;

// -----------------------------------------------
SwitchBlockStatementGroups : A65
			;
A65 : SwitchBlockStatementGroup A65
			|
			;
SwitchBlockStatementGroup : SwitchLabels BlockStatements
			;
SwitchLabels : SwitchLabel A66
			;
A66 : SwitchLabel A66
			|
			;
SwitchLabel : case Expression COLON
			| case EnumConstantName COLON
			| default COLON
			;
EnumConstantName : Identifier
			;
ForControl : ForVarControl
			| ForInit SEMICOLON A67 SEMICOLON A68
			;
A67 : Expression
			|
			;
A68 : ForUpdate
			|
			;
ForVarControl : A53 Type VariableDeclaratorId ForVarControlRest
			;
ForVarControlRest : ForVariableDeclaratorsRest SEMICOLON A67 SEMICOLON A68
			| COLON Expression
			;
ForVariableDeclaratorsRest : A69 A70
			;
A69 : EQUALS VariableInitializer
			|
			;
A70 : COMMA VariableDeclarator A70
			|
			;
ForInit : 
			;
ForUpdate : StatementExpression A71
			;
A71 : COMMA StatementExpression A71
			|
			;

// -----------------------------------------------
Expression : Expression1 A72
			;
A72 : AssignmentOperator Expression1
			|
			;
AssignmentOperator : EQUALS
			| PLUS EQUALS
			| MINUS EQUALS
			| MULTIPLY EQUALS
			| DIVIDE EQUALS
			| AND EQUALS
			| OR EQUALS
			| POWER EQUALS
			| MODULUS EQUALS
			| LEFTSHIFT EQUALS
			| RIGHTSHIFT EQUALS
			| UNSIGNED_RIGHTSHIFT EQUALS
			;
Expression1 : Expression2 A73
			;
A73 : Expression1Rest
			|
			;
Expression1Rest : QUESTIONMARK Expression COLON Expression1
			;
Expression2 : Expression3 A74
			;
A74 : Expression2Rest
			|
			;
Expression2Rest : A75
			| instanceof Type
			;
A75 : InfixOp Expression3 A75
			|
			;

// -----------------------------------------------
InfixOp : OR OR
			| AND AND
			| OR
			| POWER
			| AND
			| EQUALS EQUALS
			| NOT EQUALS
			| LT
			| GT
			| LTE
			| GTE
			| LEFTSHIFT
			| RIGHTSHIFT
			| UNSIGNED_RIGHTSHIFT
			| PLUS
			| MINUS
			| MULTIPLY
			| DIVIDE
			| MODULUS
			;
Expression3 : PrefixOp Expression3
			| A76 Expression3
			| Primary A77 A78
			;
A76 : A79
			|
			;
A79 : Expression
			| Type
			;
A77 : Selector A77
			|
			;
A78 : PostfixOp A78
			|
			;
PrefixOp : PLUS PLUS
			| MINUS MINUS
			| NOT
			| TILD
			| PLUS
			| MINUS
			;
PostfixOp : PLUS PLUS
			| MINUS MINUS
			;

// -----------------------------------------------
Primary : Literal
			| ParExpression
			| this A80
			| super SuperSuffix
			| new Creator
			| NonWildcardTypeArguments ExplicitGenericInvocationSuffix
			| NonWildcardTypeArguments this Arguments
			| Identifier A81 A82
			| BasicType A83 DOT class
			| void DOT class
			;
A80 : Arguments
			|
			;
A81 : DOT Identifier A81
			|
			;
A82 : IdentifierSuffix
			|
			;
A83 : LSB RSB A83
			|
			;
Literal : IntegerLiteral
			| FloatingPointLiteral
			| CharacterLiteral
			| StringLiteral
			| BooleanLiteral
			| NullLiteral
			;
ParExpression : LRB Expression RRB
			;
Arguments :  LRB A84 RRB
			;
A84 : Expression A85
			|
			;
A85 : COMMA Expression A85
			|
			;
SuperSuffix : Arguments
			| DOT Identifier A80
			;
ExplicitGenericInvocationSuffix : super SuperSuffix
			| Identifier Arguments
			;

// -----------------------------------------------
Creator : NonWildcardTypeArguments CreatedName ClassCreatorRest
			| CreatedName ClassCreatorRest
			| CreatedName ArrayCreatorRest
			;
CreatedName : Identifier A86 A87
			;
A86 : TypeArgumentsOrDiamond
			|
			;
A87 : DOT Identifier A86 A87
			|
			;
ClassCreatorRest : Arguments A88
			;
A88 : ClassBody
			|
			;
ArrayCreatorRest : LSB RSB A83 ArrayInitializer
			| LSB Expression RSB A89 A83
			;
A89 : LSB Expression RSB A89
			|
			;
IdentifierSuffix : LSB A83 DOT class RSB
			| LSB Expression RSB
			| Arguments
			| DOT A90
			;
A90 : class
			| ExplicitGenericInvocation
			| this
			| super Arguments
			| new NonWildcardTypeArguments InnerCreator
			| new InnerCreator
			;
ExplicitGenericInvocation : NonWildcardTypeArguments ExplicitGenericInvocationSuffix
			;
InnerCreator : Identifier NonWildcardTypeArgumentsOrDiamonds ClassCreatorRest
			| Identifier ClassCreatorRest
			;
Selector : DOT Identifier Arguments
			| DOT Identifier
			| DOT ExplicitGenericInvocation
			| DOT this
			| DOT super SuperSuffix
			| DOT new NonWildcardTypeArguments InnerCreator
			| DOT new InnerCreator
			| Expression
			|
			;

// -----------------------------------------------
EnumBody : LCB A91 A92 A93 RCB
			;
A91 : EnumConstants
			|
			;
A92 : COMMA
			|
			;
A93 : EnumBodyDeclarations
			|
			;
EnumConstants : EnumConstant
			| EnumConstants COMMA EnumConstant
			;
EnumConstant : A94 Identifier A95 A96
			;
A94 : Annotations
			|
			;
A95 : Arguments
			|
			;
A96 : ClassBody
			|
			;
EnumBodyDeclarations : SEMICOLON A97
			;
A97 : ClassBodyDeclaration A97
			|
			;
AnnotationTypeBody : LCB AnnotationTypeElementDeclarations RCB
			| LCB RCB
			;
AnnotationTypeElementDeclarations : AnnotationTypeElementDeclaration
			| AnnotationTypeElementDeclarations AnnotationTypeElementDeclaration
			;
AnnotationTypeElementDeclaration : A98 AnnotationTypeElementRest
			;
A98 : Modifier A98
			|
			;
AnnotationTypeElementRest : Type Identifier AnnotationMethodOrConstantRest SEMICOLON
			| ClassDeclaration
			| InterfaceDeclaration
			| EnumDeclaration
			| AnnotationTypeDeclaration
			;
AnnotationMethodOrConstantRest : AnnotationMethodRest
			| ConstantDeclaratorsRest
			;
AnnotationMethodRest : LRB RRB A99 A100
			;
A99 : LSB RSB
			|
			;
A100 : default ElementValue
			|
			;
%%

int yyerror(char *msg)
{
//	printf("Invalid Expression\n");
	return 1;
}
void main()
{
	printf("Enter the expression\n");
	yyin = fopen("input.java", "r");
	// yyin = stdin;
do{
	if(yyparse())	
	{
		printf("\nFailure");
		exit(0);
	}
	}
	while(!feof(yyin));
	printf("Success");
	
}