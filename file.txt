@code 0x08

goto START;

@ram 0x08
int8 a, b, c;
bit A1 = a_b1;

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
