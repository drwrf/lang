class Lang::Token
  class << self
    def define(&block)
      class_eval(&block)
    end

    def token(name, start, capture: nil, quote: false, &block)
      cls = Class.new(self)
      cls.const_set('START', start)
      cls.const_set('CAPTURE', capture)
      cls.const_set('QUOTE', quote)

      const_set(name, cls)
    end
  end

  def parseable?(stream)
    match?(stream, start)
  end

  def parse(stream)
    if !parseable?(stream)
      raise RuntimeError
    end

    start = stream.location
    value = consume(stream)
    finish = stream.location

    Lang::Lexeme.new(value, self, start, finish)
  end

  private

  def consume(stream)
    chars = ''

    if start.is_a? ::String
      chars += advance(stream, start.length)
    elsif start.is_a? ::Array
      chars += advance(stream, start.find {|t| match?(stream, t) }.length)
    elsif start.is_a? ::Regexp
      chars += advance(stream, 1)
    else
      raise NotImplementedError
    end

    # Match everything until a match is made
    if capture
      chars += advance_until(stream, capture)
    # Match everything inside the delimiters
    elsif quote?
      quote = chars
      chars = advance_until(stream, chars)
      advance(stream, quote.length)
    end

    chars
  end

  def match?(stream, test)
    if test.is_a? ::String
      stream.peek(test.length) == test
    elsif test.is_a? ::Array
      !!(test.find {|t| match?(stream, t) })
    else
      !!(stream.peek =~ test)
    end
  end

  def advance(stream, amount)
    stream.advance(amount)
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

  def start
    self.class::START
  end

  def capture
    self.class::CAPTURE
  end

  def quote?
    self.class::QUOTE
  end
end
