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

  # Operators are used for maths...
  token :Operator, [
    '+', '-',
    '>=', '>',
    '<=', '<',
    '==', '!=',
    '!',
  ]

  # Used for certain primitives, like lists and hashes
  token :Bracket, [
    "(", ")",
    "[", "]",
    "{", "}",
  ]
end
