module Lang::Grammar
  class Base
    def parseable?(stream)
      raise NotImplementedError
    end

    def parse(stream)
      raise NotImplementedError
    end

    private

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

    def expect!(stream, type: nil, value: nil)
      token = stream.next

      if !token
        raise RuntimeError
      end

      if type
        raise RuntimeError if !token.is_a? type
      end

      if value
        raise RuntimeError if token.value != value
      end
    end
  end
end
