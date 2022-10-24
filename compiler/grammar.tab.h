/* A Bison parser, made by GNU Bison 3.7.5.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_GRAMMAR_TAB_H_INCLUDED
# define YY_YY_GRAMMAR_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 1 "compiler/grammar.y"

	#include <string>

#line 53 "grammar.tab.h"

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    NAME = 258,                    /* NAME  */
    COLON = 259,                   /* COLON  */
    SEMICOLON = 260,               /* SEMICOLON  */
    RIGHT_ARROW = 261,             /* RIGHT_ARROW  */
    LEFT_CURLY_BRACE = 262,        /* LEFT_CURLY_BRACE  */
    RIGHT_CURLY_BRACE = 263,       /* RIGHT_CURLY_BRACE  */
    LEFT_PARENTHESIS = 264,        /* LEFT_PARENTHESIS  */
    RIGHT_PARENTHESIS = 265,       /* RIGHT_PARENTHESIS  */
    SINGLECOMMENT = 266,           /* SINGLECOMMENT  */
    MULTILINECOMMENTS = 267,       /* MULTILINECOMMENTS  */
    PUTS = 268,                    /* PUTS  */
    QUOTES = 269,                  /* QUOTES  */
    NUMBER = 270,                  /* NUMBER  */
    SET = 271,                     /* SET  */
    INTEGER_VALUE = 272,           /* INTEGER_VALUE  */
    DOLLAR_SIGN = 273,             /* DOLLAR_SIGN  */
    INC = 274,                     /* INC  */
    DEC = 275,                     /* DEC  */
    LOGICAL = 276,                 /* LOGICAL  */
    TRUE = 277,                    /* TRUE  */
    FALSE = 278,                   /* FALSE  */
    NTOL = 279,                    /* NTOL  */
    CHARACTERS = 280,              /* CHARACTERS  */
    GETS = 281,                    /* GETS  */
    STDIN = 282                    /* STDIN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef std::string YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_GRAMMAR_TAB_H_INCLUDED  */
