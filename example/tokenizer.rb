require 'pp'
require File.expand_path('../../lib/lang', __FILE__)

tokenizer = Lang::Tokenizer.new(<<eos
# You can define variables...
var year: 2015
var month: 'December'

# And immutable variables...
val version: 0.1

# Obviously there are booleans...
val true: true
val false: false

# Lists of items...
val list: [
  1, 2, 3
]

# Hashes of items...
val hash: {
  foo: 'foo',
  bar: 'bar',
  baz: 'baz',
}

# Define methods...
def add (number1, number2)
  number1 + number2

eos
)

pp tokenizer.tokens
