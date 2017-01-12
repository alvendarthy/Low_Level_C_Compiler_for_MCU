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
#define S_NEW_VAR "mcu.new_var"


#define S_LABEL_BGN(id) (S_LABEL_HEAD + (id) + "_BGN")
#define S_LABEL_END(id) (S_LABEL_HEAD + (id) + "_END")
#define S_LABEL_TRUE_BGN(id) (S_LABEL_HEAD + (id) + "_TRUE_BGN")
#define M_GOTO(lab) "mcu.goto(\"" + lab + "\")"
#define M_BREAK() "mcu.break()"
#define M_CONTINUE() "mcu.continue()"
#define M_LABEL(lab) "mcu.label(\"" + lab + "\")"
#define M_CODE_AT(addr) "mcu.code_at(\"" + addr + "\")"
#define M_RAM_AT(addr) "mcu.ram_at(\"" + addr + "\")"


#define S_LABEL_HEAD "LABEL_"
#define M_LABEL_BGN(id) "mcu.label(\"" S_LABEL_HEAD + (id) + "_BGN\")"
#define M_LABEL_END(id) "mcu.label(\"" S_LABEL_HEAD + (id) + "_END\")"
#define M_LABEL_LOGICAL_BGN(id) "mcu.label(\"" S_LABEL_HEAD + (id) + "_LOGICAL_BGN\")"
#define M_LABEL_LOGICAL_END(id) "mcu.label(\"" S_LABEL_HEAD + (id) + "_LOGICAL_END\")"
#define M_LABEL_TRUE_BGN(id) "mcu.label(\"" S_LABEL_HEAD + (id) + "_TRUE_BGN\")"
#define M_LABEL_TRUE_END(id) "mcu.label(\"" S_LABEL_HEAD + (id) + "_TRUE_END\")"
#define M_LABEL_FALSE_BGN(id) "mcu.label(\"" S_LABEL_HEAD + (id) + "_FALSE_BGN\")"
#define M_LABEL_FALSE_END(id) "mcu.label(\"" S_LABEL_HEAD + (id) + "_FALSE_END\")"

#define M_LOGICAL_EXP(exp) "mcu.logical(\"" + (exp) + "\")"

#define S_NEW_FUNC_BGN "mcu.func_bgn"
#define S_NEW_FUNC_END "mcu.func_end"
#define M_NEW_INT8(name) (S_NEW_VAR "(\"" S_INT8 "\",\"" + (name) + "\")")
#define M_NEW_FUNC_BGN(name) (S_NEW_FUNC_BGN "(\"" + (name) + "\")")
#define M_NEW_FUNC_END(name) (S_NEW_FUNC_END "(\"" + (name) + "\")")

#define S_MATH "mcu.math"
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
