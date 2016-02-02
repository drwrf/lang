module Lang::Grammar
  class Array < ExpressionList
    def initialize
      super(open_bracket: '[', close_bracket: ']')
    end

    def parse(stream)
      Lang::Node::Array.new(super(stream))
    end
  end
end
