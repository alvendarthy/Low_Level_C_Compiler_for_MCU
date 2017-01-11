%{
#include "main.h"
#include "yacc.tab.h"
#include  "set_lable_id.h"

extern "C"
{
	int yywrap(void);
	int yylex(void);
}
%}

%x      ASM ASM_READY
%x	COMMENT MULTY_COMMENT

nondigit	([_A-Za-z])

digit		([0-9])

integer		({digit}+)

hex		(0[xX][0-9a-fA-F]+)

bin		(0[bB][01]+)

identifier	({nondigit}({nondigit}|{digit})*)

blank_chars	([ \f\r\t\v])

%%

"@ram"  {
                return AT_RAM;
        }

"@code" {
                return AT_CODE;
        }

"@function" {
                return AT_FUN;
        }

"return" {
                return RETURN;
        }

"@asm" {
                BEGIN ASM_READY;
		return AT_ASM;
        }

<ASM_READY>"{" {
		BEGIN ASM;
		return '{';
	}
<ASM_READY>\n {}

<ASM>^[^}\n]* {
		yylval.name = yytext;
                return ASM_CODE;
        }
<ASM>\n {}

<ASM>"}" {
                BEGIN INITIAL;
		return '}';
	}

"@end" {
                return AT_END;
        }

"int8" {
                return INT8;
        }

"bit" {
                return BIT;
        }

"if"    {
                return IF;
        }

"else" {
                return ELSE;
        }
"elsif" {
		return ELSIF;
	}

"switch" {
                printf("SWITCH statement.\n");
                //return SWITCH;
         }

"case" {
                printf("CASE statement.\n");
                //return CASE;
        }

"default" {
                printf("DEFAULT statement.\n");
                //return DEFAULT;
        }

"while" {
                return WHILE;
        }

"do" {
		return DO;
}

"break" {
                return BREAK;
        }

"continue" {
                return CONTINUE;
        }

"goto" {
		return GOTO;
	}

">>" {
		return SHR;
	}

">>>" {
		return RSHR;
	}

"<<" {
		return SHL;
	}

"<<<" {
		return RSHL;
	}

"++" {
		return INCR;
	}

"--" {
		return DECR;
	}

">"	{
		return GT;
	}

">="	{
		return GE;
	}

"<"	{
		return LT;
	}

"<="	{
		return LE;
	}

"=="	{
		return EC;
	}

"!="	{
		return NE;
	}

"&&"	{
		return AND;
	}

"||"	{
		return OR;
	}

{identifier}	{
			yylval.name=yytext;
			return IDENTIFIER;
		}

{integer}	{
			yylval.value=atoi(yytext);
			return INTEGER;
		}

{bin}		{
			yylval.value=bin2int(yytext, strlen(yytext));
                        return INTEGER;
		}

{hex}		{
			yylval.value=hex2int(yytext, strlen(yytext));
                        return INTEGER;
		}

{blank_chars}	{
		}

\n		{
		}

"//"		{
			BEGIN COMMENT;
		}

.		{
			return yytext[0];
		}

<COMMENT>\n	{
			BEGIN INITIAL;
		}

<COMMENT>.	{
		}

"/*"		{
			BEGIN MULTY_COMMENT;
		}
<MULTY_COMMENT>. {}
<MULTY_COMMENT>"*/"	{
			BEGIN INITIAL;
		}

%%

int yywrap(void)
{
	return 1;
}
