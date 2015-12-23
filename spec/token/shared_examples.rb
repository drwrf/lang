shared_examples_for "a token" do |examples|
  examples.each do |input, lexeme|
    describe "#consume" do
      it "consumes #{input}" do
        token = tokenize(input).next

        expect(token).to be_a(described_class)
        expect(token.lexeme).to eq(lexeme)
      end
    end
  end
end
