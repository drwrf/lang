class Lang::Lexeme
  attr_reader :value

  def initialize(value, type, start, finish)
    @value = value
    @type = type
    @start = start
    @finish = finish
  end

  def is_type?(cls)
    @type.is_a?(cls)
  end
end
