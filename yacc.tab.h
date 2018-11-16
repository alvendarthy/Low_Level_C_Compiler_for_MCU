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

#ifndef YY_YY_YACC_TAB_H_INCLUDED
# define YY_YY_YACC_TAB_H_INCLUDED
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
    IF = 258,
    ELSE = 259,
    ELSIF = 260,
    DO = 261,
    WHILE = 262,
    BREAK = 263,
    CONTINUE = 264,
    GOTO = 265,
    RETURN = 266,
    AND = 267,
    OR = 268,
    GT = 269,
    LT = 270,
    GE = 271,
    LE = 272,
    EQ = 273,
    NE = 274,
    CLRWDT = 275,
    NOP = 276,
    ADD_SELF = 277,
    SUB_SELF = 278,
    RL = 279,
    RLC = 280,
    RR = 281,
    RRC = 282,
    CMP = 283,
    LOGICAL_CHAR = 284,
    CALC_CHAR = 285,
    SELF_CALC = 286,
    SHL = 287,
    RSHL = 288,
    SHR = 289,
    RSHR = 290,
    INTEGER = 291,
    IDENTIFIER = 292,
    ASM_CODE = 293,
    AT_RAM = 294,
    AT_CODE = 295,
    AT_FUN = 296,
    AT_END = 297,
    AT_ASM = 298,
    INT8 = 299,
    BIT = 300
  };
#endif

/* Value type.  */


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_YACC_TAB_H_INCLUDED  */
