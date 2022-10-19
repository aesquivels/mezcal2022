#include <iostream>
#include <memory>
#include "SyntaxTree/SyntaxTree.hpp"

extern int yyparse();
extern int yylineno;
//extern std::unique_ptr<compiler::SyntaxTree> root;
extern std::string result;

int main(){
	int parse_result = yyparse();
	/*        
	if(result==0){
		std::cout << "Valid input" << std::endl;
	} else {
		std::cout << "Invalid input" << std::endl;
	}
	std::cout << "The amount of lines in the input: " << yylineno << std::endl;
	//std::cout << "Result value: " << result << std::endl;
	*/
	std::cout << result  << std::endl;
	return parse_result;
}




