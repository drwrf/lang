Lang::Token.define do
  token :Indent, "\n" do |s|
    s.until(/[^ \t]/)
  end

  # Delimiters are used for separating statements
  token :Delimiter, [",", ".", ":"]

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

  # Complex tokens....
  token :String, ['"', "'"] do |s|
    quote = s.advance
    lexeme = s.until(quote)
    s.advance
    lexeme
  end

  token :Number, /[0-9]/ do |s|
    s.until(/[^0-9.]/)
  end

  token :Comment, "#" do |s|
    s.until("\n")
  end

  token :Identifier, /[a-zA-Z]/ do |s|
    s.until(/[\s:,\(\[\{\]\}\)]/)
  end
end
