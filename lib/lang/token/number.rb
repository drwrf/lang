class Lang::Token
  class Number < Base
    MATCH = /[0-9]/

    def consume(stream)
      @token = stream.until(/[^0-9.]/)
      stream.advance
    end
  end
end
