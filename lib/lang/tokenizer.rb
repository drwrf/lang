class Lang::Tokenizer
  TYPES = [
    Lang::Token::Indent,
    Lang::Token::Comment,
    Lang::Token::Identifier,
    Lang::Token::Operator,
    Lang::Token::String,
    Lang::Token::Number,
    Lang::Token::Bracket,
    Lang::Token::Delimiter,
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
      cls = TYPES.find do |type|
        type.match?(@stream)
      end

      if cls
        tokens.push(cls.new(@stream))
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
