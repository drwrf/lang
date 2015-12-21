class Lang::Token
  attr_reader :start, :end

  def self.token(name, match, &block)
    cls = Class.new(self, &block)
    cls.const_set('MATCH', match)
    const_set(name, cls)
  end

  def self.match?(stream)
    stream.match?(self::MATCH)
  end

  def initialize(stream)
    @start = stream.loc
    @lexeme = consume(stream)
    @end = stream.loc
  end

  private

  def consume(stream)
    match = self.class::MATCH

    if match.is_a? ::String
      stream.advance(amount: match.length)
    elsif match.is_a? ::Array
      stream.advance(amount: match.find {|t| stream.match?(t) }.length)
    else
      raise NotImplementedError
    end
  end
end
