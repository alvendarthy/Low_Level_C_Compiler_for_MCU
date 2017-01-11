#ifndef MAIN_HPP
#define MAIN_HPP

#include <iostream>
#include <string>
#include <stdio.h>
#include <list>

using namespace std;

enum E_code_type{
	cRAM_AT,
	cCODE_AT,
	cREAL_CODE,
	cBIT,
	cINT8,
	cNAME,
	cCMD,
	cASN,
	cMULT,
	cDEV,
	cADD,
	cSUB,
	cBIT_AND,
	cBIT_OR,
	cBIT_XOR,
	cBIT_NOT,
	cDEF,
	cCMP,
	cEC,
	cNE,
	cGT,
	cGE,
	cLT,
	cLE,
	cLOGIC,
	cAND,
	cOR,
	cSHL,
	cRSHL,
	cSHR,
	cRSHR,
	cINCR,
	cDECR,
	cIF_LOGIC_START,
	cIF_TRUE_ACT,
	cELSE,
	cELSIF,
	cELSIF_LOGIC_START,
	cIF_FAULSE_ACT,
	cIF_END,
	cBREAK,
	cCONTINUE,
	cGOTO,
	cRETURN,
	cLABEL,
	cWHILE_LOGIC_START,
	cWHILE_ACT,
	cWHILE_END,
	cFUN_START,
	cFUN_END,
	cASM_START,
	cASM_END,
	cASM_CODE,
	lCODE,
	lSUB,
	lJZ,
	lJNZ
};

struct T_arg{
	string name;
	int	value;
	E_code_type type;
};

struct T_code {
	int   op;
	T_arg arg1;
	T_arg arg2;
	T_arg arg3;
};

struct Type
{
	string m_sId;
	int m_nInt;
	char m_cOp;
};


typedef list<T_code> T_code_list;

struct T_id
{
	string m_name;
	int    type;
};

typedef list<string> T_id_list;


struct T_token
{
	string name;
	int    value;
	T_id_list id_list;
	T_code    code;
	T_code_list code_list;
};

#define YYSTYPE T_token

#endif
