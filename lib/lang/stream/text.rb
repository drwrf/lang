class Lang::TextStream
  attr_reader :line, :column

  def initialize(input)
    @input = input.chars.to_a
    @offset = 0
    @line = 1
    @column = 1
  end

  def eof?
    @offset >= @input.length
  end

  def match?(test)
    if test.is_a? String
      self.peek(amount: test.length) == test
    elsif test.is_a? Array
      !!(test.find {|t| self.match?(t) })
    else
      !!(self.char =~ test)
    end
  end

  def char
    @input[@offset]
  end

  def peek(amount: 1)
    @input.slice(@offset, amount).join
  end

  def advance(amount: 1)
    result = self.peek(amount: amount)

    @offset += amount

    if result == "\n"
      @line += 1
      @column = 1
    else
      @column += amount
    end

    result
  end

  def until(test)
    chars = ''

    loop do
      chars += self.advance

      if self.match?(test)
        break
      end
    end

    chars
  end

  def loc
    [@line, @column]
  end
end
