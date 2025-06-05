require_relative "../lib/bst"

describe "node comparison" do
  it "should compare nodes" do
    one, two, three = (1..3).map { |value| BST::Node.new(value) }
    expect(one > two).to be false
    expect(three > two).to be true
    expect(one < three).to be true
    expect(two < one).to be false
  end
end
