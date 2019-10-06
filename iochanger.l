/**
    Write a LEX program that takes an input ‘C’ file;
    replaces the C input/output statements printf, scanf with C++ I/O statements (cout, cin).
**/

%{ 
    #include <bits/stdc++.h>
    using namespace std;

    bool pBool = false;
    bool sBool = false;
    bool strBool = false;

    vector<string> args;
    string formatString;
    string currentArg;

    int getArgumentEndIndex(int index) {
        index++;
        while(index != formatString.length() && formatString[index] != ' ' && formatString[index] != '%') {
            index++;
        }
        return index;
    }

    pair<string, int> getNonFormatStringEndIndex(int index) {
        string currentString;
        while(index != formatString.length() && formatString[index] != '%') {
            currentString += formatString[index];
            index++;
        }
        return make_pair(currentString, index);
    }

    void cleanArgs() {
        vector<string> targs;
        for (auto it : args) {
            int index = 0;
            while (it[index] == ' ' && index != it.length()) {
                index++;
            }
            if (index != it.length()) {
                targs.push_back(it.substr(index, it.length() - index));
            }
        }
        args = targs;
    }

    void printCout() {
        cleanArgs();
        int argCount = args.size();
        int currentArg = 0;
        int currIndex = 0;
        if (argCount != 0 || formatString.length() != 0) cout << "cout ";
        while(currIndex < formatString.length()) {
            if (formatString[currIndex] == '%') {
                cout << " << " << args[currentArg];
                currIndex = getArgumentEndIndex(currIndex);
                currentArg++;
            } else {
                auto psi = getNonFormatStringEndIndex(currIndex);
                cout << " << \"" << psi.first << "\"";
                currIndex = psi.second;
            }
        }
    }

    void printCin() {
        cleanArgs();
        int argCount = args.size();
        int currentArg = 0;
        int currIndex = 0;
        if (argCount != 0 || formatString.length() != 0) cout << "cin";
        while(currIndex < formatString.length()) {
            if (args[currentArg][0] == '&') {
                args[currentArg] = args[currentArg].substr(1,args[currentArg].length() - 1);
            } else {
                args[currentArg] = '*' + args[currentArg];
            }
            cout << " >> " << args[currentArg];
            currIndex++;
            while (formatString[currIndex] != '%' && currIndex != formatString.length()) {
                currIndex++;
            }
            currentArg++;
        }
    }
%} 
  
%% 
printf[(\"] { 
    if (!strBool) {
        pBool = true;
    } else {
        formatString += yytext;
    }
}

scanf[(\"] {
    if (!strBool) {
        sBool = true;
    } else {
        formatString += yytext;
    }
}

\\\" {
    if ((pBool || sBool) && strBool) formatString += "\\\"";
    else cout << yytext;
}

\" {
    if (pBool || sBool) strBool = !strBool;
}

[)] {
    if (pBool || sBool) {
        if (strBool) {
            formatString += ")";
        } else {
            if (currentArg != "") {
                args.push_back(currentArg);
                currentArg = "";
            }
            if (pBool) printCout();
            else if (sBool) printCin();
            args.clear();
            formatString = "";
            if (pBool) pBool = false;
            if (sBool) sBool = false;
        }
    } else {
        cout << yytext;
    }
 }

, {
    if (pBool || sBool) {
        if (strBool) formatString += yytext;
        else if (currentArg != "") {
            args.push_back(currentArg);
            currentArg = "";
        }
    } else {
        cout << yytext;
    }
}

\n {
    cout << endl;
}

. { 
    if (strBool) {
        formatString += yytext;
    } else if (pBool || sBool) {
        currentArg += yytext;
    } else {
        cout << yytext;
    }
 }

%% 

int yywrap(){}

int main(){ 
    extern FILE *yyin;
    yyin = fopen("input.cpp", "r"); 
    freopen("output.cpp", "w", stdout);
    yylex();
    return 0;
}