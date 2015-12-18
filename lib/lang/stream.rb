class Lang::Stream
  def initialize(input)
    @input = input.chars.to_a
    @offset = 0
  end

  def eof?
    @offset >= @input.length
  end

  def match?(test)
    if test.is_a? String
      self.char == test
    elsif test.is_a? Array
      test.include? self.char
    else
      !!(self.char =~ test)
    end
  end

  def advance
    result = @input[@offset]
    @offset += 1
    result
  end

  def char
    @input[@offset]
  end

  def until(test, inclusive: false)
    chars = self.advance

    while !self.match?(test) && self.char
      chars += char
      advance
    end

    if inclusive
      chars += char
      advance
    end

    @offset -= 1

    chars
  end
end
