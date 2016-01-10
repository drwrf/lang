module Lang::Grammar
  class Expression < Base
    TYPES = [
      Lang::Grammar::Number,
      Lang::Grammar::String,
    ]

    def parseable?(stream)
      true
    end

    def parse(stream)
      node = types.find do |n|
        n.parseable?(stream)
      end

      node.parse(stream) if node
    end

    private

    def types
      @types ||= TYPES.map(&:new)
    end
  end
end
