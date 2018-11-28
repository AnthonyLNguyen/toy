%{
#include <stdio.h>
int yylex();
%}
%token _boolean _break _class _double _else _extends _for _if _implements _int _interface _new _newarray _null _println _readln _return _string _void _while _plus _minus _uminus _multiplication _division _mod _less _lessequal _greater _greaterequal _equal _notequal _and _or _not _assignop _semicolon _comma _period _leftparen _rightparen _leftbracket _rightbracket _leftbrace _rightbrace _intconstant _doubleconstant _stringconstant _booleanconstant _id
%right _assignop
%left _or
%left _and
%left _equal _notequal
%left _less _lessequal _greater _greaterequal
%left _plus _minus
%left _multiplication _division _mod
%right _not _uminus
%%
Program : DeclPlus ;
DeclPlus : Decl DeclPlus ;
DeclPlus : Decl ;
Decl : VariableDecl ;
Decl : FunctionDecl ;
Decl : ClassDecl ;
Decl : InterfaceDecl ;
VariableDecl : Variable _semicolon ;
Variable : Type _id ;
Type : _int ;
Type : _double ;
Type : _boolean ;
Type : _string ;
Type : Type _leftbracket _rightbracket ;
Type : _id ;
FunctionDecl : Type _id _leftparen Formals _rightparen StmtBlock ;
FunctionDecl : _void _id _leftparen Formals _rightparen StmtBlock ;
Formals : VariablePlusComma ;
Formals :  ;
VariablePlusComma : Variable _comma VariablePlusComma ;
VariablePlusComma : Variable ;
ClassDecl : _class _id ClassDeclOptional _rightbrace FieldStar _leftbrace ;
ClassDeclOptional : _extends _id ;
ClassDeclOptional : _implements IdPlusComma ;
ClassDeclOptional : _extends _id _implements IdPlusComma ;
ClassDeclOptional :  ;
IdPlusComma : _id _comma IdPlusComma ;
IdPlusComma : _id ;
FieldStar : Field FieldStar ;
FieldStar :  ;
Field : VariableDecl ;
Field : FunctionDecl ;
InterfaceDecl : _interface _id _rightbrace PrototypeStar _leftbrace ;
PrototypeStar : Prototype PrototypeStar ;
PrototypeStar :  ;
Prototype : Type _id _leftparen Formals _rightparen _semicolon ;
Prototype : _void _id _leftparen Formals _rightparen _semicolon ;
StmtBlock : _rightbrace VariableDeclStar StmtStar _leftbrace ;
VariableDeclStar : VariableDecl VariableDeclStar ;
VariableDeclStar :  ;
StmtStar : Stmt StmtStar ;
StmtStar :  ;
Stmt : ExprOptional _semicolon ;
Stmt : IfStmt ;
Stmt : WhileStmt ;
Stmt : ForStmt ;
Stmt : BreakStmt ;
Stmt : ReturnStmt ;
Stmt : PrintStmt ;
Stmt : StmtBlock ;
ExprOptional : Expr ;
ExprOptional :  ;
IfStmt : _if _leftparen Expr _rightparen Stmt IfStmtOptional ;
IfStmtOptional : _else Stmt ;
IfStmtOptional :  ;
WhileStmt : _while _leftparen Expr _rightparen Stmt ;
ForStmt : _for _leftparen ExprOptional _semicolon Expr _semicolon ExprOptional _rightparen Stmt ;
BreakStmt : _break ; ;
ReturnStmt : _return ExprOptional ; ;
PrintStmt : _println _leftparen ExprPlusComma _rightparen ;
ExprPlusComma : Expr _comma ExprPlusComma ;
ExprPlusComma : Expr ;
Expr : Lvalue _assignop Expr
| Constant
| Lvalue
| Call
| _leftparen Expr _rightparen
| Expr _plus Expr
| Expr _minus Expr
| Expr _multiplication Expr
| Expr _division Expr
| Expr _mod Expr
| _uminus Expr
| Expr _less Expr
| Expr _lessequal Expr
| Expr _greater Expr
| Expr _greaterequal Expr
| Expr _equal Expr
| Expr _notequal Expr
| Expr _and Expr
| Expr _or Expr
| _not Expr ;
Lvalue : _id ;
Lvalue : Lvalue _leftbrace Expr _rightbracket ;
Lvalue : Lvalue _period _id ;
Call : _id _leftparen Actuals _rightparen ;
Call : _id _period _id _leftparen Actuals _rightparen ;
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
