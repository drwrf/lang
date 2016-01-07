class Lang::Environment
  attr_reader :tokenizer

  def initialize
    @tokenizer = Lang::Tokenizer.new
  end

  def tokenize(string)
    tokenizer.tokenize(Lang::TextStream.new(string))
  end
end
