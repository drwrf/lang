module Lang::Grammar
  class Arguments < Base
    def parseable?(stream)
      match(stream, Lang::Token::Bracket, value: '(') ||
        expr.parseable?(stream)
    end

    def parse(stream)
      delimited = match(stream, Lang::Token::Bracket, value: '(')

      # Get rid of the opening bracket and short-circuit on
      # an immediately closed argument list.
      if delimited
        stream.advance
      end

      arguments = parse_arguments(stream, delimited)

      if delimited
        discard_whitespace(stream)
        match!(stream, Lang::Token::Bracket, value: ')')
        stream.advance
      end

      Lang::Node::Arguments.new(arguments)
    end

    private

    def parse_arguments(stream, delimited)
      arguments = []

      # Short-circuit if there are parens but no args
      if delimited && match(stream, Lang::Token::Bracket, value: ')')
        return arguments
      end

      loop do
        if delimited
          discard_whitespace(stream)
        end

        arguments.push(expr.parse(stream))

        # Comma detected, so move on to the next argument
        if match(stream, Lang::Token::Delimiter, value: ',')
          stream.advance
          next
        end

        # If we've made it here there are no more
        # arguments to parse, so return what we found.
        break
      end

      arguments
    end
  end
end
