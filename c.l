alpha [a-zA-Z]
digit [0-9]

%%
[ \t]		;
[ \n]   { yylineno = yylineno + 1;}
main return MAIN;
int	return INT;
float return FLOAT;
char return CHAR;
void return VOID;
double return DOUBLE;
long return LONG;
for 	return FOR;
do  return DO;
while	return WHILE;
goto return GOTO;
if	return IF;
else	return ELSE;
{digit}+       return NUM;
{alpha}({alpha}|{digit})* return ID;
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
">"	return GT;
"<"	return LT;
.       return yytext[0];
%%
