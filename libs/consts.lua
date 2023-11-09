
TokenType = {
    TT_NUMBER     = 0,
    TT_STRING     = 1,
    TT_KEYWORD    = 2,
    TT_IDENTIFIER = 3,
    TT_ADD        = 100,
    TT_DIV        = 101,
    TT_MUL        = 102,
    TT_SUB        = 103
}

DIGITS = "0123456789"
ID_VALID_START = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
ID_VALID_CHARS = ID_VALID_START .. DIGITS
WHITESPACE_CHARS = " \t\r"

OPERATORS = {"+","-","=","*","/","^","(",")"}
KEYWORDS = {
    "let",
    "fun"
}

TT_OPERATOR_HASH = {
    ["+"] = TokenType.TT_ADD,
    ["-"] = TokenType.TT_SUB,
    ["*"] = TokenType.TT_MUL,
    ["/"] = TokenType.TT_DIV
}
