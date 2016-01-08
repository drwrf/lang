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
eos
)
