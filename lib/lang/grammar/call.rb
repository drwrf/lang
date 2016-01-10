module Lang::Grammar
  class Call < Base
    def parseable?(stream)
      match_all(stream, {
        Lang::Token::Identifier => nil,
        Lang::Token::Bracket => '(',
      })
    end

    def parse(stream)
      method = stream.advance
      args = []

      # Skip past the opening parentheses
      stream.advance

      while !match(stream, Lang::Token::Bracket, value: ')')
        args.push(parse_argument(stream))
      end

      match!(stream, Lang::Token::Bracket, value: ')') && stream.advance

      Lang::Node::Call.new(method, args)
    end

    private

    def parse_argument(stream)
      arg = parse_expression(stream)

      # Ensure that there is either a comma or this is the
      # end of the argument list before adding another expression
      if match(stream, Lang::Token::Delimiter, value: ',')
        stream.advance
      else
        match!(stream, Lang::Token::Bracket, value: ')')
      end

      arg
    end
  end
end
