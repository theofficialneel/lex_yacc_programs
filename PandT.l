/**
    Identify, count and print the words that has a ‘p’ and a ‘t’.  
**/

%{
    int pt_count = 0;
%} 
  
%% 
([a-zA-Z])*p([a-zA-Z])*t([a-zA-Z])* { printf("%s\n", yytext); pt_count++; }

([a-zA-Z])*t([a-zA-Z])*p([a-zA-Z])* { printf("%s\n", yytext); pt_count++; }

([a-zA-Z])* {}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main() { 
    printf("Input Statement : ");
    yylex(); 
    printf("\nNumber of words containing p and t : %d\n", pt_count);
    return 0;
}