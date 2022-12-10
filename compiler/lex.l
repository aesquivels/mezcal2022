%option noyywrap
%{
	#include "grammar.tab.h"
%}
/* definition expression regular */
digit	[0-9]
alpha	[a-zA-Z]
id	{alpha}({alpha}*{digit}*)+
whitespace	[ \r\t\v\f]
linefeed	\n
slash [/]
opencomment	[<+]
closecomment    [+>]
singlecomment	{slash}{slash}({dot}*{whitespace}*)+{linefeed}
multilinecomment {opencomment}({dot}*{whitespace}*{linefeed}*)+{closecomment}
quotes [\"]
characters	{quotes}({alpha}*{digit}*{whitespace}*:*)+{quotes}
dot .

%%

{digit}+	{ return INTEGER_VALUE; }
{singlecomment}	{ return SINGLECOMMENT; }
{multilinecomment}	{ return MULTILINECOMMENT; }
"Int"	{ return INT; }
"load"	{ return LOAD; }
"show"	{ return SHOW; }
{id}	{ return ID; }
{quotes} { return QUOTES; }
{characters}	 { return CHARACTERS; }
":"	{ return COLON; }
";"	{ return SEMICOLON; }
"["	{ return LEFT_BRACKET; }
"]"	{ return RIGHT_BRACKET; }
">"	{ return GREATHER_THAN; }
"?"	{ return QUESTION_MARK; }
"<"	{ return LESS_THAN; }
"->"	{ return RIGHT_ARROW; }
"{"	{ return LEFT_CURLY_BRACE; }
"}"	{ return RIGHT_CURLY_BRACE; }
{whitespace}
{linefeed}	++yylineno;
