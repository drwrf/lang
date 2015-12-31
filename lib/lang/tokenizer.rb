class Lang::Tokenizer
  TOKENS = [
    Lang::Token::Indent.new,
    Lang::Token::Comment.new,
    Lang::Token::Identifier.new,
    Lang::Token::Operator.new,
    Lang::Token::String.new,
    Lang::Token::Number.new,
    Lang::Token::Bracket.new,
    Lang::Token::Delimiter.new,
  ]

  def initialize(stream)
    @stream = Lang::TextStream.new(stream)
    @tokens = nil
  end

  def tokens
    if @tokens
      return @tokens
    end

    tokens = []

    while !@stream.eof? do
      token = TOKENS.find do |t|
        t.parseable?(@stream)
      end

      if token
        tokens.push(token.parse(@stream))
        next
      end

      # Ignorable whitespace
      if @stream.match?(/\s/)
        @stream.advance
        next
      end

      raise RuntimeError.new("Invalid token: \"#{@stream.char}\" " +
                             "at line #{@stream.line}, column #{@stream.column}")
    end

    @tokens = Lang::TokenStream.new(tokens)
  end
end
