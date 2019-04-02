/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_JAVA_GRAMMAR_TAB_H_INCLUDED
# define YY_YY_JAVA_GRAMMAR_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    COMMA = 258,
    SEMICOLON = 259,
    CBYTE = 260,
    CINT = 261,
    SHORT = 262,
    LONG = 263,
    CHAR = 264,
    FLOAT = 265,
    DOUBLE = 266,
    EXTENDS = 267,
    SUPER = 268,
    CLASS = 269,
    PUBLIC = 270,
    PROTECTED = 271,
    PRIVATE = 272,
    ABSTRACT = 273,
    IMPORT = 274,
    STATIC = 275,
    FINAL = 276,
    FINALLY = 277,
    VOLATILE = 278,
    TRANSIENT = 279,
    BOOLEAN = 280,
    IMPLEMENTS = 281,
    VOID = 282,
    THIS = 283,
    THROWS = 284,
    INTERFACE = 285,
    DEFAULT = 286,
    INSTANCEOF = 287,
    QUESTION = 288,
    IF = 289,
    ELSE = 290,
    NEW = 291,
    CASE = 292,
    SWITCH = 293,
    INTEGER = 294,
    FLOATING = 295,
    CNULL = 296,
    FOR = 297,
    WHILE = 298,
    CCB = 299,
    CBB = 300,
    CB = 301,
    CONTINUE = 302,
    BREAK = 303,
    COLON = 304,
    RETURN = 305,
    CATCH = 306,
    SYNCHRONIZED = 307,
    THROW = 308,
    DO = 309,
    TRY = 310,
    PACKAGE = 311,
    NATIVE = 312,
    STRING = 313,
    LT = 314,
    GT = 315,
    EQUALS = 316,
    EXP = 317,
    MOD = 318,
    PLUS = 319,
    MINUS = 320,
    NOT = 321,
    TILDE = 322,
    AND = 323,
    OR = 324,
    DAND = 325,
    DOR = 326,
    CMUL = 327,
    CDIV = 328,
    SHIFTLEFT = 329,
    SHIFTRIGHT = 330,
    USHIFTRIGHT = 331,
    INCREMENT = 332,
    DECREMENT = 333,
    Identifier = 334,
    DOT = 335,
    OBB = 336,
    OB = 337,
    OCB = 338
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_JAVA_GRAMMAR_TAB_H_INCLUDED  */
