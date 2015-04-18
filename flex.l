%option noyywrap
%{
#include "bison.tab.h"
#include "global.h"
int flag = 0;
int pp = 0;
%}

%%
[ \t] {inputBuff[offset++] = ' '; }
"<" { inputBuff[offset++] = '<'; return '<'; }
">" { inputBuff[offset++] = '>'; return '>'; }
"&" { inputBuff[offset++] = '&'; return '&'; }
[^<>& \t\n]+ { for (pp = 0; pp < strlen(yytext); pp++) {inputBuff[offset++] = yytext[pp];} return STRING; }
[\n] {return 0;}
%%
