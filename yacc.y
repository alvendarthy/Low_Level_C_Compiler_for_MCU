%{
#include "main.h"
#include "set_lable_id.h"

int g_lable_id = 0;

extern "C"
{
	void yyerror(const char *s);
	extern int yylex(void);
}

int yydebug=1;

%}
%token IF ELSE ELSIF DO WHILE BREAK CONTINUE GOTO RETURN
%token AND OR GT LT GE LE EC NE
%token SHL RSHL SHR RSHR INCR DECR
%token<ingeger>INTEGER
%token<str>IDENTIFIER
%token<str> ASM_CODE
%token AT_RAM  AT_CODE  AT_FUN AT_END AT_ASM
%token INT8
%type<str_list> codes indep_codes block function_block single_code
%type<str_list> if_statement partener_block 
%type<str_list> while_statement defination_code identifiers 
%type<str_list> normal_block asm_block codes_in_block
%type<str_list> asm_codes

%%

finally : codes
	{
		for(T_str_list_iter iter = $1.begin();iter != $1.end(); iter ++){
			cout << *iter << endl;
		}

	}
	| {}
	;

codes	: codes indep_codes
	{
		$$ = $1;
                $$.insert($$.end(), $2.begin(), $2.end());
	}
	| codes block
	{
		$$ = $1;
                $$.insert($$.end(), $2.begin(), $2.end());
	}
	| codes function_block
	{
		$$ = $1;
                $$.insert($$.end(), $2.begin(), $2.end());
	}
	| {}
	;

indep_codes : indep_codes single_code
	{
		$$ = $1;
		$$.insert($$.end(), $2.begin(), $2.end());
	}
	|  single_code
	{
		$$ = $1;
	}
	;

if_statement: IF '(' ')' partener_block
	{
		$$ = $4;
	}
	| IF '(' ')' partener_block ELSE partener_block
	{
		$$ = $4;
		$$.insert($$.end(), $6.begin(), $6.end())
	}
	;

while_statement: WHILE '(' ')' partener_block
	{
		$$ = $4;
	}
	| DO partener_block WHILE '(' ')' ';'
	{
		$$ = $2;
	}

partener_block: block
	{
		$$ = $1;
	}
	| single_code
	{
		$$ = $1;
	}
	;

single_code : defination_code
	{
		$$ = $1;

	}
	| if_statement
	{
		$$ = $1;
	}
	| while_statement
	{
		$$ = $1;
	}
	;

defination_code : INT8 identifiers ';' 
	{
		for(T_str_list_iter iter = $2.begin();iter != $2.end(); iter ++){
			string code = M_NEW_INT8(*iter);
			$$.push_back(code);
		}
	}
	;

identifiers : identifiers ',' IDENTIFIER
	{
		$$ = $1;
		$$.push_back($3);
	}
	| IDENTIFIER
	{
		$$.push_back($1);
	}
	;

block : normal_block
	{
		$$ = $1;
	}
	| asm_block
	{
		$$ = $1;
	}
	;

function_block : AT_FUN IDENTIFIER '(' ')' block
	{
		string code = M_NEW_FUNC_BGN($2);
		$$.push_back(code);
		$$.insert($$.end(), $5.begin(), $5.end());
		code = M_NEW_FUNC_END($2);
		$$.push_back(code);
	}
	;

normal_block : '{' codes_in_block '}' 
	{
		$$ = $2;
	}
	;

codes_in_block   : codes_in_block single_code
	{
		$$ = $1;
		$$.insert($$.end(), $2.begin(), $2.end());
	}
        | codes_in_block block
	{
		$$ = $1;
		$$.insert($$.end(), $2.begin(), $2.end());
	}
	| single_code
	{
		$$ = $1;
	}
	| block
	{
		$$ = $1;
	}
	| {}

asm_block: AT_ASM '{' asm_codes '}'
	{
		$$ = $3;
	}
	;

asm_codes : asm_codes ASM_CODE
	{
		$$.assign($1.begin(), $1.end());
                $$.push_back($2);
	}
	| ASM_CODE
	{
		$$.push_back($1);
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
