# Toy Lexical Analyzer
By Anthony Nguyen, Jarod Nakamoto, Jeffrey Nguyen

# How to use
This program requires the use of four files: `toy.h`, `toy.l`, `toy.c`, and an input file.
It also requires 

## Compilation instructions
```bash
$ lex toy.l
$ gcc toy.c lex.yy.c -o toy
$ ./toy < inputfile
```

* Compile `toy.l` using lex. This should create `lex.yy.c`
* Then use command `gcc toy.c lex.yy.c -o toy` to output to `toy`
* Run `toy` using an inputfile
