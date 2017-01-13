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
%token AND OR GT LT GE LE EQ NE
%token<str> CMP
%token<str> LOGICAL_CHAR CALC_CHAR SELF_CALC
%token SHL RSHL SHR RSHR
%token<integer>INTEGER
%token<str>IDENTIFIER
%token<str> ASM_CODE
%token AT_RAM  AT_CODE  AT_FUN AT_END AT_ASM
%token INT8
%type<str_list> codes indep_codes block function_block single_code
%type<str_list> if_statement partener_block
%type<str_list> while_statement defination_code identifiers 
%type<str_list> normal_block asm_block codes_in_block
%type<str_list> asm_codes math_op jump_statement addr_set
%type<str> logical_exps logical_exp self_calc calc_statement

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

if_statement: IF '(' logical_exps ')' partener_block
	{
		g_lable_id ++;
		string label_id = int2string(g_lable_id);
		string code = "";
		
		PUSH_BACK($$,M_LABEL_BGN(label_id),code);
		PUSH_BACK($$,M_IF_BGN(label_id),code);
		PUSH_BACK($$,M_LABEL_LOGICAL_BGN(label_id),code);
		PUSH_BACK($$,M_LOGICAL_EXP($3),code);
		PUSH_BACK($$,M_LABEL_LOGICAL_END(label_id),code);
		PUSH_BACK($$,M_LABEL_TRUE_BGN(label_id),code);
		PUSH_BACK_LIST($$,$5);
		PUSH_BACK($$,M_LABEL_TRUE_END(label_id),code);
	 	PUSH_BACK($$,M_LABEL_FALSE_BGN(label_id),code);
	 	PUSH_BACK($$,M_LABEL_FALSE_END(label_id),code);
		PUSH_BACK($$,M_IF_END(label_id),code);
		PUSH_BACK($$,M_LABEL_END(label_id),code);
		
	}
	| IF '(' logical_exps ')' partener_block ELSE partener_block
	{
		g_lable_id ++;
                string label_id = int2string(g_lable_id);
                string code = "";

                PUSH_BACK($$,M_LABEL_BGN(label_id),code);
		PUSH_BACK($$,M_IF_BGN(label_id),code);
                PUSH_BACK($$,M_LABEL_LOGICAL_BGN(label_id),code);
                PUSH_BACK($$,M_LOGICAL_EXP($3),code);
                PUSH_BACK($$,M_LABEL_LOGICAL_END(label_id),code);
                PUSH_BACK($$,M_LABEL_TRUE_BGN(label_id),code);
                PUSH_BACK_LIST($$,$5);
                PUSH_BACK($$,M_LABEL_TRUE_END(label_id),code);
                PUSH_BACK($$,M_LABEL_FALSE_BGN(label_id),code);
		PUSH_BACK_LIST($$,$7);
                PUSH_BACK($$,M_LABEL_FALSE_END(label_id),code);
		PUSH_BACK($$,M_IF_END(label_id),code);
                PUSH_BACK($$,M_LABEL_END(label_id),code);
	}
	;

while_statement: WHILE '(' logical_exps ')' partener_block
	{
		g_lable_id ++;
                string label_id = int2string(g_lable_id);
                string code = "";

		PUSH_BACK($$,M_LABEL_BGN(label_id),code);
		PUSH_BACK($$,M_WHILE_BGN(label_id),code);
                PUSH_BACK($$,M_LABEL_LOGICAL_BGN(label_id),code);
                PUSH_BACK($$,M_LOGICAL_EXP($3),code);
                PUSH_BACK($$,M_LABEL_LOGICAL_END(label_id),code);
                PUSH_BACK($$,M_LABEL_TRUE_BGN(label_id),code);
		PUSH_BACK_LIST($$,$5);
		PUSH_BACK($$,M_LABEL_TRUE_END(label_id),code);
                PUSH_BACK($$,M_LABEL_FALSE_BGN(label_id),code);
		PUSH_BACK($$,M_LABEL_FALSE_END(label_id),code);
		PUSH_BACK($$,M_GOTO(S_LABEL_BGN(label_id)),code);
		PUSH_BACK($$,M_WHILE_END(label_id),code);
                PUSH_BACK($$,M_LABEL_END(label_id),code);

	}
	| DO partener_block WHILE '(' logical_exps ')' ';'
	{
		g_lable_id ++;
                string label_id = int2string(g_lable_id);
                string code = "";

		PUSH_BACK($$,M_LABEL_BGN(label_id),code);
		PUSH_BACK($$,M_WHILE_BGN(label_id),code);
		PUSH_BACK($$,M_LABEL_TRUE_BGN(label_id),code);
		PUSH_BACK_LIST($$,$2);
		PUSH_BACK($$,M_LABEL_TRUE_END(label_id),code);
		PUSH_BACK($$,M_LABEL_LOGICAL_BGN(label_id),code);
                PUSH_BACK($$,M_LOGICAL_EXP($5),code);
                PUSH_BACK($$,M_LABEL_LOGICAL_END(label_id),code);
		PUSH_BACK($$,M_LABEL_FALSE_BGN(label_id),code);
                PUSH_BACK($$,M_LABEL_FALSE_END(label_id),code);
		PUSH_BACK($$,M_WHILE_END(label_id),code);
		PUSH_BACK($$,M_LABEL_END(label_id),code);	
	}

logical_exps: logical_exp
	{
		$$ = $1;
	}
	| logical_exps LOGICAL_CHAR logical_exp
	{
		$$ = $1 + $2 + $3;
	}
	;

logical_exp : IDENTIFIER CMP IDENTIFIER 
        {       
                $$ = $1 + $2 + $3;
        }
        | IDENTIFIER CMP INTEGER
        {       
                $$ = $1 + $2 + int2string($3);
        }
        | INTEGER CMP IDENTIFIER 
        {       
                $$ = int2string($1) +$2 + $3;
        }
	| INTEGER
	{
		$$ = int2string($1);
	}
	;

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
	| math_op
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
	| jump_statement
	{
		$$ = $1;
	}
	| addr_set
	{
		$$ = $1;
	}

addr_set : AT_CODE INTEGER
	{
		string code = "";
		string addr = int2string($2);
                PUSH_BACK($$,M_CODE_AT(addr),code);
	}
	| AT_RAM INTEGER
	{
		string code = "";
		string addr = int2string($2);
                PUSH_BACK($$,M_RAM_AT(addr),code);
	}
	;

jump_statement: BREAK ';'
        {
		string code = "";
                PUSH_BACK($$,M_BREAK(),code);
        }
        | CONTINUE ';'
        {
		string code = "";
                PUSH_BACK($$,M_CONTINUE(),code);
        }
	| GOTO IDENTIFIER ';'
	{
		string code = "";
                PUSH_BACK($$,M_GOTO($2),code);
	}
	| IDENTIFIER ':'
	{
		string code = "";
                PUSH_BACK($$,M_LABEL($1),code);
	}
	;

math_op: calc_statement
	{
		string code = "";
                PUSH_BACK($$,M_MATH($1),code);
	}
	| self_calc
	{
		string code = "";
                PUSH_BACK($$,M_MATH($1),code);
	}
	;

calc_statement : IDENTIFIER '=' IDENTIFIER CALC_CHAR IDENTIFIER ';'
        {
                $$ = $1 + "=" + $3 + $4 + $5;
        }
        | IDENTIFIER '=' IDENTIFIER CALC_CHAR INTEGER ';'
        {
                $$ = $1 + "=" + $3 + $4 + int2string($5);
        }
        | INTEGER '=' IDENTIFIER CALC_CHAR IDENTIFIER  ';'
        {
                $$ = int2string($1) + "=" + $3 + $4 + $5;
        }
	;

self_calc : IDENTIFIER SELF_CALC ';'
	{
		$$ = $1 + $2;
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
