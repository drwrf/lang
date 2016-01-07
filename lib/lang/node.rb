class Lang::Node
  def parseable?(stream)
    raise NotImplementedError
  end

  def parse(stream)
    raise NotImplementedError
  end

  class Number
    def parseable?(stream)

    end

    def parse(stream)

    end
  end
end
