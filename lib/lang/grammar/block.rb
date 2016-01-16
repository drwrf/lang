module Lang::Grammar
  class Block < Base
    def parseable?(stream)
      match(stream, Lang::Token::Delimiter, value: ':')
    end

    def parse(stream)
      # Blocks can be kicked off by colons
      if match(stream, Lang::Token::Delimiter, value: ':')
        stream.advance
      end

      parse_expression(stream)
    end
  end
end
