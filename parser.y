%{
#include <stdio.h>
#include <stdlib.h>
#include "symtable.c"

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
    MIAU ID '=' NUM '.'
    {
        set_symbol($2, $4);
        printf("✔ Variable %s asignada con valor %d\n", $2, $4);
    }
;
