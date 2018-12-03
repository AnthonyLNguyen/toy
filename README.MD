# Toy Syntax Analyzer
By Anthony Nguyen and Jarod Nakamoto

# How to use
This program requires the use of four files:  `toy.l`, `toy.y`, a modification for the `y.tab.c` file (to print out shift and reduce actions) , and an input file.
It also requires lex and yacc. 

## Compilation instructions
```bash
lex toy.l
yacc toy.y -dv
perl -i -p0e 's/yybackup:.*goto yyreduce;/`cat changes`/sge' y.tab.c
gcc y.tab.c lex.yy.c -lfl
./a.out < inputfile.txt
```

* Compile `toy.l` using lex. This should create `lex.yy.c`
* Compile `toy.y` using yacc. This should create `y.tab.c`, `y.tab.h`, and `y.output`
* Use perl to modify the `y.tab.c` file with the `changes` file to allow it to print shift and reduce actions
* Then use command `gcc toy.c lex.yy.c -o toy` to output to `toy`
* Run `a.out` while using an input file

Alternatively a file named `compile.sh` has been provided that will automatically create the `a.out` file.

```bash
./compile.sh
./a.out < inputfile.txt
```
