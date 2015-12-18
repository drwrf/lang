class Lang::Token
  class String < Base
    MATCH = ["'", '"']

    def consume(stream)
      @token = stream.until(stream.char, inclusive: true)
      stream.advance
    end
  end
end
