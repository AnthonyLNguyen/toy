%{
#include "toy.h"
%}

%%
"boolean"	return _boolean;
"break"		return _break;
"class"		return _class;
"double"	return _double;
"else"		return _else;
"extends"	return _extends;
"for"		return _for;
"if"		return _if;
"implements"	return _implements;
"int"		return _int;
"interface"	return _interface;
"new"		return _new;
"newarray"	return _newarray;
"null"		return _null;
"println"	return _println;
"readln"	return _readln;
"return"	return _return;
"string"	return _string;
"void"		return _void;
"while"		return _while;
"true"		return _booleanconstant;
"false"		return _booleanconstant;
(0[Xx][A-Fa-f0-9]+|[0-9]+)			return _intconstant;
[0-9]+\.[0-9]*(E[\+-][0-9])?			return _doubleconstant;
[\"\“][^\n\"\“\”]*[\"\”]			return _stringconstant;
[A-Za-z][A-Za-z0-9_]*				return _id;
\+	return _plus;
\-	return _minus;
\*	return _multiplication;
\/	return _division;
\%	return _mod;
\<	return _less;
\<\=	return _lessequal;
\>	return _greater;
\>\=	return _greaterequal;
\=\=	return _equal;
\!\=	return _notequal;
\&\&	return _and;
\|\|	return _or;
\!	return _not;
\=	return _assignop;
\;	return _semicolon;
\,	return _comma;
\.	return _period;
\(	return _leftparen;
\)	return _rightparen;
\[	return _leftbracket;
\]	return _rightbracket;
\{	return _leftbrace;
\}	return _rightbrace;

\n			printf("\n");
[ \t]			;
\/\/.*\n		;
\/\*[^*]*\*\/\n 	;
.	printf("\nUNEXPECTED CHAR\n");
%%

int yywrap(void)
{
	return 1;
}
