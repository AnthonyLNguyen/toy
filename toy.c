#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "toy.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

char *tokens[] = {NULL, "boolean", "break", "class", "double", "else", "extends", "for", "if", "implements", "int", "interface", "new", "newarray", "null", "println", "readln", "return", "string", "void", "while", "plus", "minus", "multiplication", "division", "mod", "less", "lessequal", "greater", "greaterequal", "equal", "notequal", "and", "or", "not", "assignop", "semicolon", "comma", "period", "leftparen", "rightparen", "leftbracket", "rightbracket", "leftbrace", "rightbrace", "intconstant", "doubleconstant", "stringconstant", "booleanconstant", "id" };

// adds string to trie structure
int add_to_trie (char*, int*, char*, int*, int*);

// gets next char of the string
char getNextSymbol(char*,int*);

// add new string to trie structure
int create(char,int*, char*, char*, int*, int*);

// return switch position of character
int symPos(char);

// function to print out trie table
int printTrie(int* switchArr, char* symbolArr, int* nextArr, int* cur);

int main(void)
{
	int CHARS = 52;
	int MAXTRANSITION = 4096;
	int cur;
	cur = 0;
	int switchArr[CHARS]; 
	char symbolArr[MAXTRANSITION];
	int nextArr[MAXTRANSITION];
	int ntoken;

	for(int i = 0; i < CHARS ; i++ ){
		switchArr[i] = -1;
	}

	ntoken = yylex();
	while(ntoken) {
		printf("%s ",tokens[ntoken]);
		char input[strlen(yytext)]; 
		strcpy(input,yytext);
		if (ntoken == _id || ntoken <= _while || ntoken == _booleanconstant){
			add_to_trie(input, switchArr, symbolArr, nextArr, &cur);
		}
		ntoken = yylex();

	}
	printTrie(switchArr,symbolArr,nextArr,&cur);
	return 0;
}

int symPos(char x){
	if ( x >= 65 && x <= 90 )
	       	return x-65;
	else 
		return x-97+26;
}

char getNextSymbol(char* input, int* pos){
	int old = *pos;
	*pos = *pos + 1;
	return input[old];
}

int create(char valueOfSymbol, int* switchArr, char* symbolArr, char* input, int* pos, int* cur ){
	int exit = 0;
	int size = strlen(input);
	char nextSym;
	while( !exit ){
		if(size > 1){
		nextSym = getNextSymbol(input,pos);
		symbolArr[*cur] = nextSym;
		*cur = *cur + 1;
		}
		if (*pos >= size){
			symbolArr[*cur] = '*';
			*cur = *cur + 1;
			exit = 1;
		}
	}
	return 0;
}

int add_to_trie(char* input, int* switchArr, char* symbolArr, int* nextArr, int* cur){
	char endMarker = '*';
	int pos;
	pos = 0;
	
	char valueOfSymbol = getNextSymbol(input,&pos);
	valueOfSymbol = input[0];
	int ptr = switchArr[symPos(valueOfSymbol)];
	if (ptr == -1){
		switchArr[symPos(valueOfSymbol)] = *cur;
		create(valueOfSymbol, switchArr, symbolArr, input, &pos, cur);
	}
	else
	{
		if ( strlen(input) == 1)
			return 0;
		valueOfSymbol = getNextSymbol(input,&pos);
		int exit = 0;
		while ( !exit )
		{
			if (symbolArr[ptr] == valueOfSymbol)
				if(valueOfSymbol != endMarker)
				{
					ptr = ptr + 1;
					valueOfSymbol = getNextSymbol(input,&pos);
					if( pos == strlen(input) )
					{
						if ( symbolArr[ptr+1] == endMarker){
							exit = 1;
							break;
						}
						int loop = 1;
						while ( loop ){
						if (nextArr[ptr] == 0){
							if ( symbolArr[ptr] == valueOfSymbol ) 
								nextArr[ptr+1] = *cur;
							else
								nextArr[ptr] = *cur;
							loop = 0;
						}
						else
							ptr = nextArr[ptr];
						}
						if ( symbolArr[ptr] != valueOfSymbol ) {
						symbolArr[*cur] = valueOfSymbol;
						*cur = *cur + 1;
						}
						symbolArr[*cur] = '*';
						*cur = *cur + 1;
						exit = 1;
					}
				}
				else
					exit = 1;
			else if (nextArr[ptr] > 0)
				ptr = nextArr[ptr];
			else
			{
				nextArr[ptr] = *cur;
				pos--;
				create(valueOfSymbol, switchArr, symbolArr, input, &pos, cur);
				exit = 1;
			}
		} //while
	} //if

	return 0;
}

int printTrie(int* switchArr, char* symbolArr, int* nextArr, int* cur){
	int space = 4;
	printf("\n\t");
	for( int i = 'A'; i <= 'T'; i++ ){
		printf("%*c",space,i);
	}
	printf("\nswitch:\t");
	for( int i = 0; i < 20; i++ ){
		printf("%*d",space,switchArr[i]);
	}
	printf("\n\n\t");
	for( int i = 'U'; i <= 'Z'; i++ ){
		printf("%*c",space,i);
	}
	for( int i = 'a'; i <= 'n'; i++ ){
		printf("%*c",space,i);
	}
	printf("\nswitch:\t");
	for( int i = 20; i < 40; i++ ){
		printf("%*d",space,switchArr[i]);
	}
	printf("\n\n\t");
	for( int i = 'o'; i <= 'z'; i++ ){
		printf("%*c",space,i);
	}
	printf("\nswitch:\t");
	for( int i = 40; i < 52; i++ ){
		printf("%*d",space,switchArr[i]);
	}
	printf("\n\n");


	for ( int j = 0; j < *cur/20+1; j++){
	if (*cur%20 == 0 && j == *cur/20)
		continue;		
	printf("\n\t");
	for ( int i = 0; i < 20; i++ ){
		if (i+j*20 < *cur)
		printf("%*d",space,i+j*20);
	}
	printf("\nsymbol:\t");
	for ( int i = 0; i < 20; i++ ){
		//if(symbolArr[i+j*20] == NULL)
		//	symbolArr[i+j*20] = '.';
		if (i+j*20 < *cur)
		printf("%*c",space,symbolArr[i+j*20]);
	}
	printf("\nnext:\t");
	for ( int i = 0; i < 20; i++ ){
		if (i+j*20 < *cur){
		if ( nextArr[i+j*20] > 0 )
			printf("%*d",space,nextArr[i+j*20]);
		else
			printf("%*c",space,' ');
		}
	}
	printf("\n");
	}

	//printf("SIZE:%d\n",*cur);
	return 0;
}

