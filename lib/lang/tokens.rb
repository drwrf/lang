class Lang::Token
  # Basic tokens...
  token :Newline, "\n"
  token :Colon, ":"
  token :Comma, ","

  # Capture groups...
  token :OpenParenthesis,  "("
  token :CloseParenthesis, ")"
  token :OpenBracket,      "["
  token :CloseBracket,     "]"
  token :OpenBrace,        "{"
  token :CloseBrace,       "}"

  # Operators...
  token :Add,                '+'
  token :Subtract,           '-'
  token :GreaterThan,        '>'
  token :GreaterThanOrEqual, '>='
  token :LessThan,           '<'
  token :LessThanOrEqual,    '<='
  token :Equal,              '=='
  token :NotEqual,           '!='

  # Primitives...
  token :True, 'true'
  token :False, 'false'

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
