Lang::Token.define do
  # Used for identifying blocks
  token :Indent, "\n", capture: /[^ \t]/

  # Identifiers, for naming variables, methods, etc
  token :Identifier, /[a-zA-Z0-9]/, capture: /[\s:,.\(\[\{\]\}\)]/

  # Delimiters are used for separating statements
  token :Delimiter, [",", ".", ":"]

  # Comments
  token :Comment, "#", capture: "\n"

  # All types of strings
  token :String, ['"', "'"], quote: true

  # Binary operators used for maths and comparisons
  token :BinaryOperator, [
    '+', '-',
    '**', '*',
    '%', '/',
    '>=', '>',
    '<=', '<',
    '==', '!=',
  ]

  # Unary operators, used for negation
  token :UnaryOperator, '!'

  # Used for certain primitives, like lists and hashes
  token :Bracket, [
    "(", ")",
    "[", "]",
    "{", "}",
  ]
end
