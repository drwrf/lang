module Lang::Grammar
  class String < Base
    def parseable?(stream)
      matches_type?(stream, Lang::Token::String)
    end

    def parse(stream)
      Lang::Node::String.new(stream.advance)
    end
  end
end
