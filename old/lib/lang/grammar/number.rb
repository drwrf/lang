module Lang::Grammar
  class Number < Base
    NUMBER = /[0-9]+/

    def parseable?(stream)
      match(stream, Lang::Token::Identifier, value: NUMBER)
    end

    def parse(stream)
      integer = stream.advance
      delimiter = nil
      fraction = nil

      if is_fractional?(stream)
        delimiter = stream.advance
        fraction = stream.advance
      end

      Lang::Node::Number.new(integer, fraction: fraction,
                                      delimiter: delimiter)
    end

    private

    def is_fractional?(stream)
      match_all(stream, {
        Lang::Token::Delimiter => '.',
        Lang::Token::Identifier => NUMBER
      })
    end
  end
end
