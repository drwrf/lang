class Lang::Token
  class Operator < Base
    MATCH = ['+', '-', '>', '<']

    def consume(stream)
      stream.advance
    end
  end
end
