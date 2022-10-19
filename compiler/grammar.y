%code requires{
	#include <string>
}
%{
	#include <math.h>
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

%token NAME COLON SEMICOLON RIGHT_ARROW LEFT_CURLY_BRACE RIGHT_CURLY_BRACE
	LEFT_PARENTHESIS RIGHT_PARENTHESIS SINGLECOMMENT MULTILINECOMMENTS
	PUTS QUOTES NUMBER SET INTEGER_VALUE DOLLAR_SIGN INC DEC LOGICAL TRUE 
	FALSE

%start input

%%

input: function function_list	{ 
result = 
std::string("#include <cstdio>\n #include <iostream>\n using namespace std; \n") +
 $1 + $2; 
	}
	;

function_list:
	function function_list	{ $$ = $1 + $2; }
	|
	%empty			{ $$ = ""; }
	;

function:
name COLON RIGHT_ARROW LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE	
{ 
	if($1 == "enter")
	{
	$$ = std::string("int main(int argc, char *argv[]){ \n") + 
	$5 + 
	"} \n";
	}  
	else
	{
	$$=std::string("void ") + "_" + $1 + "()" + "{ \n" + $5 + "} \n";
	}
}
	;

statements:
	statements statement	{ $$ = $1 + $2;  }
	|
	%empty			{ $$ = ""; }
	;

statement:
	unitaryOperation SEMICOLON { $$ = $1; }
	|
	assignment SEMICOLON	{ $$ = $1; }
	|
	definition SEMICOLON	{ $$ = $1; }
	|
	std_output SEMICOLON	{ $$ = $1; }
	|
	SINGLECOMMENT	{ $$ = ""; }
	|
	MULTILINECOMMENTS	{ $$ = ""; }
	|
	name SEMICOLON	{ $$ = "printf(\"%s \\n\", \"" + $1 + "\"); \n"; }
	|
	expression SEMICOLON	{ $$ = std::move($1); }
	;

unitaryOperation:
	INC identifiers		{ $$ = $2 + "++;\n"; }
	|
	DEC identifiers		{ $$ = $2 + "--;\n"; }
	;

assignment:
	SET name TRUE	{ $$ = $2 + "=true;\n"; }
	|
	SET name FALSE  { $$ = $2 + "=false;\n"; }
	|
	SET name integer_value	{ $$ = $2 + "=" + $3 + ";\n"; }
	;

definition:
	LOGICAL identifiers	{ $$ = "bool " + $2 + ";\n"; }
	|
	NUMBER identifiers	{ $$ = "int " + $2 +";\n"; }	
	;

identifiers:
	identifiers ids	{ $$ = $1 + $2; }
	|
	 %empty	{ $$ = ""; }
	;

ids:
	name { $$ = $1; }
	;

std_output:
	PUTS DOLLAR_SIGN name { $$ = "cout << " + $3 + " << endl;"; }
	|
	PUTS quotes characters_block quotes	
	{ $$ = "printf(\"" + $3 + "\");"; }
	;

characters_block:
	name	{ $$ = $1; }
	;

quotes:
	QUOTES { $$ = std::string(yytext); }
	;

expression:
	name LEFT_PARENTHESIS RIGHT_PARENTHESIS {
		$$ = std::string("_") + $1 + "();";
	}
name:
	NAME  { 
		$$ = std::string (yytext);
		}
	;

integer_value:
	INTEGER_VALUE	{ $$ = std::string(yytext); }
	;

%%

//std::unique_ptr<compiler::SyntaxTree> root;

void yyerror(char const *x){
	printf("Error %s \n", x);
	exit(1);
}


