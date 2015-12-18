class Lang::Tokenizer
  TYPES = [
    Lang::Token::Newline,
    Lang::Token::Comment,
    Lang::Token::Identifier,
    Lang::Token::Operator,
    Lang::Token::String,
    Lang::Token::Number,
    Lang::Token::Capture,
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
        token = cls.new
        token.consume(@stream)
        push_token(token)
        next
      end

      # Ignorable whitespace
      if @stream.match?(/\s/)
        @stream.advance
        next
      end
    end

    @tokens
  end

  private

  def push_token(token)
    @tokens.push(token)
  end
end
