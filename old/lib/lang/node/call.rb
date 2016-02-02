class Lang::Node
  class Call < Struct.new(:method, :args, :block)
  end
end
