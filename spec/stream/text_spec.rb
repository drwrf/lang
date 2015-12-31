describe Lang::TextStream do
  subject do
    described_class.new input
  end

  let :input do
    "This will not be parsed in any way, so we only
     want to ensure that newlines and what-not are
     present so that the line and offset counting
     works properly.

     That said, it's still overridable for testing
     specific features of this class."
  end

  describe '#loop' do
    it 'loops until all characters are read' do
      chars = ''

      subject.loop do
        chars += subject.advance
      end

      expect(chars).to eq(input)
    end
  end

  describe '#peek' do
    let :input do
      '#peek'
    end

    it "returns one character by default" do
      expect(subject.peek).to eq('#')
    end

    it "returns many characters" do
      expect(subject.peek(amount: 5)).to eq('#peek')
    end

    it "returns nothing for an overflow" do
      expect(subject.peek(amount: 100)).to be_nil
    end

    it "does not advance the cursor" do
      expect(subject.peek).to eq('#')
      expect(subject.peek).to eq('#')
    end
  end
end
