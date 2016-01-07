class Lang::Node
  class Number
    def initialize(integer, fraction: nil, delimiter: nil)
      @integer = integer
      @fraction = fraction
      @delimiter = delimiter
    end
  end
end
