class Lang::Environment
  attr_reader :tokenizer, :parser

  def initialize
    @tokenizer = Lang::Tokenizer.new
    @parser = Lang::Parser.new
  end

  def tokenize(string)
    tokenizer.tokenize(Lang::TextStream.new(string))
  end

  def parse(string)
    parser.parse(tokenize(string))
  end
end
