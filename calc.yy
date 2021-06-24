%{
#include <iostream>
#include <string>
using namespace std;
int yylex();
void yyerror(const char *p) { cerr << "Error!" << endl; }
%}

%union {
    int num;
    char sign;
};

%token <num> NUM
%token <sign> SUM SUB DIV MULT EXP FP LP END
%type  <num> POS VAL INS FCT ANS  

%%
RUN: ANS RUN | ANS

ANS: POS END   { cout << $1 << endl; }

POS: POS SUM VAL { $$ = $1 + $3 ;}
| VAL            { $$ = $1; }

POS: POS SUB VAL { $$ =  $1 - $3 ;}
| VAL            { $$ = $1; }

VAL: VAL MULT FCT { $$ =  $1 * $3 ; }
| INS              { $$ = $1; }

VAL: VAL DIV FCT { $$ = $1 / $3 ; }
| INS             { $$ = $1; }

VAL: VAL EXP FCT {
    int exponent= $1;
    for(int i=1;i<$3;i++){
        exponent*=$1;
        $$=exponent;
    }
}

INS: SUM FCT { $$ =  $2 ;}
| FCT            { $$ = $1; }

INS: SUB FCT { $$ =  -$2 ;}
| FCT            { $$ = $1; }

FCT: NUM         {$$ = $1; }
| FP POS LP         {$$ = $2; }

%%

int main(){
    yyparse();
    return 0;
}