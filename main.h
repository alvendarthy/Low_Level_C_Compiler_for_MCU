#ifndef MAIN_HPP
#define MAIN_HPP

#include <iostream>
#include <string>
#include <stdio.h>
#include <list>

#define PUSH_BACK(targ,src,tmp) \
	tmp = (src); \
	(targ).push_back(tmp)

#define PUSH_BACK_LIST(tar,src)\
	(tar).insert((tar).end(),(src).begin(),(src).end())

#define S_INT8	  "int8"
#define S_BIT	  "bit"
#define S_NEW_VAR "util.code_new_var"


#define S_LABEL_BGN(id) (S_LABEL_HEAD + (id) + "_BGN")
#define S_LABEL_END(id) (S_LABEL_HEAD + (id) + "_END")
#define S_LABEL_TRUE_BGN(id) (S_LABEL_HEAD + (id) + "_TRUE_BGN")
#define M_GOTO(lab) "util.code_goto(" + int2string(yylineno) + ", \"" + lab + "\")"
#define M_BREAK() "util.code_break(" + int2string(yylineno) + ",)"
#define M_CONTINUE() "util.code_continue(" + int2string(yylineno) + ",)"
#define M_LABEL(lab) "util.code_label(" + int2string(yylineno) + ",\"" + lab + "\")"
#define M_CODE_AT(addr) "util.code_code_at(" + int2string(yylineno) + "," + addr + ")"
#define M_RAM_AT(addr) "util.code_ram_at(" + int2string(yylineno) + "," + addr + ")"


#define S_LABEL_HEAD "LABEL_"
#define M_LABEL_BGN(id) "util.code_label(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_BGN\")"
#define M_LABEL_END(id) "util.code_label(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_END\")"
#define M_IF_BGN(id) "util.code_if_bgn(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_IF_BGN\")"
#define M_IF_END(id) "util.code_if_end(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_IF_END\")"
#define M_WHILE_BGN(id) "util.code_while_bgn(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_WHILE_BGN\")"
#define M_WHILE_END(id) "util.code_while_end(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_WHILE_END\")"
#define M_LABEL_LOGICAL_BGN(id) "util.code_label(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_LOGICAL_BGN\")"
#define M_LABEL_LOGICAL_END(id) "util.code_label(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_LOGICAL_END\")"
#define M_LABEL_TRUE_BGN(id) "util.code_label(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_TRUE_BGN\")"
#define M_LABEL_TRUE_END(id) "util.code_label(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_TRUE_END\")"
#define M_LABEL_FALSE_BGN(id) "util.code_label(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_FALSE_BGN\")"
#define M_LABEL_FALSE_END(id) "util.code_label(" + int2string(yylineno) + ",\"" S_LABEL_HEAD + (id) + "_FALSE_END\")"
#define M_ASM_CODE(code) "util.code_asm_code(" + int2string(yylineno) + ",\"" + code + "\")"

#define M_LOGICAL_EXP(exp) "util.code_logical(" + int2string(yylineno) + ",\"" + (exp) + "\")"

#define S_NEW_FUNC_BGN "util.code_func_bgn"
#define S_NEW_FUNC_END "util.code_func_end"
#define M_NEW_INT8(name) (S_NEW_VAR "(" + int2string(yylineno) + ",\"" S_INT8 "\",\"" + (name) + "\")")
#define M_NEW_BIT(name,src) (S_NEW_VAR "(" + int2string(yylineno) + ",\"" S_BIT "\",\"" + (name) + "\", \"" + src+ "\")")
#define M_NEW_FUNC_BGN(name) (S_NEW_FUNC_BGN "(" + int2string(yylineno) + ",\"" + (name) + "\")")
#define M_NEW_FUNC_END(name) (S_NEW_FUNC_END "(" + int2string(yylineno) + ",\"" + (name) + "\")")

#define S_MATH "util.code_math"
#define M_MATH(line) (S_MATH "(" + int2string(yylineno) + ",\"" + line + "\")")

using namespace std;

typedef list<string> T_str_list;
typedef T_str_list::iterator T_str_list_iter;

struct SToken
{
	string str;
	T_str_list str_list;
};

#define YYSTYPE SToken

#endif
