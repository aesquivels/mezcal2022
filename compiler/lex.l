%option noyywrap
%{
	#include "grammar.tab.h"
%}
digit	[0-9]
alpha	[a-zA-Z]
id	{alpha}({alpha}*{digit}*)+
whitespace	[ \r\t\v\f]
linefeed	\n
slash [/]
singlecomment	{slash}{slash}({dot}*{whitespace}*)+{linefeed}
dot .

%%

{singlecomment}	{ return SINGLECOMMENT; }
{id}	{ return ID; }
":"	{ return COLON; }
"["	{ return LEFT_BRACKET; }
"]"	{ return RIGHT_BRACKET; }
"->"	{ return RIGHT_ARROW; }
"{"	{ return LEFT_CURLY_BRACE; }
"}"	{ return RIGHT_CURLY_BRACE; }
{whitespace}
{linefeed}	++yylineno;
