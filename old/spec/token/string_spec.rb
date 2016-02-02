describe Lang::Token::String do
  it_behaves_like "a tokenizer", {
    "'single-quotes'" => "single-quotes",
    '"double-quotes"' => "double-quotes",
    "'new\nlines'"    => "new\nlines",
    # TODO: Handle escape characters...
  }
end
