require "pry-byebug"
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

  it "should get correct total of nodes" do
    expect(tree.total_nodes).to eq 10
  end
end

describe "balancing" do
  balanced_tree = BST::Tree.new((1..30).to_a)
  unbalanced_tree = BST::Tree.new((1..100).to_a.sample(30), balance_after: false)

  it "should determine if a tree is balanced" do
    expect(balanced_tree.balanced?).to be true
    expect(unbalanced_tree.balanced?).to be false
  end

  it "should balance a tree" do
    unbalanced_tree.balance
    expect(unbalanced_tree.balanced?).to be true
  end
end

describe "insertion and deletion" do
  it "should insert, respecting the `balance_after` option" do
    tree = BST::Tree.new []
    (1..10).each { |value| tree.insert(value) }
    expect(tree.balanced?).to be false
    other_tree = BST::Tree.new []
    (1..10).each { |value| other_tree.insert(value, balance_after: true) }
    expect(other_tree.balanced?).to be true
  end

  it "should not insert duplicates" do
    tree = BST::Tree.new([1, 1, 1])
    expect(tree.total_nodes).to eq 1
    tree.insert(1)
    expect(tree.total_nodes).to eq 1
  end

  it "should delete, respecting the `balance_after` option" do
    numbers = (1..10).to_a

    tree = BST::Tree.new(numbers)
    numbers.each_with_index do |number, index|
      tree.remove(number)
      expect(tree.total_nodes).to eq numbers.length - index - 1
    end

    other_tree = BST::Tree.new(numbers)
    numbers.each do |number|
      other_tree.remove(number, balance_after: true)
      expect(other_tree.balanced?).to be true
    end
  end

  it "should not delete nonexistent values" do
    tree = BST::Tree.new((1..3).to_a)
    tree.remove(5)
    expect(tree.total_nodes).to eq 3
  end
end
