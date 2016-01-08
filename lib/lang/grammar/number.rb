module Lang::Grammar
  class Number < Base
    def parseable?(stream)
      matches_type?(stream, Lang::Token::Identifier) && is_number?(stream.next.value)
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
      return false if !matches_type?(stream, [Lang::Token::Delimiter,
                                              Lang::Token::Identifier])

      parts = stream.peek(2)
      parts[0].value == '.' && is_number?(parts[1].value)
    end

    def is_number?(value)
      value =~ /[0-9]+/
    end
  end
end
