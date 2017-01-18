@ram 0x08

int8 a, b, c;
bit C = a_b1;

@asm{
	A EQ 1
}


@code 0x00
@function afunc(){
	while(a != b){
		c = a + b;
		c = a - b;
		c = a + 1;
		c = 1 + a;
		c = 1 -a ;
		c = a -1;
		c = 10;
		c = 0;
		c ++;
		c --;
		c = a;
	}

	if(a < b || a <= b || a > c || a >= c){
		return;
	}

	if(C == 1 || C != 1|| 0 == C || 12 != C){
		return;
	}

	return;
}


afunc();

@asm{
	this is a asm code;
}
