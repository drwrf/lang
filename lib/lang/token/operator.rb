class Lang::Token
  class Operator < Base
    MATCH = ['+', '-', '>', '<']

    def consume(stream)
      @token = stream.advance
    end
  end
end
