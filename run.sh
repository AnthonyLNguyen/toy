#!/bin/bash
for i in `seq 1 15`;
do
    printf "\n\nCASE $i\n"
    cat ./cases/case$i
    ./a.out < ./cases/case$i
done
