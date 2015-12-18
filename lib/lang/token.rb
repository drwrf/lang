class Lang::Token
  def initialize(token, line, col)
    @token = token
    @line = line
    @col = col
  end
end
