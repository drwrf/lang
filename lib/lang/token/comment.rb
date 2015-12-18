class Lang::Token
  class Comment < Base
    MATCH = "#"

    def consume(stream)
      stream.until("\n")
    end
  end
end
