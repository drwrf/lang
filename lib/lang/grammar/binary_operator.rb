module Lang::Grammar
  class BinaryOperator < Base
    def parseable?(stream)
      match(stream, Lang::Token::BinaryOperator)
    end

    def parse(stream, left)
      operator = stream.advance.first
      right = parse_expression(stream)

      if is_math?(operator)
        Lang::Node::Math.new(operator, left, right)
      elsif is_comparison?(operator)
        Lang::Node::Comparison.new(operator, left, right)
      else
        raise RuntimeError
      end
    end

    private

    def is_math?(operator)
      ['+', '-', '**', '*', '%', '/'].include?(operator.value)
    end

    def is_comparison?(operator)
      ['>=', '>', '<=', '<', '==', '!='].include?(operator.value)
    end
  end
end
