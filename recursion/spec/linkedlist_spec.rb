require_relative "../lib/linkedlist"

describe "linked list" do
  list = LinkedList::List.new

  list.append("dog")
  list.append("cat")
  list.append("parrot")
  list.append("hamster")
  list.append("snake")
  list.append("turtle")

  it "gets size" do
    expect(list.size).to eq 6
  end

  it "gets at index" do
    expect(list.at(3)).to eq "hamster"
    expect(list.at(10)).to eq nil
  end

  it "determines contain" do
    expect(list.contains?("snake")).to be true
    expect(list.contains?("ferret")).to be false
  end

  it "finds" do
    expect(list.find("parrot")).to eq 2
    expect(list.find("lizard")).to eq nil
  end

  it "prints string" do
    expect(list.to_s).to eq "( dog ) -> ( cat ) -> ( parrot ) -> ( hamster ) -> ( snake ) -> ( turtle ) -> nil"
  end
end
