class Lang::Token
  def initialize(token, line, col)
    @token = token
    @line = line
    @col = col
  end

  class Base
    attr_reader :loc

    def self.match?(stream)
      stream.match?(self::MATCH)
    end

    def consume(stream)
      raise NotImplementedError
    end
  end
end
