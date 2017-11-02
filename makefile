parser: grammar.y
	bison -d grammar.y

lexer: parser grammar.lex
	flex -ld grammar.lex

wildebeest: lexer parser
	gcc -o wildebeest.exe -L "C:\GnuWin32\lib" lex.yy.c grammar.tab.c -lfl 
