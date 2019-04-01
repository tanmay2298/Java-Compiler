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
     LAB = 293,
     RAB = 294,
     LCB = 295,
     RCB = 296,
     LSB = 297,
     RSB = 298,
     LRB = 299,
     RRB = 300,
     QUESTIONMARK = 301,
     AND = 302,
     OR = 303,
     LEFTSHIFT = 304,
     RIGHTSHIFT = 305,
     UNSIGNED_RIGHTSHIFT = 306,
     LT = 307,
     LTE = 308,
     GT = 309,
     GTE = 310,
     for = 311,
     if = 312,
     else = 313,
     switch = 314,
     while = 315,
     do = 316,
     break = 317,
     continue = 318,
     COLON = 319,
     throw = 320,
     finally = 321,
     EQUALS = 322,
     ATTHERATE = 323,
     TILD = 324,
     catch = 325,
     return = 326,
     IDENTIFIER = 327,
     throws = 328,
     interface = 329,
     new = 330,
     try = 331,
     super = 332,
     instanceof = 333,
     NOT = 334,
     FloatingPointLiteral = 335,
     IntegerLiteral = 336,
     CharacterLiteral = 337,
     BooleanLiteral = 338,
     assert = 339,
     StringLiteral = 340,
     NullLiteral = 341,
     extends = 342,
     class = 343,
     implements = 344
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
#define LAB 293
#define RAB 294
#define LCB 295
#define RCB 296
#define LSB 297
#define RSB 298
#define LRB 299
#define RRB 300
#define QUESTIONMARK 301
#define AND 302
#define OR 303
#define LEFTSHIFT 304
#define RIGHTSHIFT 305
#define UNSIGNED_RIGHTSHIFT 306
#define LT 307
#define LTE 308
#define GT 309
#define GTE 310
#define for 311
#define if 312
#define else 313
#define switch 314
#define while 315
#define do 316
#define break 317
#define continue 318
#define COLON 319
#define throw 320
#define finally 321
#define EQUALS 322
#define ATTHERATE 323
#define TILD 324
#define catch 325
#define return 326
#define IDENTIFIER 327
#define throws 328
#define interface 329
#define new 330
#define try 331
#define super 332
#define instanceof 333
#define NOT 334
#define FloatingPointLiteral 335
#define IntegerLiteral 336
#define CharacterLiteral 337
#define BooleanLiteral 338
#define assert 339
#define StringLiteral 340
#define NullLiteral 341
#define extends 342
#define class 343
#define implements 344




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

