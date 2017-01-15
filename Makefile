LEX=flex
YACC=bison
CC=g++
OBJECT=lexparser
FLAGS= -g

$(OBJECT): lex.yy.o  yacc.tab.o set_lable_id.o
	$(CC) lex.yy.o yacc.tab.o set_lable_id.o -o $(OBJECT)

lex.yy.o: lex.yy.c  yacc.tab.h  main.h
	$(CC) -c lex.yy.c $(FLAGS)

yacc.tab.o: yacc.tab.c  main.h
	$(CC) -c yacc.tab.c $(FLAGS)

set_lable_id.o: set_lable_id.cpp
	$(CC) -c set_lable_id.cpp $(FLAGS)

yacc.tab.c  yacc.tab.h: yacc.y
	$(YACC) -d yacc.y

lex.yy.c: lex.l
	$(LEX) lex.l 


clean:
	@rm -f $(OBJECT)  *.o yacc.tab.c lex.yy.c
