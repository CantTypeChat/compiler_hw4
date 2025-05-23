

digit       [0-9]
letter      [a-zA-Z_]
delim       [ \t]
line        [\n]
ws          {delim}+
float				{digit}+\.{digit}*
identifier  {letter}({letter}|{digit})*
string_literal    \"(\\.|[^\\"\n])*\"
integer_literal    [0-9]|[1-9][0-9]+
char_literal      \'\\.|[^\n]\'
%{
#include "y.tab.h"
extern int yylval;
int checkIdentifier(char *s);
%}

%%
{ws}            { }
{line}          { }

"auto"          { return(AUTO_SYM); }
"break"         { return(BREAK_SYM); }
"case"          { return(CASE_SYM); }
"continue"      { return(CONTINUE_SYM); }
"default"       { return(DEFAULT_SYM); }
"do"            { return(DO_SYM); }
"else"          { return(ELSE_SYM); }
"enum"          { return(ENUM_SYM); }
"for"           { return(FOR_SYM); }
"if"            { return(IF_SYM); }
"return"        { return(RETURN_SYM); }
"sizeof"        { return(SIZEOF_SYM); }
"struct"        { return(STRUCT_SYM); }
"switch"        { return(SWITCH_SYM); }
"typedef"       { return(TYPEDEF_SYM); }
"union"         { return(UNION_SYM); }
"while"         { return(WHILE_SYM); }
"\+\+"            { return(PLUSPLUS); }
"\-\-"            { return(MINUSMINUS); }
"\->"            { return(ARROW); }
"<"             { return(LSS); }
">"             { return(GTR); }
"<="            { return(LEQ); }
">="                        { return(GEQ); }
"=="                        { return(EQL); }
"!="                        { return(NEQ); }
"&&"                        { return(AMPAMP); }
"||"                        { return(BARBAR); }
"\.\.\."                       { return(DOTDOTDOT); }

"\("                         { return(LP); }
"\)"                         { return(RP); }
"\["                         { return(LB); }
"\]"                         { return(RB); }
"\{"                         { return(LR); }
"\}"                         { return(RR); }

"\:"                         { return(COLON); }
"\."                         { return(DOT); }
"\,"                         { return(COMMA); }
"\!"                         { return(EXCL); }
"*"                         { return(STAR); }
"\/"                         { return(SLASH); }
"\%"                         { return(PERCENT); }
"\&"                         { return(AMP); }
"\;"                         { return(SEMICOLON); }

"\+"                         { return(PLUS); }
"\-"                         { return(MINUS); }
"\="                         { return(ASSIGN); }
"\^"                         { return(BXOR); }

"~"                         { return(TILDE); }
"|"                         { return(BAR); }
">>"                        { return(GTRGTR); }
"<<"                        { return(LSSLSS); }
"\?"                         { return(QUESTION); }

"volatile"                 { return(VOLATILE_SYM); }
"static"                   { return(STATIC_SYM); }


"const"                    { return(CONST_SYM); }
"goto"                     { return(GOTO_SYM); }

{integer_literal}                   { return(INTEGER_CONSTANT); }
{float}                    { return(FLOAT_CONSTANT); }
{identifier}               { return(checkIdentifier(yytext)); }
{string_literal}       { return(STRING_LITERAL); }
{char_literal}         { return(CHARACTER_CONSTANT); }

%%

int checkIdentifier(char *s) {
    char *table[] = {"int", "float", "char", "void"};
    int i = 0;
    for(int i = 0; i < 4; i++) {
        if(strcmp(table[i], s) == 0) {
            return TYPE_IDENTIFIER;
        }
    }
    return IDENTIFIER;
}

int yywrap(void) {
    return (1);
}
