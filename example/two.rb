require 'pp'
require File.expand_path('../../lib/lang', __FILE__)

pp Lang::Environment.new.parse(<<eos
# Integers
1

# Floats
1.1

# Double quoted strings
"String!"

# Single quoted strings
'String!'

# Arrays
[
  'test',
  1,
  [
    call('test')
  ]
]

# Delimited expressions
('test')

# Negated expressions
!(!'test')

# Maths
1 / 1 + 1 - 1 * 1 ** 1 % 1

# Comparisons
1 == 1
eos
)
