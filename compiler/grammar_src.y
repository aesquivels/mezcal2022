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
	FALSE NTOL CHARACTERS GETS STDIN PLUS MINUS MUL DIV EQ GT LE GE LT NE
	LEFT_BRACKET RIGHT_BRACKET QUESTION_MARK EXCLAMATION_MARK
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
	tertiaryOperator	{ $$ = $1; }
	|
	logicalComparation SEMICOLON  { $$ =  $1; }
	|
	std_input SEMICOLON	{ $$ = $1; }
	|
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

tertiaryOperator:
LEFT_BRACKET logicalComparation RIGHT_BRACKET QUESTION_MARK 
statement EXCLAMATION_MARK statement {
		//$$ = "cout << \"now working\";";
		$$ = "if (" + $2 + "){" + $5 + "} else {" + $7 + "}\n";
}
	;

logicalComparation:
	DOLLAR_SIGN name EQ DOLLAR_SIGN name { $$ = $2 + "==" + $5; }
	;

std_input:
	GETS STDIN name { $$ = "cin >> "  + $3 + ";\n"; }
	;

unitaryOperation:
	INC identifiers		{ $$ = $2 + "++;\n"; }
	|
	DEC identifiers		{ $$ = $2 + "--;\n"; }
	;

assignment:
	SET name mathOperation	{ 
		$$ = $2 + "=" + $3 + ";\n"; 
	}
	|
	SET name TRUE	{ $$ = $2 + "=true;\n"; }
	|
	SET name FALSE  { $$ = $2 + "=false;\n"; }
	|
	SET name integer_value	{ $$ = $2 + "=" + $3 + ";\n"; }
	;

mathOperation:
	name PLUS name	{ $$ = std::string($1 + "+" + $3); }
	|
	name MINUS name { $$ = std::string($1 + "-" + $3); }
	|
	name MUL name { $$ = std::string($1 + "*" + $3); }
	|
	name DIV name { $$ = std::string($1 + "/" + $3); }
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
	PUTS NTOL DOLLAR_SIGN name {
$$ = "cout << ((" + $4 + "==1) ? \"true\" : \"false\") << endl;";
	}
	|
	PUTS DOLLAR_SIGN name { $$ = "cout << " + $3 + " << endl;"; }
	|
	PUTS characters	
	{ $$ = "cout << " + $2 + " << endl;"; }
	;

characters:
	CHARACTERS	{ $$ = std::string(yytext); }
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


