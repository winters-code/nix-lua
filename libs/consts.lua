
TokenType = {
    TT_NUMBER     = 0,
    TT_OPERATOR   = 1,
    TT_STRING     = 2,
    TT_KEYWORD    = 3,
    TT_IDENTIFIER = 4
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

OPERATIONS = {
    "+": "Add",
    "-": "Sub",
    "/": "Div",
    "*": "Mul"
}