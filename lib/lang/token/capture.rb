class Lang::Token
  class Capture < Base
    MATCH = [
      '(', ']',
      '{', '}',
      '[', ')',
      ',', ':',
    ]

    def consume(stream)
      stream.advance
    end
  end
end
