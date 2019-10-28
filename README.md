## Lex and Yacc Programs

##### For lex
```
    sudo apt install flex
    lex <file>.l
    gcc lex.yy.c
    ./a.out
```

##### For yacc
```
    sudo apt install bison
    cd <dir>/
    lex xyz.l
    yacc -d xyz.l
    gcc lex.yy.c y.tab.c -ll
    ./a.out
```

