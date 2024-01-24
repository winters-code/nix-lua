
TokenType = {
    TT_NUMBER     = 0,
    TT_STRING     = 1,
    TT_KEYWORD    = 2,
    TT_IDENTIFIER = 3,
    TT_ADD        = 100,
    TT_DIV        = 101,
    TT_MUL        = 102,
    TT_SUB        = 103,
    TT_POW        = 104,
    TT_MOD        = 105,
    TT_LPAREN     = 200,
    TT_RPAREN     = 201,
    TT_LBRACE     = 202,
    TT_RBRACE     = 203
}

DIGITS = "0123456789"
DIGITS_DOT = DIGITS .. "."
ID_VALID_START = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
ID_VALID_DURING = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
WHITESPACE_CHARS = " \t\r\n"

OPERATORS = {"+","-","=","*","/","^","(",")", "{", "}", "%"}
KEYWORDS = {
    "let",
    "fun"
}

TT_OPERATOR_HASH = {
    ["+"] = TokenType.TT_ADD,
    ["-"] = TokenType.TT_SUB,
    ["*"] = TokenType.TT_MUL,
    ["/"] = TokenType.TT_DIV,
    ["^"] = TokenType.TT_POW,
    ["("] = TokenType.TT_LPAREN,
    [")"] = TokenType.TT_RPAREN,
    ["{"] = TokenType.TT_LBRACE,
    ["}"] = TokenType.TT_RBRACE,
    ["%"] = TokenType.TT_MOD
}
