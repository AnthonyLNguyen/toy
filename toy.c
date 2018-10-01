#include <stdio.h>
#include "toy.h"

extern int yylex();
extern int yylineno;
extern char* yytext;


char *names[] = {NULL, "_boolean", "_break", "_class", "_double", "_else", "_extends", "_for", "_if", "_implements", "_int", "_interface", "_new", "_newarray", "_null", "_println", "_readln", "_return", "_string", "_void", "_while", "_plus", "_minus", "_multiplication", "_division", "_mod", "_less", "_lessequal", "_greater", "_greaterequal", "_equal", "_notequal", "_and", "_or", "_not", "_assignop", "_semicolon", "_comma", "_period", "_leftparen", "_rightparen", "_leftbracket", "_rightbracket", "_leftbrace", "_rightbrace", "_intconstant", "_doubleconstant", "_stringconstant", "_booleanconstant", "_id" };

char *tokens[] = {NULL, "boolean", "break", "class", "double", "else", "extends", "for", "if", "implements", "int", "interface", "new", "newarray", "null", "println", "readln", "return", "string", "void", "while", "plus", "minus", "multiplication", "division", "mod", "less", "lessequal", "greater", "greaterequal", "equal", "notequal", "and", "or", "not", "assignop", "semicolon", "comma", "period", "leftparen", "rightparen", "leftbracket", "rightbracket", "leftbrace", "rightbrace", "intconstant", "doubleconstant", "stringconstant", "booleanconstant", "id" };

int main(void)
{
	int ntoken, vtoken;

	ntoken = yylex();
	while(ntoken) {
		//printf("%d", ntoken);
		printf("%s ",tokens[ntoken]);
		ntoken = yylex();
	}
	return 0;
}
