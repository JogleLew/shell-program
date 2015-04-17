%{
    #include "global.h"
    #include <unistd.h>
    #include <string.h>

    int yylex ();
    void yyerror ();
%}

%token STRING

%%
line            :   /* empty */
                    |command                        {   execute();  commandDone = 1;   }
;

command         :   fgCommand
                    |fgCommand '&'
;

fgCommand       :   simpleCmd
;

simpleCmd       :   progInvocation inputRedirect outputRedirect
;

progInvocation  :   STRING args
;

inputRedirect   :   /* empty */
                    |'<' STRING
;

outputRedirect  :   /* empty */
                    |'>' STRING
;

args            :   /* empty */
                    |args STRING
;

%%

/****************************************************************
                  词法分析函数
****************************************************************/
int yylex(){
    //这个函数用来检查inputBuff是否满足lex的定义，实际上并不进行任何操作，初期可略过不看
    int flag;
    char c;
    
    //跳过空格等无用信息
    while(offset < len && (inputBuff[offset] == ' ' || inputBuff[offset] == '\t')){ 
        offset++;
    }
    
    flag = 0;
    while(offset < len){ //循环进行词法分析，返回终结符
        c = inputBuff[offset];
        
        if(c == ' ' || c == '\t'){
            offset++;
            // printf("%d\n", STRING);
            return STRING;
        }
        
        if(c == '<' || c == '>' || c == '&'){
            if(flag == 1){
                flag = 0;
                // printf("%d\n", STRING);
                return STRING;
            }
            offset++;
            // printf("%c\n", c);
            return c;
        }
        
        flag = 1;
        offset++;
    }
    
    if(flag == 1){
        // printf("%d\n", STRING);
        return STRING;
    }else{
        return 0;
    }
}

/****************************************************************
                  错误信息执行函数
****************************************************************/
void yyerror()
{
    printf("你输入的命令不正确，请重新输入！\n");
}

/****************************************************************
                  main主函数
****************************************************************/
int main(int argc, char** argv) {
    int i;
    char c;

    init(); //初始化环境
    commandDone = 0;

    printf("yourname@computer:%s$ ", getcwd(0,0)); //打印提示符信息

    while(1){
        i = 0;
        while((c = getchar()) != '\n'){ //读入一行命令
            if ((int)c != -1)
                inputBuff[i++] = c;
        }
        inputBuff[i] = '\0';

        len = i;
        offset = 0;

        //memset(inputBuff, 0, sizeof(inputBuff));
        yyparse(); //调用语法分析函数，该函数由yylex()提供当前输入的单词符号

        if(commandDone == 1){ //命令已经执行完成后，添加历史记录信息
            commandDone = 0;
            addHistory(inputBuff);
        }

        printf("yourname@computer:%s$ ", getcwd(0,0)); //打印提示符信息
     }

    return (EXIT_SUCCESS);
}

