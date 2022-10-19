all:
	$(MAKE) grammar
	$(MAKE) flex
	g++ -std=gnu++11 -c compiler/grammar.tab.c compiler/lex.yy.c
	mv *.o compiler/.
	ar rvs compiler/lexgrama.a compiler/grammar.tab.o compiler/lex.yy.o
	g++ -std=gnu++11 -Wextra compiler/main.cpp compiler/lexgrama.a
	mv a.out bin/mezcal

grammar:
	bison -d compiler/grammar.y
	mv grammar.tab.* compiler/.

flex:
	flex compiler/lex.l
	mv lex.yy.c compiler/.

run:
	${MAKE} all
	./bin/mezcal <  test/enter.code > compiled/main.cpp
	g++ compiled/main.cpp -o compiled/main.out
	./compiled/main.out

preview:
	cat compiled/main.cpp

