user-sh: execute.c global.h bison.y flex.l
	flex -o lex.yy.c flex.l
	bison bison.y -d
	cc -c execute.c
	cc -o user-sh bison.tab.c lex.yy.c execute.o -lfl
	# for Mac OS X, use ``cc -o user-sh bison.tab.c lex.yy.c execute.o -ll" instead.
clean:
	rm user-sh execute.o lex.yy.c bison.tab.c bison.tab.h

