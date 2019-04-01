/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     DOT = 258,
     COMMA = 259,
     SEMICOLON = 260,
     package = 261,
     import = 262,
     static = 263,
     void = 264,
     final = 265,
     PLUS = 266,
     MULTIPLY = 267,
     DIVIDE = 268,
     MINUS = 269,
     MODULUS = 270,
     POWER = 271,
     this = 272,
     case = 273,
     default = 274,
     byte = 275,
     boolean = 276,
     short = 277,
     char = 278,
     int = 279,
     float = 280,
     double = 281,
     enum = 282,
     long = 283,
     public = 284,
     private = 285,
     protected = 286,
     abstract = 287,
     native = 288,
     synchronized = 289,
     transient = 290,
     volatile = 291,
     strictfp = 292,
     LCB = 293,
     RCB = 294,
     LSB = 295,
     RSB = 296,
     LRB = 297,
     RRB = 298,
     QUESTIONMARK = 299,
     AND = 300,
     OR = 301,
     LEFTSHIFT = 302,
     RIGHTSHIFT = 303,
     UNSIGNED_RIGHTSHIFT = 304,
     LT = 305,
     LTE = 306,
     GT = 307,
     GTE = 308,
     for = 309,
     if = 310,
     else = 311,
     switch = 312,
     while = 313,
     do = 314,
     break = 315,
     continue = 316,
     COLON = 317,
     throw = 318,
     finally = 319,
     EQUALS = 320,
     ATTHERATE = 321,
     TILD = 322,
     catch = 323,
     RETURN = 324,
     IDENTIFIER = 325,
     throws = 326,
     interface = 327,
     new = 328,
     try = 329,
     super = 330,
     instanceof = 331,
     NOT = 332,
     FloatingPointLiteral = 333,
     IntegerLiteral = 334,
     CharacterLiteral = 335,
     BooleanLiteral = 336,
     assert = 337,
     StringLiteral = 338,
     NullLiteral = 339,
     extends = 340,
     class = 341,
     implements = 342
   };
#endif
/* Tokens.  */
#define DOT 258
#define COMMA 259
#define SEMICOLON 260
#define package 261
#define import 262
#define static 263
#define void 264
#define final 265
#define PLUS 266
#define MULTIPLY 267
#define DIVIDE 268
#define MINUS 269
#define MODULUS 270
#define POWER 271
#define this 272
#define case 273
#define default 274
#define byte 275
#define boolean 276
#define short 277
#define char 278
#define int 279
#define float 280
#define double 281
#define enum 282
#define long 283
#define public 284
#define private 285
#define protected 286
#define abstract 287
#define native 288
#define synchronized 289
#define transient 290
#define volatile 291
#define strictfp 292
#define LCB 293
#define RCB 294
#define LSB 295
#define RSB 296
#define LRB 297
#define RRB 298
#define QUESTIONMARK 299
#define AND 300
#define OR 301
#define LEFTSHIFT 302
#define RIGHTSHIFT 303
#define UNSIGNED_RIGHTSHIFT 304
#define LT 305
#define LTE 306
#define GT 307
#define GTE 308
#define for 309
#define if 310
#define else 311
#define switch 312
#define while 313
#define do 314
#define break 315
#define continue 316
#define COLON 317
#define throw 318
#define finally 319
#define EQUALS 320
#define ATTHERATE 321
#define TILD 322
#define catch 323
#define RETURN 324
#define IDENTIFIER 325
#define throws 326
#define interface 327
#define new 328
#define try 329
#define super 330
#define instanceof 331
#define NOT 332
#define FloatingPointLiteral 333
#define IntegerLiteral 334
#define CharacterLiteral 335
#define BooleanLiteral 336
#define assert 337
#define StringLiteral 338
#define NullLiteral 339
#define extends 340
#define class 341
#define implements 342




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

