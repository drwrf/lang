module Lang::Grammar
  class Expression < Base
    def parseable?(stream)
      # All expressions must start with one
      # of the basic types of expressions.
      simple_types.each do |type|
        if type.parseable?(stream)
          return true
        end
      end

      false
    end

    def parse(stream)
      delimited = match(stream, Lang::Token::Bracket, value: '(')

      if delimited
        stream.advance
        discard_whitespace(stream)
      end

      type = simple_types.find do |t|
        t.parseable?(stream)
      end

      if type
        expression = type.parse(stream)
      else
        raise RuntimeError
      end

      type = compound_types.find do |t|
        t.parseable?(stream)
      end

      if type
        expression = type.parse(stream, expression)
      end

      if delimited
        match!(stream, Lang::Token::Bracket, value: ')')
        stream.advance
        discard_whitespace(stream)
      end

      expression
    end

    private

    def simple_types
      @simple_types ||= [
        Lang::Grammar::UnaryOperator,
        Lang::Grammar::Number,
        Lang::Grammar::String,
        Lang::Grammar::Array,
        Lang::Grammar::Hash,
        Lang::Grammar::Call,
      ].map(&:new)
    end

    def compound_types
      @compound_types ||= [
        Lang::Grammar::BinaryOperator,
      ].map(&:new)
    end
  end
end
