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

describe "enumeration with block" do
  tree = BST::Tree.new((1..10).to_a)

  it "should recurse in preorder" do
    preorder = []
    tree.preorder { |node| preorder.push(node.value) }
    expect(preorder).to eq [5, 2, 1, 3, 4, 8, 6, 7, 9, 10]
  end

  it "should recurse in postorder" do
    postorder = []
    tree.postorder { |node| postorder.push(node.value) }
    expect(postorder).to eq [1, 4, 3, 2, 7, 6, 10, 9, 8, 5]
  end

  it "should recurse in inorder" do
    inorder = []
    tree.inorder { |node| inorder.push(node.value) }
    expect(inorder).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  it "should iterate in levelorder" do
    levelorder = []
    tree.levelorder { |node| levelorder.push(node.value) }
    expect(levelorder).to eq [5, 2, 8, 1, 3, 6, 9, 4, 7, 10]
  end
end
