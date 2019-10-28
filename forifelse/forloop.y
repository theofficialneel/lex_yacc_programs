%{
    #include<stdio.h>
%}
%token FOR ID BOP UOP NUMBER IF ELSE

%%
prg: 
FOR '(' lexp ';' lexp ';' lexp ')' lbody        {printf("Correct For Loop \n");}
| FOR '(' lexp ';' lexp ';' lexp ')' innerLoop  {printf("Correct Nested-For Loop \n");}
| IF '(' lexp ')' lbody				            {printf("Correct If block \n");}
| IF '(' lexp ')' lbody	ELSE lbody		        {printf("Correct If-Else block \n");}
| IF '(' lexp ')' innerBlock			        {printf("Correct Nested If-Else block \n");}
| IF '(' lexp ')' innerBlock ELSE innerBlock    {printf("Correct Nested If-Else block \n");}
;
innerLoop: lbody
| '{' FOR '(' lexp ';' lexp ';' lexp ')' innerLoop '}'
;
innerBlock: lbody
| '{' IF '(' lexp ')' innerBlock '}'
| '{' IF '(' lexp ')' innerBlock ELSE innerBlock '}'
;
lbody: stmt
| codeblock
;
codeblock:'{' stmt_list '}'
;
stmt_list: stmt_list stmt
|
;
stmt: lexp ';'
;
lexp: fexp
|
;
fexp: fexp ',' exp
| exp
| '(' fexp ')'
;
exp: ID BOP exp
| ID UOP
| UOP ID
| ID
| NUMBER
;
%%