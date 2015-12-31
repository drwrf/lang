Lang::Token.define do
  # Used for identifying blocks
  token :Indent, "\n", up_to: /[^ \t]/

  # Identifiers, for naming variables, methods, etc
  token :Identifier, /[a-zA-Z]/, up_to: /[\s:,\(\[\{\]\}\)]/

  # Delimiters are used for separating statements
  token :Delimiter, [",", ".", ":"]

  # Comments
  token :Comment, "#", up_to: "\n"

  # Integers and floats, TODO: make distinct
  token :Number, /[0-9]/, up_to: /[^0-9.]/

  # All types of strings
  token :String, ['"', "'"], capture: true

  # Operators are used for maths...
  token :Operator, [
    '+', '-',
    '>=', '>',
    '<=', '<',
    '==', '!=',
  ]

  # Used for certain primitives, like lists and hashes
  token :Bracket, [
    "(", ")",
    "[", "]",
    "{", "}",
  ]
end
