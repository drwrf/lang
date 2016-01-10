module Lang::Grammar
  class ExpressionList < Base
    def initialize(open_bracket:, close_bracket:, delimiter: ',')
      @open_bracket = open_bracket
      @close_bracket = close_bracket
      @delimiter = delimiter
    end

    def parseable?(stream)
      match(stream, Lang::Token::Bracket, value: @open_bracket)
    end

    def parse(stream)
      list = []

      # Skip over the opening bracket
      stream.advance

      while !match(stream, Lang::Token::Bracket, value: @close_bracket) do
        discard_whitespace(stream)
        list.push(parse_element(stream))
        discard_whitespace(stream)
      end

      # And skip over the closing bracket.
      stream.advance
      list
    end

    private

    def parse_element(stream)
      element = parse_expression(stream)

      # Ensure that there is either a trailing comma or this is the
      # end of the argument list before adding another expression
      if match(stream, Lang::Token::Delimiter, value: @delimiter)
        stream.advance
      else
        discard_whitespace(stream)
        match!(stream, Lang::Token::Bracket, value: @close_bracket)
      end

      element
    end
  end
end
