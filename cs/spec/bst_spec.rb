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

describe "recursion with block" do
  random_numbers = (1..200).to_a.sample(15)
  tree = BST::Tree.new(random_numbers)
  tree.pretty_print

  it "should recurse in preorder" do
    preorder = []
    tree.preorder { |node| preorder.push(node.value) }
    expect(preorder).to match_array random_numbers
  end

  it "should recurse in postorder" do
    postorder = []
    tree.postorder { |node| postorder.push(node.value) }
    expect(postorder).to match_array random_numbers
  end

  it "should recurse in inorder" do
    inorder = []
    tree.inorder { |node| inorder.push(node.value) }
    expect(inorder).to eq random_numbers.sort
  end

  it "should iterate in levelorder" do
    levelorder = []
    tree.levelorder { |node| levelorder.push(node.value) }
    expect(levelorder).to match_array random_numbers
  end
end
