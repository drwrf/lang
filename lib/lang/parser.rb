class Lang::Parser
  def parse(stream)
    nodes = []

    stream.loop do
      if expr.parseable?(stream)
        nodes.push(expr.parse(stream))
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

  def expr
    @expr ||= Lang::Grammar::Expression.new
  end
end
