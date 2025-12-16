%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int num;
    char *id;
}

%token MIAU PRRR MIENTRAS HACER FIUU SI SINO PRINT
%token <num> NUM
%token <id> ID
%token GT LT GE LE EQ NE

%%
program:
    MIAU ID NUM
        { printf("✔ Parser funcionando\n"); }
;
%%

void yyerror(const char *s) {
    printf("✘ Error sintactico\n");
}

int main(void) {
    return yyparse();
}
