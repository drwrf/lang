class Lang::Token
  class << self
    def define(&block)
      class_eval(&block)
    end

    def token(name, match, up_to: nil, capture: false, &block)
      cls = Class.new(self)
      cls.const_set('MATCH', match)
      cls.const_set('UP_TO', up_to)
      cls.const_set('CAPTURE', capture)

      if block_given?
        cls.send(:define_method, :consume, &block)
      end

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
    chars = ''

    if match.is_a? ::String
      chars += advance(stream, match.length)
    elsif match.is_a? ::Array
      chars += advance(stream, match.find {|t| match?(stream, t) }.length)
    elsif match.is_a? ::Regexp
      chars += advance(stream, 1)
    else
      raise NotImplementedError
    end

    # Match everything until a match is made
    if self.class::UP_TO
      chars += advance_until(stream, self.class::UP_TO)
    # Match everything inside the delimiters
    elsif self.class::CAPTURE
      capture = chars
      chars = advance_until(stream, chars)
      advance(stream, capture.length)
    end

    chars
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

  def advance(stream, amount)
    stream.advance(amount: amount)
  end

  def advance_until(stream, test)
    chars = ''

    loop do
      if stream.peek.nil? || match?(stream, test)
        break
      end

      chars += stream.advance
    end

    chars
  end
end
