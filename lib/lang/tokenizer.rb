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

  def initialize(stream, types: nil)
    @stream = Lang::TextStream.new(stream)
    @types = types
    @tokens = nil
  end

  def tokens
    if @tokens
      return @tokens
    end

    tokens = []

    while !stream.eof? do
      token = types.find do |t|
        t.parseable?(stream)
      end

      if token
        tokens.push(token.parse(stream))
        next
      end

      # Ignorable whitespace
      if stream.match?(/\s/)
        stream.advance
        next
      end

      raise RuntimeError.new("Invalid token: \"#{stream.char}\" " +
                             "at line #{stream.line}, column #{stream.column}")
    end

    @tokens = Lang::TokenStream.new(tokens)
  end

  private

  def types
    @types ||= TYPES.map(&:new)
  end

  def stream
    @stream
  end
end
