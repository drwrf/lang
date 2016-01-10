module Lang::Grammar
  class Base
    def parseable?(stream)
      raise NotImplementedError
    end

    def parse(stream)
      raise NotImplementedError
    end

    private

    def parse_expression(stream)
      @expr ||= Lang::Grammar::Expression.new
      @expr.parse(stream)
    end

    def expect(stream, type, value: nil)
      token = stream.next

      if token.is_type?(type) && (!value || token.value == value)
        token
      else
        false
      end
    end

    def expect!(stream, type, value: nil)
      if expect(type, value: value) == false
        raise RuntimeError
      end

      true
    end

    def matches_type?(stream, tests)
      tests = [*tests]
      tokens = stream.peek(tests.length)

      if !tokens
        return false
      end

      tests.each_with_index do |test, i|
        if !tokens[i].is_type?(test)
          return false
        end
      end

      tokens
    end
  end
end
