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
      block = parse_block(stream)

      Lang::Node::Call.new(method, args, block)
    end

    private

    def parse_args(stream)
      if arguments.parseable?(stream)
        arguments.parse(stream)
      end
    end

    def parse_block(stream)
      if block.parseable?(stream)
        block.parse(stream)
      end
    end

    def arguments
      @arguments ||= Lang::Grammar::Arguments.new
    end

    def block
      @block ||= Lang::Grammar::Block.new
    end
  end
end
