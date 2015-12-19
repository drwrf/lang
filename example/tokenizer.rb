require 'pp'
require File.expand_path('../../lib/lang', __FILE__)

tokenizer = Lang::Tokenizer.new(<<eos
# You can define variables...
var year: 2015
var month: 'December'

# And immutable variables...
val version: 0.1

# There are all the basic operators...
1 > 0
1 < 2
2 >= 2
3 <= 3
42 == 42
(2 + 2) != 5

# Multi-line strings work
val multi-line-string: "
  This is a great string!
"

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
)

pp tokenizer.tokens
