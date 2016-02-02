module Lang::Grammar
  class BinaryOperator < Base
    def parseable?(stream)
      match(stream, Lang::Token::BinaryOperator)
    end

    def parse(stream, left)
      operator = stream.advance.first
      right = parse_expression(stream)

      Lang::Node::Call.new(operator, Lang::Node::Arguments.new([
        left, right
      ]))
    end
  end
end
