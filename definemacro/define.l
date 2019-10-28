%{
    #include<stdio.h>
    #include "y.tab.h"
    #include<math.h>
%}

num	[0-9]+
id	[a-zA-Z]+
bop	=|<|>|!=|<=|>=|==|&&|"||"|[+-/*]

%%
"#define"	{return DEFINE;}
{bop}	    {return BOP;}
{num}	    {return NUMBER;}
{id}	    {return ID;}
[ \n\t]	    {return SPACE;} /*reject whitespaces*/
.	{return *yytext;}
%%

int yywrap(){return 1;}

void yyerror(char *s) {
    printf("Error, macro syntax wrong \n");
}

int main() {
    yyin=fopen("define.txt","r");
    yyparse();
    return(0);
}