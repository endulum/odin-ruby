require_relative "../lib/merge"

describe "merge sort" do
  it "should sort (example)" do
    expect(MergeSort.merge([3, 2, 1, 13, 8, 5, 0, 1])).to eq [0, 1, 1, 2, 3, 5, 8, 13]
  end

  it "should sort (example)" do
    expect(MergeSort.merge([105, 79, 100, 110])).to eq [79, 100, 105, 110]
  end
end
