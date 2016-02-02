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
  examples.each do |input, expected|
    describe "#consume" do
      it "tokenizes #{input}" do
        lexeme = tokenize(input).peek.first

        expect(lexeme.type).to be_a(described_class)
        expect(lexeme.value).to eq(expected)
      end
    end
  end
end
