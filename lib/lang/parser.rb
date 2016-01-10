class Lang::Parser
  TYPES = [
    Lang::Grammar::UnaryOperator,
    Lang::Grammar::Number,
    Lang::Grammar::String,
    Lang::Grammar::Array,
    Lang::Grammar::Call
  ]

  def parse(stream)
    nodes = []

    stream.loop do
      node = types.find do |n|
        n.parseable?(stream)
      end

      if node
        nodes.push(node.parse(stream))
        next
      end

      # Ignore comment tokens
      if stream.peek && stream.peek.first.is_type?(Lang::Token::Comment)
        stream.advance
        next
      end

      # For now, just advance through unknown nodes
      stream.advance
    end

    nodes
  end

  private

  def types
    @types ||= TYPES.map(&:new)
  end
end
