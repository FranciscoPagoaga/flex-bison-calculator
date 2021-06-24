%{
#include "calc.tab.hh"
#include <iostream>
using namespace std;
%}

%option noyywrap

%%
[0-9]+      { yylval.num = atoi(yytext); return NUM;}
"*"         { yylval.sign = yytext[0]; return MULT; }
"/"         { yylval.sign = yytext[0]; return DIV; }
"+"         { yylval.sign = yytext[0]; return SUM; }
"-"         { yylval.sign = yytext[0]; return SUB; }
"**"        { yylval.sign = yytext[0]; return EXP; }
"("         { return FP; }
")"         { return LP; }
"="         { return END; }
[ \t]       { }
[ \n]       { }
.           { cerr << "Caracter no valido" << endl; exit(1);}
%%