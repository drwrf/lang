class Lang::Token
  class Number < Base
    MATCH = /[0-9]/

    def consume(stream)
      stream.until(/[^0-9.]/)
    end
  end
end
