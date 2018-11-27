 %{
 #include <stdio.h>
 int yylex();
 %}

%token _boolean _break _class _double _else _extends _for _if _implements _int _interface _new _newarray _null _println _readln _return _string _void _while _plus _minus _multiplication _division _mod _less _lessequal _greater _greaterequal _equal _notequal _and _or _not _assignop _semicolon _comma _period _leftparen _rightparen _leftbracket _rightbracket _leftbrace _rightbrace _intconstant _doubleconstant _stringconstant _booleanconstant _id

 %%
 Program : DeclPlus ;
 DeclPlus : Decl DeclPlus ;
 DeclPlus : Decl ;
 Decl : VariableDecl ;
 Decl : FunctionDecl ;
 Decl : ClassDecl ;
 Decl : InterfaceDecl ;
 VariableDecl : Variable ';' ;
 Variable : Type _id ;
 Type : _int ;
 Type : _double ;
 Type : _boolean ;
 Type : _string ;
 Type : Type '[' ']' ;
 Type : _id ;
 FunctionDecl : Type _id '(' Formals ')' StmtBlock ;
 FunctionDecl : _void _id '(' Formals ')' StmtBlock ;
 Formals : VariablePlusComma ;
 Formals :  ;
 VariablePlusComma : Variable ',' VariablePlusComma ;
 VariablePlusComma : Variable ;
 ClassDecl : _class _id ClassDeclOptional '{' FieldStar '}' ;
 ClassDeclOptional : _extends _id ;
 ClassDeclOptional : _implements IdPlusComma ;
 ClassDeclOptional : _extends _id _implements IdPlusComma ;
 ClassDeclOptional :  ;
 IdPlusComma : _id ',' IdPlusComma ;
 IdPlusComma : _id ;
 FieldStar : Field FieldStar ;
 FieldStar :  ;
 Field : VariableDecl ;
 Field : FunctionDecl ;
 InterfaceDecl : _interface _id '{' PrototypeStar '}' ;
 PrototypeStar : Prototype PrototypeStar ;
 PrototypeStar :  ;
 Prototype : Type _id '(' Formals ')' ';' ;
 Prototype : _void _id '(' Formals ')' ';' ;
 StmtBlock : '{' VariableDeclStar StmtStar '}' ;
 VariableDeclStar : VariableDecl VariableDeclStar ;
 VariableDeclStar :  ;
 StmtStar : Stmt StmtStar ;
 StmtStar :  ;
 Stmt : ExprOptional ';' ;
 Stmt : IfStmt ;
 Stmt : WhileStmt ;
 Stmt : ForStmt ;
 Stmt : BreakStmt ;
 Stmt : ReturnStmt ;
 Stmt : PrintStmt ;
 Stmt : StmtBlock ;
 ExprOptional : Expr ;
 ExprOptional :  ;
 IfStmt : _if '(' Expr ')' Stmt IfStmtOptional ;
 IfStmtOptional : _else Stmt ;
 IfStmtOptional :  ;
 WhileStmt : _while '(' Expr ')' Stmt ;
 ForStmt : _for '(' ExprOptional ';' Expr ';' ExprOptional ')' Stmt ;
 BreakStmt : _break ; ;
 ReturnStmt : _return ExprOptional ; ;
 PrintStmt : _println '(' ExprPlusComma ')' ;
 ExprPlusComma : Expr ',' ExprPlusComma ;
 ExprPlusComma : Expr ;
 Expr : ExprA ;
 ExprA : ExprB ;
 ExprA : Lvalue '=' ExprB ;
 ExprB : ExprC ;
 ExprB : ExprB '|' '|' ExprC ;
 ExprC : ExprD ;
 ExprC : ExprC '&' '&' ExprD ;
 ExprD : ExprE ;
 ExprD : ExprD '=' '=' ExprE ;
 ExprD : ExprD '!' '=' ExprE ;
 ExprE : ExprF ;
 ExprE : ExprE '<' ExprF ;
 ExprE : ExprE '<' '=' ExprF ;
 ExprE : ExprE '>' ExprF ;
 ExprE : ExprE '>' '=' ExprF ;
 ExprF : ExprG ;
 ExprF : ExprF '+' ExprG ;
 ExprF : ExprF '-' ExprG ;
 ExprG : ExprH ;
 ExprG : ExprF '*' ExprG ;
 ExprG : ExprF '/' ExprG ;
 ExprG : ExprF '%' ExprG ;
 ExprH : ExprI ;
 ExprH : '!' ExprH ;
 ExprH : '-' ExprH ;
 ExprI : Lvalue ;
 ExprI : Constant ;
 ExprI : Call ;
 ExprI : '(' Expr ')' ;
 Lvalue : _id ;
 Lvalue : Lvalue '[' Expr ']' ;
 Lvalue : Lvalue '.' _id ;
 Call : _id '(' Actuals ')' ;
 Call : _id '.' _id '(' Actuals ')' ;
 Actuals : ExprPlusComma ;
 Actuals :  ;
 Constant : _intconstant ;
 Constant : _doubleconstant ;
 Constant : _stringconstant ;
 Constant : _booleanconstant ;
 Constant : _null ;
 %%
 void yyerror (char *s) {
   fprintf (stderr, "%s\n", s);
 }
int main() {
 yyparse();
}
