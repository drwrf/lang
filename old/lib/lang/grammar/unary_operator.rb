module Lang::Grammar
  class UnaryOperator < Base
    def parseable?(stream)
      match(stream, Lang::Token::UnaryOperator, value: '!')
    end

    def parse(stream)
      operator = stream.advance
      operand = parse_expression(stream)

      Lang::Node::Call.new(operator, Lang::Node::Arguments.new([operand]))
    end
  end
end
