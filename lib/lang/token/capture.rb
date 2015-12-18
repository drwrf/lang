class Lang::Token
  class Capture < Base
    MATCH = [
      '(', ']',
      '{', '}',
      '[', ')',
      ',', ':',
    ]

    def consume(stream)
      @token = stream.advance
    end
  end
end
