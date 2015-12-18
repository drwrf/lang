class Lang::Token
  class Newline < Base
    MATCH = "\n"

    def consume(stream)
      @token = stream.advance
    end
  end
end
