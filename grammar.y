%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    int yylex(void);
    void yyerror (char const *);
%}

%union {
    int intval;
    float floatval;
    char *stringval;
}

%token <intval> INT
%token <floatval> FLOAT
%token <stringval> STRING
%token PLUS MINUS TIMES DIVIDE
%token LEFT_PAREN RIGHT_PAREN
%token NEWLINE

%left MINUS PLUS
%left TIMES DIVIDE
%left NEG
%right POWER


%type <intval> expr
%type <stringval> identifier

%%
program:
    /* empty */
    | program line
    ;

line:
    /* empty */
    | expr NEWLINE { printf("%d\n", $1); }
    | identifier NEWLINE { printf("%s", $1); }
    | error NEWLINE { yyerrok; }
    ;

identifier:
    STRING
    | identifier STRING { printf("%s", $1); }

expr:
    INT           { $$ = $1; }
    | expr PLUS expr   { $$ = $1 + $3; }
    | expr MINUS expr   { $$ = $1 - $3; }
    | expr TIMES expr   { $$ = $1 * $3; }
    | expr DIVIDE expr   { $$ = $1 / $3; }
    | MINUS expr %prec NEG { $$ = -$2; }
    | expr POWER expr { $$ = pow($1, $3); }
    | LEFT_PAREN expr RIGHT_PAREN { $$ = $2; }
    ;
%%
int main(void){
    yyparse();
}

void yyerror(const char *s){
    printf("There's an error %s", s);
}
