%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char *);
#define YYDEBUG 1
%}
%token _boolean _break _class _double _else _extends _for _if _implements _int _interface _new _newarray _null _println _readln _return _string _void _while _plus _minus _multiplication _division _mod _less _lessequal _greater _greaterequal _equal _notequal _and _or _not _assignop _semicolon _comma _period _leftparen _rightparen _leftbracket _rightbracket _leftbrace _rightbrace _intconstant _doubleconstant _stringconstant _booleanconstant _id
%right _assignop
%left _or
%left _and
%left _equal _notequal
%nonassoc _less _lessequal _greater _greaterequal
%left _plus _minus
%left _multiplication _division _mod
%left _not _uminus
%%
Program           : DeclPlus ;
DeclPlus          : Decl DeclPlus
                  | Decl ;
Decl              : VariableDecl
                  | FunctionDecl
                  | ClassDecl
                  | InterfaceDecl ;
VariableDecl      : Variable _semicolon ;
Variable          : Type _id
                  | _id _id;
Type              : _int
                  | _double
                  | _boolean
                  | _string
                  | Type _leftbracket _rightbracket
                  | _id  _leftbracket _rightbracket;
FunctionDecl      : Type _id _leftparen Formals _rightparen StmtBlock
                  | _void _id _leftparen Formals _rightparen StmtBlock
                  | _id _id _leftparen Formals _rightparen StmtBlock;
Formals           : VariablePlusComma
                  | ;
VariablePlusComma : Variable _comma VariablePlusComma
                  | Variable ;
ClassDecl         : _class _id ClassDeclOptional _leftbrace FieldStar _rightbrace ;
ClassDeclOptional : _extends _id
                  | _implements IdPlusComma
                  | _extends _id _implements IdPlusComma
                  | ;
IdPlusComma       : _id _comma IdPlusComma
                  | _id ;
FieldStar         : Field FieldStar
                  | ;
Field             : VariableDecl
                  | FunctionDecl ;
InterfaceDecl     : _interface _id _leftbrace PrototypeStar _rightbrace ;
PrototypeStar     : Prototype PrototypeStar
                  | ;
Prototype         : Type _id _leftparen Formals _rightparen _semicolon
                  | _void _id _leftparen Formals _rightparen _semicolon
                  | _id _id _leftparen Formals _rightparen _semicolon;
StmtBlock         : _leftbrace _rightbrace
                  | _leftbrace VariableDeclStar _rightbrace
                  | _leftbrace StmtStar _rightbrace
                  | _leftbrace VariableDeclStar StmtStar _rightbrace ;
VariableDeclStar  : VariableDecl VariableDeclStar
                  | VariableDecl;
StmtStar          : Stmt StmtStar
                  | Stmt;
Stmt              : ExprOptional _semicolon
                  | IfStmt
                  | WhileStmt
                  | ForStmt
                  | BreakStmt
                  | ReturnStmt
                  | PrintStmt
                  | StmtBlock ;
ExprOptional      : Expr
                  | ;
IfStmt            : _if _leftparen Expr _rightparen Stmt IfStmtOptional ;
IfStmtOptional    : _else Stmt
                  | ;
WhileStmt         : _while _leftparen Expr _rightparen Stmt ;
ForStmt           : _for _leftparen ExprOptional _semicolon Expr _semicolon ExprOptional _rightparen Stmt ;
BreakStmt         : _break _semicolon ;
ReturnStmt        : _return ExprOptional _semicolon ;
PrintStmt         : _println _leftparen ExprPlusComma _rightparen
ExprPlusComma     : Expr _comma ExprPlusComma
                  | Expr ;
Expr              : Lvalue _assignop Expr
                  | _id _assignop Expr
                  | Constant
                  | Lvalue
                  | Call
                  | _leftparen Expr _rightparen
                  | Expr _plus Expr
                  | Expr _minus Expr
                  | Expr _multiplication Expr
                  | Expr _division Expr
                  | Expr _mod Expr
                  | _minus Expr %prec _uminus
                  | Expr _less Expr
                  | Expr _lessequal Expr
                  | Expr _greater Expr
                  | Expr _greaterequal Expr
                  | Expr _equal Expr
                  | Expr _notequal Expr
                  | Expr _and Expr
                  | Expr _or Expr
                  | _not Expr
                  | _readln _leftparen _rightparen
                  | _new _leftparen _id _rightparen
                  | _newarray _leftparen _intconstant _comma Type _rightparen
                  | _newarray _leftparen _intconstant _comma _id _rightparen ;
Lvalue            : _id _leftbracket Expr _rightbracket
                  | _id _period _id
                  | Lvalue _leftbracket Expr _rightbracket
                  | Lvalue _period _id ;
Call              : _id _leftparen Actuals _rightparen
                  | _id _period _id _leftparen Actuals _rightparen ;
Actuals           : ExprPlusComma
                  | ;
Constant          : _intconstant
                  | _doubleconstant
                  | _stringconstant
                  | _booleanconstant
                  | _null ;
%%
void yyerror (char *s) {
  fprintf (stderr, "%s\n", s);
}
int main(void) {
    yyparse();
    return 0;
}
