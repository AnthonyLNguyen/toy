#!/bin/bash
lex toy.l
yacc toy.y -dv
perl -i -p0e 's/yybackup:.*goto yyreduce;/`cat changes`/sge' y.tab.c
gcc y.tab.c lex.yy.c -lfl
