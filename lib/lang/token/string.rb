class Lang::Token
  class String < Base
    MATCH = ["'", '"']

    def consume(stream)
      stream.until(stream.char, inclusive: true)
    end
  end
end
