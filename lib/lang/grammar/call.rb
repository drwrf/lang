module Lang::Grammar
  class Call < Base
    def parseable?(stream)
      match_all(stream, {
        Lang::Token::Identifier => nil
      })
    end

    def parse(stream)
      method = stream.advance
      args = parse_args(stream)

      Lang::Node::Call.new(method, args)
    end

    private

    def parse_args(stream)
      if arguments.parseable?(stream)
        arguments.parse(stream)
      end
    end

    def arguments
      @arguments ||= Lang::Grammar::Arguments.new
    end
  end
end
