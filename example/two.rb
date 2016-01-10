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

# Function calls
print('Hello',
      'World')

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
eos
)
