user-sh: execute.c global.h bison.y flex.l
	flex -o lex.yy.c flex.l
	bison bison.y -d
	cc -c execute.c
	cc -o user-sh bison.tab.c lex.yy.c execute.o -ll
clean:
	rm user-sh execute.o lex.yy.c bison.tab.o execute.o bison.tab.c bison.tab.h

# user-sh : bison.tab.o execute.o
# 	cc -o user-sh bison.tab.o execute.o
# bison.tab.o : bison.tab.c global.h
# 	cc -c bison.tab.c
# execute.o : execute.c global.h
# 	cc -c execute.c
# bison.tab.c:
# 	bison bison.y
# clean :
# 	rm user-sh bison.tab.o execute.o bison.tab.c