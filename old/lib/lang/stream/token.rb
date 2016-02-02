class Lang::TokenStream
  def initialize(input)
    @input = input
    @offset = 0
  end

  def loop
    while !eof?
      yield
    end

    reset
  end

  def peek(amount = 1, offset: 0)
    offset = @offset + offset

    if offset + amount <= @input.length
      @input.slice(offset, amount)
    end
  end

  def advance(amount = 1)
    tokens = []

    amount.times do
      token = self.peek

      if !token
        raise RuntimeError
      end

      @offset += 1
      tokens += token
    end

    tokens
  end

  private

  def reset
    @offset = 0
  end

  def eof?
    @offset >= @input.length
  end
end
