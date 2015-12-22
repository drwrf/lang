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
    @stream = Lang::Stream.new(stream)
    @tokens = []
  end

  def tokens
    if @tokens.any?
      return @tokens
    end

    while !@stream.eof? do
      cls = TYPES.find do |type|
        type.match?(@stream)
      end

      if cls
        push_token(cls.new(@stream))
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

    @tokens
  end

  private

  def push_token(token)
    @tokens.push(token)
  end
end
