class Lang::TokenStream
  def initialize(tokens)
    @tokens = tokens
    @offset = 0
  end

  def next
    @tokens[@offset]
  end
end
