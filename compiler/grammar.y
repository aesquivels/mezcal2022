%code requires{
	#include <string>
}
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <iostream>
	#include <memory>
	#include <string>
	using namespace std;
	extern char *yytext;
	std::string result;
	int yylex(void);
	void yyerror(char const *);
%}

%define api.value.type {std::string}

%token  ID COLON LEFT_BRACKET RIGHT_BRACKET RIGHT_ARROW LEFT_CURLY_BRACE 
	RIGHT_CURLY_BRACE SINGLECOMMENT QUOTES SHOW CHARACTERS SEMICOLON
	MULTILINECOMMENT INT LOAD INTEGER_VALUE GREATHER_THAN LESS_THAN
	QUESTION_MARK

%start input

%%

input:
	function function_list	{
result = std::string("#include <cstdio>\n #include <iostream> \n using namespace std; \n") + $1 + $2;
	}
	;

function_list:
	function function_list { $$ = $1 + $2; }
	|
	%empty		{ $$ = ""; }
	;

function:
	id COLON COLON LEFT_BRACKET RIGHT_BRACKET RIGHT_ARROW 
LEFT_BRACKET RIGHT_BRACKET COLON LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE	{
	$$ = std::string("int main(int argc, char *argv[]){ \n") + $11 + "} \n";
	}
	;

statements:
	statements statement	{ $$ = $1 + $2; }
	|
	%empty	{ $$ = ""; }
	;

statement:
	bifurcation { $$ = $1; }
	|
	assignment SEMICOLON	{ $$ = $1; }
	|
	std_input SEMICOLON	{ $$ = $1; }
	|
	definition SEMICOLON	{ $$ = $1; }
	|
	SINGLECOMMENT	{ $$ = ""; }
	|
	MULTILINECOMMENT	{ $$=""; }
	|
	std_output SEMICOLON	{ $$ = $1; }
	;

bifurcation:
LEFT_BRACKET logicalComparison RIGHT_BRACKET QUESTION_MARK LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE { 
	$$ = "if(" + $2 + "){" + $6 + "}"; 
}
;

logicalComparison:
	integer_value GREATHER_THAN integer_value { $$ = $1 + ">" + $3; }
	;

assignment:
	identifiers COLON integer_value { $$ = $1 + "=" + $3 + ";"; }
	;

integer_value:
	INTEGER_VALUE	{ $$= std::string(yytext); }
	;
std_input:
	LOAD COLON identifiers	{ $$ = "cin >> " + $3 + "; \n";}
	;

definition:
	identifiers COLON INT	{ $$ ="int " + $1 + "; \n"; }
	;

identifiers:
	identifiers ids	{ $$ = $1 + $2; }
	|
	%empty	{ $$ = ""; }
	;

ids:
	id	{ $$ = $1; }
	;

std_output:
	SHOW COLON characters { $$ = "cout << " + $3 + " << endl;\n";} 
	;

characters:
	CHARACTERS	{ $$ = std::string(yytext); }
	;

id:
	ID	{
		$$ = std::string(yytext);
	}
	;

%%
void yyerror(char const *x){
	printf("Error %s \n", x);
	exit (1);
}
