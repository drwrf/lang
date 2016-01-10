module Lang::Grammar
  class Array < Base
    def parseable?(stream)
      match(stream, Lang::Token::Bracket, value: '[')
    end

    def parse(stream)
      elements = []

      # Skip past the opening bracket
      stream.advance

      while !match(stream, Lang::Token::Bracket, value: ']') do
        # Whitespace is not significant inside arrays, so they are ignored
        if match(stream, Lang::Token::Indent)
          stream.advance
          next
        end

        elements.push(parse_element(stream))
      end

      match!(stream, Lang::Token::Bracket, value: ']') && stream.advance

      Lang::Node::Array.new(elements)
    end

    private

    def parse_element(stream)
      element = parse_expression(stream)

      # Trailing commas are required at this point
      match!(stream, Lang::Token::Delimiter, value: ',') && stream.advance

      element
    end
  end
end
