require 'bundler/setup'
Bundler.setup

require 'lang'
require 'token/shared_examples'

module Helpers
  def tokenize(string)
    Lang::Tokenizer.new(string).tokens
  end
end

RSpec.configure do |c|
  c.include Helpers
end
