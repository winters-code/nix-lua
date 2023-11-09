
TokenType = {
    TT_NUMBER     = 0,
    TT_STRING     = 1,
    TT_KEYWORD    = 2,
    TT_IDENTIFIER = 3,
    TT_ADD        = 100,
    TT_DIV        = 101,
    TT_MUL        = 102,
    TT_SUB        = 103,
    TT_LPAREN     = 200,
    TT_RPAREN     = 201
}

DIGITS = {"0","1","2","3","4","5","6","7","8","9"}
DIGITS_DOT = {"0","1","2","3","4","5","6","7","8","9","."}
ID_VALID_START = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
WHITESPACE_CHARS = " \t\r\n"

OPERATORS = {"+","-","=","*","/","^","(",")"}
KEYWORDS = {
    "let",
    "fun"
}

TT_OPERATOR_HASH = {
    ["+"] = TokenType.TT_ADD,
    ["-"] = TokenType.TT_SUB,
    ["*"] = TokenType.TT_MUL,
    ["/"] = TokenType.TT_DIV,
    ["%("] = TokenType.TT_LPAREN,
    ["%)"] = TokenType.TT_RPAREN
}
