#include "set_lable_id.h"
#include <sstream>

using namespace std;

// global vars
T_code_list def_list;
T_code_list normal_codes;

T_code_list set_lt(T_code code, T_code logic, int id);
T_code_list set_lt(T_code code, T_code logic, string id);


T_code_list set_ge(T_code code, T_code logic, int id);
T_code_list set_ge(T_code code, T_code logic, string id);


T_code_list set_ec(T_code code, T_code logic, int id);
T_code_list set_ec(T_code code, T_code logic, string id);

T_code_list set_ne(T_code code, T_code logic, int id);
T_code_list set_ne(T_code code, T_code logic, string id);

int bin2int(char * str, int len)
{
	if(len > 2 && str[0] == '0' && (str[1] == 'b' || str[1] == 'B')){
		str += 2;
		len -= 2;
	}

	int j = 0;
	int i = 0;
	int out = 0;
	for(i = len - 1, j = 0; i >= 0; i --, j ++){
		if(str[i] == '1'){
			out |= (1 << j);
		}
	}

	return out;
}


int hex2int(char *str, int len)
{
	stringstream ss;
	ss << std::hex << str;
	int  out;
	ss >> out;
	return out;

}

int set_lable_id(T_code_list & codes, string lable_type, int id)
{
	string id_str = int2string(id);

	for(T_code_list::iterator iter = codes.begin(); iter != codes.end(); iter ++){
		if(iter->op == cLOGIC && iter->arg2.name == lable_type){
			iter->arg1.name += id_str;
			iter->arg2.name = "determinded" ;
		}
	}
	return 1;
}

string int2string(int v)
{
	string ret = "";
	char tmp[1024] = {};

	sprintf(tmp, "%d", v);
	ret = tmp;

	return ret;
}

T_code_list  set_logic(T_code_list & codes, int id)
{
	T_code_list out_codes;
	T_code_list t_codes;

	for(T_code_list::iterator iter = codes.begin(); iter != codes.end(); iter ++)
	{
		
		if(iter->op != cCMP)
		{
			continue;
		}

		T_code code, logic;
		iter ++;
		if(iter  == codes.end())
		{
			logic.op = cLOGIC;
			logic.arg1.type = cAND;
		} else {
			logic = *iter;
		}
		iter --;

		switch(iter->arg2.type)
		{
			case cLT:
				code = *iter;
				t_codes =  set_lt(code, logic, id);
				out_codes.insert(out_codes.end(), t_codes.begin(), t_codes.end());
				break;
			case cGT:
				code = *iter;
				code.arg1 = iter->arg3;
				code.arg2.type = cLT;
				code.arg3 = iter->arg1;
				t_codes =  set_lt(code, logic, id);
				out_codes.insert(out_codes.end(), t_codes.begin(), t_codes.end());
			case cGE:
				code = *iter;
                                t_codes =  set_ge(code, logic, id);
                                out_codes.insert(out_codes.end(), t_codes.begin(), t_codes.end());
				break;
			case cLE:
				code = *iter;
                                code.arg1 = iter->arg3;
                                code.arg2.type = cLE;
                                code.arg3 = iter->arg1;
                                t_codes =  set_ge(code, logic, id);
                                out_codes.insert(out_codes.end(), t_codes.begin(), t_codes.end());
			case cEC:
				code = *iter;
                                t_codes =  set_ec(code, logic, id);
                                out_codes.insert(out_codes.end(), t_codes.begin(), t_codes.end());
				break;
			case cNE:
				code = *iter;
                                t_codes =  set_ne(code, logic, id);
                                out_codes.insert(out_codes.end(), t_codes.begin(), t_codes.end());
				break;

			default:
				break;
		}
	}
	return out_codes;
}


T_code_list set_lt(T_code code, T_code logic, string id)
{
	T_code_list out;
	if(code.op != cCMP && code.arg2.type != cLT){
		cerr << "not lt cmp statement." << endl;
		return out;
	}

	if(logic.op != cLOGIC || logic.arg1.type != cAND && logic.arg1.type != cOR){
		cerr << "not and/or statement." << endl;
		return out;
	}

	T_code n_code;
	n_code.op = lSUB;
	n_code.arg1 = code.arg1;
	n_code.arg2 = code.arg3;

	out.push_back(n_code);

	switch(logic.arg1.type){
		case cAND:
			n_code.op = lJZ;
			n_code.arg1.type = cNAME;
			n_code.arg1.name = "BR";
			n_code.arg2.type = cNAME;
			n_code.arg2.name = "LABEL_FLASE_ACT_" + id;
			break;
		case cOR:
			n_code.op = lJNZ;
			n_code.arg1.type = cNAME;
			n_code.arg1.name = "BR";
			n_code.arg2.type = cNAME;
			n_code.arg2.name = "LABEL_TRUE_ACT_" + id;
			break;
		default:
			break;
	}

	out.push_back(n_code);
	
	return out;
}


T_code_list set_lt(T_code code, T_code logic, int id)
{
	return set_lt(code, logic,int2string(id));
}

T_code_list set_ge(T_code code, T_code logic, string id)
{
	T_code_list out;
	if(code.op != cCMP && code.arg2.type != cLT){
		cerr << "not lt cmp statement." << endl;
		return out;
	}

	if(logic.op != cLOGIC || logic.arg1.type != cAND && logic.arg1.type != cOR){
		cerr << "not and/or statement." << endl;
		return out;
	}

	T_code n_code;
	n_code.op = lSUB;
	n_code.arg1 = code.arg1;
	n_code.arg2 = code.arg3;

	out.push_back(n_code);

	switch(logic.arg1.type){
		case cAND:
			n_code.op = lJNZ;
			n_code.arg1.type = cNAME;
			n_code.arg1.name = "BR";
			n_code.arg2.type = cNAME;
			n_code.arg2.name = "LABEL_FLASE_ACT_" + id;
			break;
		case cOR:
			n_code.op = lJZ;
			n_code.arg1.type = cNAME;
			n_code.arg1.name = "BR";
			n_code.arg2.type = cNAME;
			n_code.arg2.name = "LABEL_TRUE_ACT_" + id;
			break;
		default:
			break;
	}

	out.push_back(n_code);
	
	return out;
}

T_code_list set_ge(T_code code, T_code logic, int id)
{
	return set_ge(code, logic,int2string(id));
}

T_code_list set_ec(T_code code, T_code logic, string id)
{
	T_code_list out;
	if(code.op != cCMP && code.arg2.type != cLT){
		cerr << "not lt cmp statement." << endl;
		return out;
	}

	if(logic.op != cLOGIC || logic.arg1.type != cAND && logic.arg1.type != cOR){
		cerr << "not and/or statement." << endl;
		return out;
	}

	T_code n_code;
	n_code.op = lSUB;
	n_code.arg1 = code.arg1;
	n_code.arg2 = code.arg3;

	out.push_back(n_code);

	switch(logic.arg1.type){
		case cAND:
			n_code.op = lJZ;
			n_code.arg1.type = cNAME;
			n_code.arg1.name = "Z";
			n_code.arg2.type = cNAME;
			n_code.arg2.name = "LABEL_FLASE_ACT_" + id;
			break;
		case cOR:
			n_code.op = lJNZ;
			n_code.arg1.type = cNAME;
			n_code.arg1.name = "Z";
			n_code.arg2.type = cNAME;
			n_code.arg2.name = "LABEL_TRUE_ACT_" + id;
			break;
		default:
			break;
	}

	out.push_back(n_code);
	
	return out;
}

T_code_list set_ec(T_code code, T_code logic, int id)
{
	return set_ec(code, logic,int2string(id));
}



T_code_list set_ne(T_code code, T_code logic, string id)
{
	T_code_list out;
	if(code.op != cCMP && code.arg2.type != cLT){
		cerr << "not lt cmp statement." << endl;
		return out;
	}

	if(logic.op != cLOGIC || logic.arg1.type != cAND && logic.arg1.type != cOR){
		cerr << "not and/or statement." << endl;
		return out;
	}

	T_code n_code;
	n_code.op = lSUB;
	n_code.arg1 = code.arg1;
	n_code.arg2 = code.arg3;

	out.push_back(n_code);

	switch(logic.arg1.type){
		case cAND:
			n_code.op = lJNZ;
			n_code.arg1.type = cNAME;
			n_code.arg1.name = "Z";
			n_code.arg2.type = cNAME;
			n_code.arg2.name = "LABEL_FLASE_ACT_" + id;
			break;
		case cOR:
			n_code.op = lJZ;
			n_code.arg1.type = cNAME;
			n_code.arg1.name = "Z";
			n_code.arg2.type = cNAME;
			n_code.arg2.name = "LABEL_TRUE_ACT_" + id;
			break;
		default:
			break;
	}

	out.push_back(n_code);
	
	return out;
}

T_code_list set_ne(T_code code, T_code logic, int id)
{
	return set_ne(code, logic,int2string(id));
}

