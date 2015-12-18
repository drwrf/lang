class Lang::Token
  class Identifier < Base
    MATCH = /[a-zA-Z]/

    def consume(stream)
      @token = stream.until(/[\s:,\(\[\{\]\}\)]/)
      stream.advance
    end
  end
end
