class Lang::Parser
  TYPES = [
    Lang::Node::Number
  ]

  def initialize(types: nil)
    @types = types
  end

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
