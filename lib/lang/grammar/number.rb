module Lang::Grammar
  class Number < Base
    def parseable?(stream)
      matches_type?(stream, Lang::Token::Number)
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
      matches_type?(stream, [Lang::Token::Delimiter,
                             Lang::Token::Number]) &&
      stream.next.value == '.'
    end
  end
end
