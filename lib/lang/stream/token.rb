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

  def next
    peek.first
  end

  def peek(amount = 1)
    if @offset + amount <= @input.length
      @input.slice(@offset, amount)
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

  def expect(type, value: nil)
    token = self.next

    if token.is_type?(type) && (!value || token.value == value)
      token
    else
      false
    end
  end

  def expect!(type, value: nil)
    raise RuntimeError if expect(type, value: value) == false
  end

  private

  def reset
    @offset = 0
  end

  def eof?
    @offset >= @input.length
  end
end
