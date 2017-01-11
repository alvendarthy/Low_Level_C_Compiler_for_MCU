%{
#include "main.h"
#include "set_lable_id.h"

int g_lable_id = 0;

extern "C"
{
	void yyerror(const char *s);
	extern int yylex(void);
}

%}
%token IF ELSE ELSIF DO WHILE BREAK CONTINUE GOTO RETURN
%token AND OR GT LT GE LE EC NE
%token SHL RSHL SHR RSHR INCR DECR
%token<value>INTEGER
%token<name>IDENTIFIER
%token<name> ASM_CODE
%token AT_RAM  AT_CODE  AT_FUN AT_END AT_ASM
%token INT8 BIT

%%

finally : codes
	| {}
	;

codes	: codes indep_codes
	| codes block
	| codes function_block
	| {}
	;

indep_codes : indep_codes single_code
	| {}
	;

single_code : defination_code
	;

defination_code : INT8 identifiers ';' 
	;

identifiers : identifiers ',' IDENTIFIER
	{
		cout << "new var: " << $3  << endl;
	}
	| IDENTIFIER
	{
		cout << "new var: " << $1  << endl;
	}
	;

block : normal_block
	| asm_block
	;

function_block : AT_FUN IDENTIFIER '(' ')' block
	{
		cout << "new function " << $2 << endl;
	}
	;

normal_block : '{' codes '}' 
	{
		cout << "new block" << endl;
	}
	;

asm_block: AT_ASM '{' asm_codes '}'
	;

asm_codes : asm_codes ASM_CODE
	{
		cout << "asm code: " << $2 << endl;
	}
	| {}
	;
%%

void yyerror(const char *s)
{
	cerr<<"------------"<<s<<endl;
}

int main()
{
	const char* sFile="file.txt";
	FILE* fp=fopen(sFile, "r");
	if(fp==NULL)
	{
		printf("cannot open %s\n", sFile);
		return -1;
	}
	extern FILE* yyin;
	yyin=fp;

	yyparse();

	fclose(fp);
	return 0;
}
