module Lang::Grammar
  class Arguments < ExpressionList
    def initialize
      super open_bracket: '(',
            close_bracket: ')'
    end

    def parse(stream)
      Lang::Node::Arguments.new(super(stream))
    end
  end
end
