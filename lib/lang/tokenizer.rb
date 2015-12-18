class Lang::Tokenizer
  def initialize(stream)
    @stream = Lang::Stream.new(stream)
    @tokens = []
    @line = 1
    @col = 1
  end

  def tokens
    if @tokens.any?
      return @tokens
    end

    while !@stream.eof? do
      # Newline
      if @stream.match?("\n")
        push_token(@stream.char)
        @stream.advance
        next
      end

      # Comment
      if @stream.match?("#")
        push_token(@stream.until("\n"))
        @stream.advance
        next
      end

      # Identifier
      if @stream.match?(/[a-zA-Z]/)
        push_token(@stream.until(/[\s:,\(\[\{\]\}\)]/))
        @stream.advance
        next
      end

      # Operators
      if @stream.match?(['+', '-', '>', '<'])
        push_token(@stream.char)
        @stream.advance
        next
      end

      # Strings
      if @stream.match?(/['|"]/)
        push_token(@stream.until(@stream.char, inclusive: true))
        @stream.advance
        next
      end

      # Numbers
      if @stream.match?(/[0-9]/)
        push_token(@stream.until(/[^0-9.]/))
        @stream.advance
        next
      end

      # Assignment
      if @stream.match?(":")
        push_token(@stream.char)
        @stream.advance
        next
      end

      # Array and object captures
      if @stream.match?(['(', '{', '[', ']', '}', ')', ','])
        push_token(@stream.char)
        @stream.advance
        next
      end

      # Ignorable whitespace
      if @stream.match?(/\s/)
        @col += 1
        @stream.advance
        next
      end
    end

    @tokens
  end

  private

  def push_token(text)
    @tokens.push(make_token(text))
  end

  def make_token(text)
    token = Lang::Token.new(text, @line, @col)

    if text == "\n"
      @line += 1
      @col = 1
    else
      @col += text.length
    end

    token
  end
end
