class Lang::TextStream
  attr_reader :line, :column

  def initialize(input)
    @input = input.chars.to_a
    reset
  end

  def location
    [@line, @column]
  end

  def loop
    while !eof?
      yield
    end

    reset
  end

  def peek(amount: 1)
    if @offset + amount <= @input.length
      @input.slice(@offset, amount).join
    end
  end

  def advance(amount: 1)
    result = self.peek(amount: amount)

    if !result
      raise RuntimeError
    end

    @offset += amount

    if result == "\n"
      @line += 1
      @column = 1
    else
      @column += amount
    end

    result
  end

  private

  def reset
    @offset = 0
    @line = 1
    @column = 1
  end

  def eof?
    @offset >= @input.length
  end
end
