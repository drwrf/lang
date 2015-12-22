class Lang::Token
  token :Newline, "\n"

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
  token :String, ['"', "'"] do
    def consume(stream)
      stream.until(stream.char, inclusive: true)
    end
  end

  token :Number, /[0-9]/ do
    def consume(stream)
      stream.until(/[^0-9.]/)
    end
  end

  token :Comment, "#" do
    def consume(stream)
      stream.until("\n")
    end
  end

  token :Identifier, /[a-zA-Z]/ do
    def consume(stream)
      stream.until(/[\s:,\(\[\{\]\}\)]/)
    end
  end
end
