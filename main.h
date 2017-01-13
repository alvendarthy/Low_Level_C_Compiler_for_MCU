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
#define S_NEW_VAR "util.new_var"


#define S_LABEL_BGN(id) (S_LABEL_HEAD + (id) + "_BGN")
#define S_LABEL_END(id) (S_LABEL_HEAD + (id) + "_END")
#define S_LABEL_TRUE_BGN(id) (S_LABEL_HEAD + (id) + "_TRUE_BGN")
#define M_GOTO(lab) "util.goto(\"" + lab + "\")"
#define M_BREAK() "util.break()"
#define M_CONTINUE() "util.continue()"
#define M_LABEL(lab) "util.label(\"" + lab + "\")"
#define M_CODE_AT(addr) "util.code_at(\"" + addr + "\")"
#define M_RAM_AT(addr) "util.ram_at(\"" + addr + "\")"


#define S_LABEL_HEAD "LABEL_"
#define M_LABEL_BGN(id) "util.label(\"" S_LABEL_HEAD + (id) + "_BGN\")"
#define M_LABEL_END(id) "util.label(\"" S_LABEL_HEAD + (id) + "_END\")"
#define M_IF_BGN(id) "util.if_begn(\"" S_LABEL_HEAD + (id) + "_IF_BGN\")"
#define M_IF_END(id) "util.if_end(\"" S_LABEL_HEAD + (id) + "_IF_END\")"
#define M_WHILE_BGN(id) "util.while_begn(\"" S_LABEL_HEAD + (id) + "_WHILE_BGN\")"
#define M_WHILE_END(id) "util.while_end(\"" S_LABEL_HEAD + (id) + "_WHILE_END\")"
#define M_LABEL_LOGICAL_BGN(id) "util.label(\"" S_LABEL_HEAD + (id) + "_LOGICAL_BGN\")"
#define M_LABEL_LOGICAL_END(id) "util.label(\"" S_LABEL_HEAD + (id) + "_LOGICAL_END\")"
#define M_LABEL_TRUE_BGN(id) "util.label(\"" S_LABEL_HEAD + (id) + "_TRUE_BGN\")"
#define M_LABEL_TRUE_END(id) "util.label(\"" S_LABEL_HEAD + (id) + "_TRUE_END\")"
#define M_LABEL_FALSE_BGN(id) "util.label(\"" S_LABEL_HEAD + (id) + "_FALSE_BGN\")"
#define M_LABEL_FALSE_END(id) "util.label(\"" S_LABEL_HEAD + (id) + "_FALSE_END\")"

#define M_LOGICAL_EXP(exp) "util.logical(\"" + (exp) + "\")"

#define S_NEW_FUNC_BGN "util.func_bgn"
#define S_NEW_FUNC_END "util.func_end"
#define M_NEW_INT8(name) (S_NEW_VAR "(\"" S_INT8 "\",\"" + (name) + "\")")
#define M_NEW_FUNC_BGN(name) (S_NEW_FUNC_BGN "(\"" + (name) + "\")")
#define M_NEW_FUNC_END(name) (S_NEW_FUNC_END "(\"" + (name) + "\")")

#define S_MATH "util.math"
#define M_MATH(line) (S_MATH "(\"" + line + "\")")

using namespace std;

typedef list<string> T_str_list;
typedef T_str_list::iterator T_str_list_iter;

struct SToken
{
	string str;
	int    integer;
	T_str_list str_list;
};

#define YYSTYPE SToken

#endif
