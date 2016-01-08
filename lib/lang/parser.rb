class Lang::Parser
  TYPES = [
    Lang::Grammar::Number,
    Lang::Grammar::String
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
      if stream.next.is_type?(Lang::Token::Comment)
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
