%{
    #include <string.h>
    #include "grammar.tab.h"
%}
identifier [a-zA-Z][a-zA-Z0-9_]+
digit [0-9]+
%%

{identifier} { yylval.stringval = strdup(yytext); return STRING; }

{digit} { yylval.intval = atoi(yytext); return INT; }

"(" { return LEFT_PAREN; }
")" { return RIGHT_PAREN; }

"\n" { return NEWLINE; }

"**" { return POWER; }

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return TIMES; }
"/" { return DIVIDE; }

[ \t\r]+  ;

. { return *yytext; }
%%
