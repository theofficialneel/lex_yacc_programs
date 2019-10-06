/**
    Identify and print the words that begins with a vowel. 
**/

%{
%} 
  
%% 
[aeiouAEIOU]([a-zA-Z])* { printf("%s\n", yytext); }

([a-zA-Z])* {}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main() { 
    printf("Input Statement : ");
    yylex(); 
    return 0;
}