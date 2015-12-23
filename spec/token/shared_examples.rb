# Affords shared examples for token parsing.
#
# The second argument is a hash where the keys are text
# to tokenize, and the values are the expected lexeme.
# Naturally this assumes that the text tokenizes into
# only one token.
#
# example:
#
# describe Lang::Token::Number do
#   it_behaves_like "a tokenizer", {
#     "1" => "1"
#   }
# end
shared_examples_for "a tokenizer" do |examples|
  examples.each do |input, lexeme|
    describe "#consume" do
      it "tokenizes #{input}" do
        token = tokenize(input).next

        expect(token).to be_a(described_class)
        expect(token.lexeme).to eq(lexeme)
      end
    end
  end
end
