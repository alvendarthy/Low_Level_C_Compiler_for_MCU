#ifndef SET_LABLE_ID_H
#define SET_LABLE_ID_H

#include "main.h"
#include <string>

extern T_code_list def_list;
extern T_code_list normal_codes;

int bin2int(char * str, int len);
int hex2int(char * str, int len);

T_code_list set_logic(T_code_list & codes, int id);
int set_lable_id(T_code_list & codes, string lable_type, int id);
string int2string(int v);

T_code_list set_lt(T_code code, T_code logic, int id);
T_code_list set_lt(T_code code, T_code logic, string id);


T_code_list set_ge(T_code code, T_code logic, int id);
T_code_list set_ge(T_code code, T_code logic, string id);

#endif
