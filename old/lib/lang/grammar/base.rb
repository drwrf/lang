module Lang::Grammar
  class Base
    def parseable?(stream)
      raise NotImplementedError
    end

    def parse(stream)
      raise NotImplementedError
    end

    private

    def expr
      @expr ||= Lang::Grammar::Expression.new
    end

    def parse_expression(stream)
      expr.parse(stream)
    end

    def discard_whitespace(stream)
      # Eat any whitespace or comments until the next
      discard_tokens(stream, [
        Lang::Token::Indent,
        Lang::Token::Comment
      ])
    end

    def discard_tokens(stream, types)
      loop do
        types.each do |type, value|
          if match(stream, type, value: value)
            stream.advance
            next
          end

          return
        end
      end
    end

    def match(stream, type, value: nil, offset: 0)
      token = stream.peek(offset: offset)

      if !token
        return false
      end

      token = token.first

      if !token || !token.is_type?(type)
        return false
      end

      if value && value.is_a?(::String) && value != token.value
        return false
      end

      if value && value.is_a?(::Regexp) && !(value =~ token.value)
        return false
      end

      token
    end

    def match!(stream, type, value: nil)
      token = match(stream, type, value: value)

      if !token
        raise RuntimeError
      end

      token
    end

    def match_all(stream, types)
      tokens = []
      offset = 0

      types.each do |type, value|
        token = match(stream, type, value: value, offset: offset)
        offset += 1

        if token
          tokens.push(token)
        else
          return false
        end
      end

      tokens
    end
  end
end
