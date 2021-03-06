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
%option yylineno

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
<ASM_READY>[ \f\r\t\v\n] {}

<ASM>[^}\n]* {
		yylval.str = yytext;
                return ASM_CODE;
        }

<ASM>[\n\r] {}

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

"while" {
                return WHILE;
        }

"do" {
		return DO;
}

"break" {
                return BREAK;
        }

"+=" {
		return ADD_SELF;
	}

"-=" {
		return SUB_SELF;
	}
">>" {
		return RR;
}

">>>" {
		return RRC;
}

"<<" {
		return RL;
}

"<<<" {
		return RLC;
}

"continue" {
                return CONTINUE;
        }

"goto" {
		return GOTO;
	}

"cleardog" {
		return CLRWDT;
	}
"nop" {
		return NOP;
	}

(\+\+)|(\-\-) {
		yylval.str=yytext;
		return SELF_CALC;
	}


(\+)|(\-)|(\*)|(\\)|(<<)|(<<<)|(>>)|(>>>)|(\&)|(\|)|(\^)|(\~) {
		yylval.str=yytext;
                return CALC_CHAR;
	}

(>)|(>=)|(<)|(<=)|(==)|(!=)	{
		yylval.str=yytext;
                return CMP;
	}

(&&)|(\|\|)	{
		yylval.str=yytext;
		return LOGICAL_CHAR;
	}

{identifier}	{
			yylval.str=yytext;
			return IDENTIFIER;
		}

{integer}	{
			yylval.str=yytext;
			return INTEGER;
		}

{bin}		{
			yylval.str=int2string(bin2int(yytext, strlen(yytext)));
                        return INTEGER;
		}

{hex}		{
			yylval.str=int2string(hex2int(yytext, strlen(yytext)));
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
<MULTY_COMMENT>\n {}
<MULTY_COMMENT>"*/"	{
			BEGIN INITIAL;
		}

%%

int yywrap(void)
{
	return 1;
}
