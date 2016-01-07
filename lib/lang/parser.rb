class Lang::Parser
  TYPES = []

  def initialize(types: nil)
    @types = types
  end

  def parse(stream)
    stream
  end

  private

  def types
    @types ||= Types.map(&:new)
  end
end
