require 'pp'
require File.expand_path('../../lib/lang', __FILE__)

tokenizer = Lang::Tokenizer.new
program = <<eos
# You can define variables...
var year: 2015
var month: 'December'

# And immutable variables...
val version: 0.1

# And strings...
val hello: "world!"
val haiku: "From time to time
            the clouds give rest
            to the moon-beholders."

# There are all the basic operators...
1 > 0
1 < 2
2 >= 2
3 <= 3
42 == 42
(2 + 2) != 5

# There are booleans (but no nil)...
true  != false
false != true

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

pp tokenizer.tokenize(program)
