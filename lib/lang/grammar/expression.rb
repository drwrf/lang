module Lang::Grammar
  class Expression < Base
    TYPES = [
      Lang::Grammar::UnaryOperator,
      Lang::Grammar::Number,
      Lang::Grammar::String,
      Lang::Grammar::Array,
      Lang::Grammar::Call,
    ]

    def parseable?(stream)
      true
    end

    def parse(stream)
      delimited = match(stream, Lang::Token::Bracket, value: '(')

      if delimited
        stream.advance
        discard_whitespace(stream)
      end

      node = types.find do |n|
        n.parseable?(stream)
      end

      expression = node.parse(stream) if node

      if delimited
        match!(stream, Lang::Token::Bracket, value: ')')
        stream.advance
        discard_whitespace(stream)
      end

      expression
    end

    private

    def types
      @types ||= TYPES.map(&:new)
    end
  end
end
