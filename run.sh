#!/bin/bash
lex toy.l
gcc toy.c lex.yy.c -o toy
./toy < $1 > OUT

