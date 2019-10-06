/**
    Identify, count and print words that has at least 2 vowels.   
**/

%{
    int count = 0;
%} 
  
%% 
([a-zA-Z])*[aeiouAEIOU]([a-zA-Z])*[aeiouAEIOU]([a-zA-Z])* { 
    printf("%s\n", yytext);
    count++;
}

([a-zA-Z])* {}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main() { 
    printf("Input Statement : ");
    yylex(); 
    printf("\nNumber of words 2 vowels : %d\n", count);
    return 0;
}