require 'pp'
require File.expand_path('../../lib/lang', __FILE__)

tokenizer = Lang::Tokenizer.new(%{
# This is a comment
# And so is this!
var single-quote-str: 'This is really great!'
var double-quote-str: "This is really great!"
val integer: 100000
val float: 3.141529 # TODO: Fix floats
})

pp tokenizer.tokens
