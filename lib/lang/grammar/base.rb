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

      true
    end
  end
end
