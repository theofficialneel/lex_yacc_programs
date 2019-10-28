%{
    #include<stdio.h>
%}

%token DEFINE SPACE ID BOP NUMBER

%%
prg: 
DEFINE SPACE ID SPACE fexp   {printf("Correct Macro definition \n");}
;

fexp:
exp
|'(' fexp ')'
| fexp BOP '(' fexp ')'
|'(' fexp ')' BOP fexp
;

exp: ID BOP exp
| NUMBER BOP exp
| ID
| NUMBER
;
%%