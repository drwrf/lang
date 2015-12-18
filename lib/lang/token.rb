class Lang::Token
  def initialize(token, line, col)
    @token = token
    @line = line
    @col = col
  end

  class Base
    attr_reader :start, :end

    def self.match?(stream)
      stream.match?(self::MATCH)
    end

    def initialize(stream)
      @start = stream.loc
      @token = consume(stream)
      @end = stream.loc
    end

    private

    def consume(stream)
      raise NotImplementedError
    end
  end
end
