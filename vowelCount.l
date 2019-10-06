/**
    Count and print the number of vowels.  
**/

%{
    int count = 0;
%} 
  
%% 
([aeiouAEIOU]) { 
    printf("%s\n", yytext);
    count++;
}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main() { 
    printf("Input Statement : ");
    yylex(); 
    printf("\nNumber of vowels : %d\n", count);
    return 0;
}