%{
int flag=0;
int flag1=0;
%}

%token STRING

ignore_char [ \t]           

%%
{ignore_char} {if(flag1 == 1) return STRING;}
"<"{ flag1 = 1;if(flag == 1){flag = 0;return STRING;}return "<";}
">"{ flag1 = 1;if(flag == 1){flag = 0;return STRING;}return ">";}
"&"{ flag1 = 1;if(flag == 1){flag = 0;return STRING;}return "&";} 
"\n" { if(flag==1) return STRING;else return 0;}
[^ \t\n><&] { flag1=1;flag=0;}
%%