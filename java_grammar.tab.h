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
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    DOT = 258,
    COMMA = 259,
    SEMICOLON = 260,
    CBYTE = 261,
    CINT = 262,
    SHORT = 263,
    LONG = 264,
    CHAR = 265,
    FLOAT = 266,
    DOUBLE = 267,
    EXTENDS = 268,
    SUPER = 269,
    CLASS = 270,
    PUBLIC = 271,
    PROTECTED = 272,
    PRIVATE = 273,
    ABSTRACT = 274,
    IMPORT = 275,
    STATIC = 276,
    FINAL = 277,
    FINALLY = 278,
    VOLATILE = 279,
    TRANSIENT = 280,
    BOOLEAN = 281,
    IMPLEMENTS = 282,
    VOID = 283,
    THIS = 284,
    THROWS = 285,
    INTERFACE = 286,
    DEFAULT = 287,
    INSTANCEOF = 288,
    QUESTION = 289,
    IF = 290,
    ELSE = 291,
    NEW = 292,
    CASE = 293,
    SWITCH = 294,
    Identifier = 295,
    INTEGER = 296,
    FLOATING = 297,
    CNULL = 298,
    FOR = 299,
    WHILE = 300,
    OCB = 301,
    OBB = 302,
    OB = 303,
    CCB = 304,
    CBB = 305,
    CB = 306,
    CONTINUE = 307,
    BREAK = 308,
    COLON = 309,
    RETURN = 310,
    CATCH = 311,
    SYNCHRONIZED = 312,
    THROW = 313,
    DO = 314,
    TRY = 315,
    PACKAGE = 316,
    NATIVE = 317,
    STRING = 318,
    LT = 319,
    GT = 320,
    EQUALS = 321,
    EXP = 322,
    MOD = 323,
    PLUS = 324,
    MINUS = 325,
    NOT = 326,
    TILDE = 327,
    AND = 328,
    OR = 329,
    DAND = 330,
    DOR = 331,
    CMUL = 332,
    CDIV = 333,
    SHIFTLEFT = 334,
    SHIFTRIGHT = 335,
    USHIFTRIGHT = 336,
    INCREMENT = 337,
    DECREMENT = 338
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
