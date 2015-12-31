describe Lang::TextStream do
  subject do
    described_class.new input
  end

  describe '#loop' do
    let :input do
      "This will not be parsed in any way, so we only
       want to ensure that newlines and what-not are
       present so that the line and offset counting
       works properly.

       That said, it's still overridable for testing
       specific features of this class."
    end

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
      expect(subject.peek(5)).to eq('#peek')
    end

    it "returns nothing for an overflow" do
      expect(subject.peek(100)).to be_nil
    end

    it "does not advance the cursor" do
      expect(subject.peek).to eq('#')
      expect(subject.peek).to eq('#')
    end
  end

  describe '#advance' do
    let :input do
      '#advance'
    end

    it "returns one character by default" do
      expect(subject.advance).to eq('#')
    end

    it "returns many characters" do
      expect(subject.advance(8)).to eq('#advance')
    end

    it "raises for an overflow" do
      expect { subject.advance(100) }.to raise_error(RuntimeError)
    end

    it "advances the cursor" do
      expect(subject.advance).to eq('#')
      expect(subject.advance).to eq('a')
    end
  end

  describe '#location' do
    let :input do
      "1\n2\n3"
    end

    it "defaults to the beginning" do
      expect(subject.location).to eq([1, 1])
    end

    it "follows the cursor" do
      subject.advance
      expect(subject.location).to eq([1, 2])
    end

    it "tracks newlines" do
      expect(subject.location).to eq([1, 1])
      subject.advance
      expect(subject.location).to eq([1, 2])
      subject.advance
      expect(subject.location).to eq([2, 1])
      subject.advance
      expect(subject.location).to eq([2, 2])
      subject.advance
      expect(subject.location).to eq([3, 1])
      subject.advance
      expect(subject.location).to eq([3, 2])
    end
  end
end
