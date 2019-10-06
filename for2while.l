/**
    Write a LEX program that converts a ‘for’ construct in C to a ‘while’ construct. 
**/

%{ 
    #include <bits/stdc++.h>
    using namespace std;

    vector<string> segments;
    string currentSegmentString;

    bool strBool = false;
    bool fBool = false;

    int currentBrace = 0;

    stack<pair<string,int>> increments;

    void cleanSegments() {
        vector<string> tSegments;
        for (auto it : segments) {
            int index = 0;
            while (it[index] == ' ' && index != it.length()) {
                index++;
            }
            if (index != it.length()) {
                tSegments.push_back(it.substr(index, it.length() - index));
            }
        }
        segments = tSegments;
    }

    void printInitialization() {
        cout << segments[0] << ";\n";
    }

    void printWhileCondition() {
        for (int i = 0; i < currentBrace; i++) cout << "    ";
        cout << "while (" << segments[1] << ") ";
    }

    void printTopIncrement() {
        if (increments.size()) {
            pair<string, int> increment = increments.top();
            if (increment.second == currentBrace) {
                increments.pop();
                cout << "    " << increment.first << ";\n";
                for (int i = 0; i < currentBrace; i++) cout << "    ";
            }
        }
    }

    void pushIncrementer() {
        increments.push(make_pair(segments[2], currentBrace));
    }
%} 
  
%% 
for[' ']*[(] {
    if (!strBool) {
        fBool = true;
    } else if (fBool) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

\'[.]\' {
    if (fBool) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

\\\" {
    if (fBool) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

\" {
    strBool = !strBool;
    if (fBool) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

; {
    if (fBool) {
        if (strBool) currentSegmentString += yytext;
        else {
            segments.push_back(currentSegmentString);
            currentSegmentString = "";
        }
    } else {
        cout << yytext;
    }
}

[)] {
    if (fBool) {
        if (strBool) currentSegmentString += yytext;
        else {
            segments.push_back(currentSegmentString);
            currentSegmentString = "";
            fBool = false;
            cleanSegments();
            printInitialization();
            printWhileCondition();
            pushIncrementer();
            segments.clear();
        }
    } else {
        cout << yytext;
    }
}
[{] {
    currentBrace++;
    cout << yytext;
}

[}] {
    currentBrace--;
    printTopIncrement();
    cout << yytext;
}

. {
    if (fBool) {
        currentSegmentString += yytext;
    } else {
        cout << yytext;
    }
}

%% 

int yywrap(){}

int main(){ 
    extern FILE *yyin;
    yyin = fopen("input_for.c", "r"); 
    freopen("output_for.c", "w", stdout);
    yylex();
    return 0;
}