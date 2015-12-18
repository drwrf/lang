class Lang::Token
  class Comment < Base
    MATCH = "#"

    def consume(stream)
      @token = stream.until("\n")
      stream.advance
    end
  end
end
