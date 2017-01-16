#define CALL(name) name()

@code 0x16
int8 a,b,c,d,e,f,g;
bit C = a_b2;


@code 0x08

goto START;

bit A1 = a_b1;

if(C == 1){
	C = 0;
}

if( A1 > 1)
	a = A1 + c;

@code 0x20
START:
while(1) @asm{
move a, b;
move a, w;
continue
}

while(1){
	if(a > 0){
		break;
		continue;
	}
}

{
	a = a  + 1;
}

@function afunc(){
	return;
}

afunc();
CALL(afunc);
