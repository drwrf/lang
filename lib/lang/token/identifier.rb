class Lang::Token
  class Identifier < Base
    MATCH = /[a-zA-Z]/

    def consume(stream)
      stream.until(/[\s:,\(\[\{\]\}\)]/)
    end
  end
end
