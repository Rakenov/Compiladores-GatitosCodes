%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

"miau"          return MIAU;
"prrr"          return PRRR;
"mientras"      return MIENTRAS;
"hacer"         return HACER;
"fiuu"          return FIUU;
"si"            return SI;
"sino"          return SINO;
"maullar"       return PRINT;

[0-9]+          { yylval.num = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.id = strdup(yytext); return ID; }

"==" return EQ;
"!=" return NE;
">=" return GE;
"<=" return LE;
">"  return GT;
"<"  return LT;

"+"|"-"|"*"|"/"|"="|"("|")"|";"|","|"." return yytext[0];

"#".*           ;
[ \t\n]+        ;

.               { printf("Caracter invalido: %s\n", yytext); }

%%

int yywrap() { return 1; }
