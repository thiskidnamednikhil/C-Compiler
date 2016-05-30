%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *fp;

%}

%token INT FLOAT CHAR DOUBLE LONG VOID
%token FOR WHILE DO GOTO NEWLINE
%token IF ELSE
%token MAIN
%token NUM ID
%right '='
%left '<' '>' LE GE EQ NE LT GT
%%

start: Type MAIN '(' ')' '{' Instructions '}'
  | Type MAIN '(' INT ID ',' CHAR '*' '*' ID ')' '{' Instructions '}'
  ;

Instructions: Instruction NEWLINE
  | Instruction NEWLINE Instructions
  ;

Instruction: WhileStmt
  | ForStmt
  | IfStmt
  | DoWhileStmt
  | GotoStmt
  ;

WhileStmt: WHILE '(' Expression ')' Instruction
  | WHILE '(' Expression ')' '{' Instructions '}'
  ;

ForStmt: FOR '(' Expression ';' Expression ';' Expression ')' Instruction
  | FOR '(' Expression ';' Expression ';' Expression ')' '{' Instructions '}'
  ;

DoWhileStmt: DO '{' Instructions '}' WHILE '(' Expression ')' ';'
  ;

IfStmt: IfBlock ElseBlock
  ;

IfBlock: IF '(' Expression ')' Instruction
  | IF '(' Expression ')' '{' Instructions '}'
  ;

ElseBlock: ELSE '\n' Instruction
  | ELSE '\n' '{' Instructions '}'
  | ELSE IfBlock
  ;

GotoStmt: GOTO ID ';'
  ;

Expression:Expression LE Expression
	| Expression GE Expression
	| Expression NE Expression
	| Expression EQ Expression
	| Expression GT Expression
	| Expression LT Expression
  | ID
  ;

Type: INT
  | FLOAT
  | CHAR
  | DOUBLE
  | LONG
  | VOID
  ;


  %%
  #include"lex.yy.c"

  int main(int argc, char *argv[])
  {
  	yyin = fopen(argv[1], "r");

     if(!yyparse())
  		printf("\nParsing complete\n");
  	else
  		printf("\nParsing failed\n");

  	fclose(yyin);
      return 0;
  }

  yyerror(char *s) {
  	printf("%d : %s %s\n", yylineno, s, yytext );
  }
