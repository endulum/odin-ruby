require_relative "../lib/fibonacci"

describe "fibonacci sequence" do
  sequence = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
  it "works" do
    sequence.length.downto(1).each do |index|
      expect(Fibonacci.sequence_to(index)).to eq sequence.first(index)
    end
  end
end
