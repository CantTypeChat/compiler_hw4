%{
#include<stdio.h>
#include<stdlib.h>
%}

%token AUTO_SYM BREAK_SYM CASE_SYM CONTINUE_SYM DEFAULT_SYM DO_SYM ELSE_SYM ENUM_SYM FOR_SYM IF_SYM RETURN_SYM SIZEOF_SYM STRUCT_SYM SWITCH_SYM TYPEDEF_SYM UNION_SYM WHILE_SYM PLUSPLUS MINUSMINUS ARROW LSS GTR LEQ GEQ EQL NEQ AMPAMP BARBAR AMP BAR DOTDOTDOT DOT LP RP LB RB LR RR COLON COMMA EXCL STAR SLASH PERCENT PLUS MINUS ASSIGN INTEGER_CONSTANT FLOAT_CONSTANT STRING_LITERAL CHARACTER_CONSTANT TILDE BXOR SEMICOLON STATIC_SYM CONST_SYM VOLATILE_SYM TYPE_IDENTIFIER IDENTIFIER LSSLSS GTRGTR GTR QUESTION GOTO_SYM

%%
program             :   translation_unit
                    ;
translation_unit    :   external_declaration
                    |   translation_unit external_declaration
                    ;

external_declaration:   function_definition
                    |   declaration
                    ;

function_definition :   declaration_specifiers declarator compound_statement
                    |   declarator compound_statement
                    ;

declaration         :   declaration_specifiers init_declarator_list SEMICOLON
                    ;

declaration_specifiers: type_specifier
                      | storage_class_specifier
                      | type_qualifier
                      | type_specifier declaration_specifiers
                      | storage_class_specifier declaration_specifiers
                      | type_qualifier declaration_specifiers
                      ;

storage_class_specifier: AUTO_SYM
                       | STATIC_SYM
                       | TYPEDEF_SYM
                       ;

type_qualifier_opt     : /* empty */
                       | type_qualifier
                       ;

type_qualifier         : CONST_SYM
                       | VOLATILE_SYM
                       ;

init_declarator_list   : init_declarator
                       | init_declarator_list COMMA init_declarator
                       ;

init_declarator        : declarator
                       | declarator ASSIGN initializer
                       ;

type_specifier         : struct_specifier
                       | enum_specifier
                       | TYPE_IDENTIFIER
                       ;

struct_specifier        : struct_or_union IDENTIFIER LR struct_declaration_list RR
                        | struct_or_union LR struct_declaration_list RR
                        | struct_or_union IDENTIFIER
                        ;

struct_or_union         : STRUCT_SYM
                        | UNION_SYM
                        ;

struct_declaration_list : struct_declaration
                        | struct_declaration_list struct_declaration
                        ;

struct_declaration      : specifier_qualifier_list struct_declarator_list SEMICOLON
                        ;

specifier_qualifier_list: type_specifier
                        | type_qualifier
                        | type_specifier specifier_qualifier_list
                        | type_qualifier specifier_qualifier_list
                        ;

struct_declarator_list  : struct_declarator
                        | struct_declarator_list COMMA struct_declarator
                        ;

struct_declarator       : declarator
                        | COLON constant_expression
                        | declarator COLON constant_expression
                        ;

enum_specifier          : ENUM_SYM IDENTIFIER LR enumerator_list RR
                        | ENUM_SYM LR enumerator_list RR
                        | ENUM_SYM IDENTIFIER
                        ;

enumerator_list         : enumerator
                        | enumerator_list COMMA enumerator
                        ;

enumerator              : IDENTIFIER
                        | IDENTIFIER ASSIGN constant_expression
                        ;

declarator              : pointer direct_declarator
                        | direct_declarator
                        ;

pointer                 : STAR type_qualifier_opt
                        | STAR type_qualifier_opt pointer
                        ;


direct_declarator       : IDENTIFIER
                        | LP declarator RP
                        | direct_declarator LB constant_expression_opt RB
                        | direct_declarator LP parameter_type_list_opt RP
                        ;

constant_expression_opt : /* empty */
                        | constant_expression
                        ;

parameter_type_list_opt : /* empty */
                        | parameter_type_list
                        ;

parameter_type_list     : parameter_list
                        | parameter_list COMMA DOTDOTDOT
                        ;

parameter_list          : parameter_declaration
                        | parameter_list COMMA parameter_declaration
                        ;

parameter_declaration   : declaration_specifiers declarator
                        | declaration_specifiers abstract_declarator_opt
                        ;

abstract_declarator_opt : /* empty */
                        | abstract_declarator
                        ;
abstract_declarator     : pointer
                        | direct_abstract_declarator
                        | pointer direct_abstract_declarator
                        ;

direct_abstract_declarator : LP abstract_declarator RP
                           | LB constant_expression_opt RB
                           | LP parameter_type_list_opt RP
                           | direct_abstract_declarator LB constant_expression_opt RB
                           | direct_abstract_declarator LP parameter_type_list_opt RP
                           ;

initializer             :   expression
                        |   LR initializer_list RR
                        |   LR initializer_list COMMA RR
                        ;

initializer_list        :   initializer
                        | initializer_list COMMA initializer
                        ;

statement               : labeled_statement
                        | compound_statement
                        | expression_statement
                        | selection_statement
                        | iteration_statement
                        | jump_statement
                        ;

labeled_statement       : CASE_SYM constant_expression COLON statement
                        | DEFAULT_SYM COLON statement
                        | IDENTIFIER COLON statement
                        ;

compound_statement      : LR declaration_list statement_list RR
                        ;

declaration_list        : /* empty */
                        | declaration_list declaration
                        ;

statement_list          : /* empty */
                        | statement_list statement
                        ;

expression_statement    : SEMICOLON
                        | expression SEMICOLON
                        ;

selection_statement     : IF_SYM LP expression RP statement
                        | IF_SYM LP expression RP statement ELSE_SYM statement
                        | SWITCH_SYM LP expression RP statement
                        ;

iteration_statement     : WHILE_SYM LP expression RP statement
                        | DO_SYM statement WHILE_SYM LP expression RP SEMICOLON
                        | FOR_SYM LP expression_opt SEMICOLON expression_opt SEMICOLON expression_opt RP statement
                        ;

expression_opt          : /* empty */
                        | expression
                        ;

jump_statement          : RETURN_SYM expression_opt SEMICOLON
                        | CONTINUE_SYM SEMICOLON
                        | BREAK_SYM SEMICOLON
                        | GOTO_SYM IDENTIFIER SEMICOLON
                        ;

primary_expression      : IDENTIFIER
                        | INTEGER_CONSTANT
                        | FLOAT_CONSTANT
                        | CHARACTER_CONSTANT
                        | STRING_LITERAL
                        | LP expression RP
                        ;

postfix_expression      : primary_expression
                        | postfix_expression LB expression RB
                        | postfix_expression LP arg_expression_list_opt RP
                        | postfix_expression DOT IDENTIFIER
                        | postfix_expression ARROW IDENTIFIER
                        | postfix_expression PLUSPLUS
                        | postfix_expression MINUSMINUS
                        ;

arg_expression_list_opt : /* empty */
                        | arg_expression_list
                        ;

arg_expression_list     : assignment_expression
                        | arg_expression_list COMMA assignment_expression
                        ;

unary_expression        : postfix_expression
                        | PLUSPLUS unary_expression
                        | MINUSMINUS unary_expression
                        | AMP cast_expression
                        | STAR cast_expression
                        | EXCL cast_expression
                        | MINUS cast_expression
                        | TILDE cast_expression
                        | PLUS cast_expression
                        | SIZEOF_SYM unary_expression
                        | SIZEOF_SYM LP type_name RP
                        ;

cast_expression         : unary_expression
                        | LP type_name RP cast_expression
                        ;


type_name               : declaration_specifiers
                        | declaration_specifiers abstract_declarator
                        ;

multiplicative_expression   :   cast_expression
                            |   multiplicative_expression STAR cast_expression
                            |   multiplicative_expression SLASH cast_expression
                            |   multiplicative_expression PERCENT cast_expression
                            ;

additive_expression         :   multiplicative_expression
                            |   additive_expression PLUS multiplicative_expression
                            | additive_expression MINUS multiplicative_expression
                            ;

shift_expression            : additive_expression
                            | shift_expression LSSLSS additive_expression
                            | shift_expression GTRGTR additive_expression
                            ;

relational_expression       :   shift_expression
                            |   relational_expression LSS shift_expression
                            |   relational_expression GTR shift_expression
                            |   relational_expression LEQ shift_expression
                            |   relational_expression GEQ shift_expression
                            ;

equality_expression         :   relational_expression
                            | equality_expression EQL relational_expression
                            | equality_expression NEQ relational_expression
                            ;

AND_expression              : equality_expression
                            | AND_expression AMP equality_expression
                            ;

exclusive_OR_expression     : AND_expression
                            | exclusive_OR_expression BXOR AND_expression
                            ;

inclusive_OR_expression     : exclusive_OR_expression
                            | inclusive_OR_expression BAR exclusive_OR_expression
                            ;

logical_AND_expression      : inclusive_OR_expression
                            | logical_AND_expression AMPAMP inclusive_OR_expression
                            ;

logical_OR_expression       : logical_AND_expression
                            | logical_OR_expression BARBAR logical_AND_expression
                            ;

conditional_expression      : logical_OR_expression
                            | logical_OR_expression QUESTION expression COLON conditional_expression
                            ;

assignment_expression       : conditional_expression
                            | unary_expression ASSIGN assignment_expression
                            ;

comma_expression            : assignment_expression
                            ;

expression                  : comma_expression
                            ;

constant_expression         : expression

%%

int yyerror(char* s)
{
    fprintf(stderr, "%s \n", s);
    exit(1);
}



int main(void)
{
    yyparse();
    printf("success!\n");
    return 0;
}

