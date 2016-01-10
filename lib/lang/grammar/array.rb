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
        discard_whitespace(stream)
        elements.push(parse_element(stream))
        discard_whitespace(stream)
      end

      match!(stream, Lang::Token::Bracket, value: ']') && stream.advance

      Lang::Node::Array.new(elements)
    end

    private

    def parse_element(stream)
      element = parse_expression(stream)

      # Ensure that there is either a trailing comma or this is the
      # end of the argument list before adding another expression
      if match(stream, Lang::Token::Delimiter, value: ',')
        stream.advance
      else
        discard_whitespace(stream)
        match!(stream, Lang::Token::Bracket, value: ']')
      end

      element
    end

  end
end
