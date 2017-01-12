#include "set_lable_id.h"
#include <sstream>

using namespace std;

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

string int2string(int v)
{
	string ret = "";
	char tmp[1024] = {};

	sprintf(tmp, "%d", v);
	ret = tmp;

	return ret;
}


