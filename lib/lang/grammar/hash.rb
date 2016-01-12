module Lang::Grammar
  class Hash < ExpressionList
    def initialize
      super(open_bracket: '{',
            close_bracket: '}')
    end

    def parse(stream)
      Lang::Node::Hash.new(super(stream))
    end

    private

    def parse_element(stream)
      key = parse_key(stream)

      # The key must be preceded immediately by a colon
      match!(stream, Lang::Token::Delimiter, value: ':') && stream.advance

      # And no whitespace shall intersect the value from the key
      val = parse_val(stream)

      [key, val]
    end

    def parse_key(stream)
      match!(stream, Lang::Token::Identifier)
      stream.advance.first
    end

    def parse_val(stream)
      parse_expression(stream)
    end
  end
end
