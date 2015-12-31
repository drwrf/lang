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

  def initialize(types: nil)
    @types = types
  end

  def tokenize(stream)
    if stream.is_a? ::String
      stream = Lang::TextStream.new(stream)
    end

    tokens = []

    stream.loop do
      token = types.find do |t|
        t.parseable?(stream)
      end

      if token
        tokens.push(token.parse(stream))
        next
      end

      # Ignorable whitespace
      if !!(stream.peek =~ /\s/)
        stream.advance
        next
      end

      raise RuntimeError.new("Invalid token: \"#{stream.peek}\" " +
                             "at line #{stream.line}, column #{stream.column}")
    end

    Lang::TokenStream.new(tokens)
  end

  private

  def types
    @types ||= TYPES.map(&:new)
  end
end
