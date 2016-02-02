require 'bundler/setup'
Bundler.setup

require 'lang'
require 'token/shared_examples'

module Helpers
  def tokenize(string)
    Lang::Tokenizer.new.tokenize(string)
  end

  def tokenizer
    Lang::Tokenizer.new
  end
end

RSpec.configure do |c|
  c.include Helpers
end
