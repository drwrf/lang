class Lang::Token
  class Newline < Base
    MATCH = "\n"

    def consume(stream)
      stream.advance
    end
  end
end
