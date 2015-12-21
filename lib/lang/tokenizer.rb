class Lang::Tokenizer
  TYPES = [
    Lang::Token::Newline,
    Lang::Token::Comment,
    Lang::Token::Identifier,
    Lang::Token::Operator,
    Lang::Token::String,
    Lang::Token::Number,
    Lang::Token::OpenParenthesis,
    Lang::Token::CloseParenthesis,
    Lang::Token::OpenBracket,
    Lang::Token::CloseBracket,
    Lang::Token::OpenBrace,
    Lang::Token::CloseBrace,
    Lang::Token::Comma,
    Lang::Token::Colon,
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
