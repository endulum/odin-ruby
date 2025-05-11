require "spec_helper"
require_relative "../lib/scoring"

describe "scoring" do
  it "works" do
    expect(Scoring.calculate("1111", "3333")).to eq ""
  end
end
