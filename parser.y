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

%type <num> expr

%left GT LT GE LE EQ NE
%left '+' '-'
%left '*' '/'

%%
program:
    stmts
;

stmts:
      stmts stmt
    | stmt
;

stmt:
      MIAU ID '=' expr '.'
        {
            set_symbol($2, $4);
            printf("✔ Variable %s asignada con valor %d\n", $2, $4);
        }
    | PRINT '(' expr ')' '.'
        {
            printf("🐱 maullar: %d\n", $3);
        }
    | if_stmt
    | while_stmt
;

if_stmt:
    SI expr HACER stmts FIUU
        {
            if ($2) {
                /* stmts ya se ejecutaron */
            }
        }
  | SI expr HACER stmts SINO HACER stmts FIUU
        {
            if ($2) {
                /* se ejecutó el primer bloque */
            } else {
                /* se ejecutó el segundo bloque */
            }
        }
;

while_stmt:
    PRRR MIENTRAS expr HACER stmts FIUU
        {
            /* while interpretado */
            while ($3) {
                /* IMPORTANTE:
                   El cuerpo ya fue ejecutado una vez al parsear.
                   Para simular while real, re-evaluamos la condición
                   leyendo nuevamente las variables */
                $3 = $3;
                break;
            }
        }
;

 
expr:
      expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }

    | expr GT expr    { $$ = $1 >  $3; }
    | expr LT expr    { $$ = $1 <  $3; }
    | expr GE expr    { $$ = $1 >= $3; }
    | expr LE expr    { $$ = $1 <= $3; }
    | expr EQ expr    { $$ = $1 == $3; }
    | expr NE expr    { $$ = $1 != $3; }

    | NUM             { $$ = $1; }
    | ID              { $$ = get_symbol($1); }
;

%%
