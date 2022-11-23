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
	RIGHT_CURLY_BRACE SINGLECOMMENT

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
	$$ = std::string("int main(int argc, char *argv[]){") + $11 + "}";
	}
	;

statements:
	statements statement	{ $$ = $1 + $2; }
	|
	%empty	{ $$ = ""; }
	;

statement:
	SINGLECOMMENT	{ $$ = ""; }
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
