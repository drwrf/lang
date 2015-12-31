class Lang::Token
  class << self
    def define(&block)
      class_eval(&block)
    end

    def token(name, match, &block)
      cls = Class.new(self)
      cls.const_set('MATCH', match)
      cls.send(:define_method, :consume, &block) if block_given?
      const_set(name, cls)
    end
  end

  def parseable?(stream)
    match?(stream, self.class::MATCH)
  end

  def parse(stream)
    if !parseable?(stream)
      raise RuntimeError
    end

    start = stream.loc
    value = consume(stream)
    finish = stream.loc

    Lang::Lexeme.new(value, self, start, finish)
  end

  private

  def consume(stream)
    match = self.class::MATCH

    if match.is_a? ::String
      stream.advance(amount: match.length)
    elsif match.is_a? ::Array
      stream.advance(amount: match.find {|t| match?(stream, t) }.length)
    else
      raise NotImplementedError
    end
  end

  def match?(stream, test)
    if test.is_a? ::String
      stream.peek(amount: test.length) == test
    elsif test.is_a? ::Array
      !!(test.find {|t| match?(stream, t) })
    else
      !!(stream.peek =~ test)
    end
  end
end
