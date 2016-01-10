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
      args = parse_args(stream)

      Lang::Node::Call.new(method, args)
    end

    private

    def parse_args(stream)
      if args_parser.parseable?(stream)
        args_parser.parse(stream)
      end
    end

    def args_parser
      @args_parser ||= Lang::Grammar::ExpressionList.new(
        open_bracket: '(', close_bracket: ')')
    end
  end
end
