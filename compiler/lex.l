%option noyywrap
%{
	#include "grammar.tab.h"
%}
digit [0-9]
alpha [a-zA-Z]
name {alpha}([0-9]*{alpha}*)+
singlecomment {slash}{slash}({dot}*{whitespace}*)+{linefeed}
multilinecomments {slash}{wildcard}({dot}*{whitespace}*{linefeed}*)+{wildcard}{slash}
whitespace [ \r\t\v\f]
linefeed \n
slash [/]
wildcard [*]
quotes [\"]
dot .

%%

{quotes}	{ return QUOTES; }
"number"	{ return NUMBER; }
"puts"		{ return PUTS; }
"set"		{ return SET; }
"inc"		{ return INC; }
"dec"		{ return DEC; }
"logical"	{ return LOGICAL; }
{digit}+	{ return INTEGER_VALUE; }
"true"		{ return TRUE; }
"false"		{ return FALSE; }
{name}	{
		return NAME; 
	}
{singlecomment}	{ 
			return SINGLECOMMENT; 
		}
{multilinecomments}	{
			return MULTILINECOMMENTS;
		}
":"	{ 
		return COLON; 
	}
";"	{ 
		return SEMICOLON; 
	}
"->"	{ 
		return RIGHT_ARROW; 
	}
"{"	{ 
		return LEFT_CURLY_BRACE; 
	}
"}"	{ 
		return RIGHT_CURLY_BRACE; 
	}
"("	{
		return LEFT_PARENTHESIS;
	}
")"	{
		return RIGHT_PARENTHESIS;
	}
"$"	{
		return DOLLAR_SIGN;
	}
{whitespace}	
{linefeed}	++yylineno;

%%

#include <stdio.h>