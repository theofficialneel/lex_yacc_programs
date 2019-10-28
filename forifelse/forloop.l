%{
    #include<stdio.h>
    #include "y.tab.h"
    #include<math.h>
%}

num	[0-9]+
id	[a-zA-Z]+
bop	=|<|>|!=|<=|>=|==|&&|"||"|[+-/*]
uop	"++"|"--"

%%
"for"	{return FOR;}
"if"	{return IF;}
"else"	{return ELSE;}
{bop}	{return BOP;}
{uop}	{return UOP;}
{num}	{return NUMBER;}
{id}	{return ID;}
[ \n\t]	; /*reject whitespaces*/
.	{return *yytext;}
%%

int yywrap(){return 1;}

void yyerror(char *s) {
    printf("Error, loop-or-block syntax wrong \n");
}

int main() {
    yyin=fopen("ifelse.txt","r");
    yyparse();
    return(0);
}