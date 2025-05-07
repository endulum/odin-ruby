require "spec_helper"
require_relative "../lib/gameplay"

describe "comparing guess: simulate gameplay 1" do
  it "works" do
    answer = %w[yellow red yellow blue]
    history = [
      { guess: %w[red red red red], feedback: %w[correct] },
      { guess: %w[red yellow yellow yellow], feedback: %w[correct almost almost] },
      { guess: %w[yellow red yellow yellow], feedback: %w[correct correct correct] },
      { guess: %w[yellow red yellow blue], feedback: %w[correct correct correct correct] }
    ]
    history.each do |round|
      expect(Gameplay.compare(round[:guess], answer)).to eq round[:feedback]
    end
  end
end

describe "comparing guess: simulate gameplay 2" do
  it "works" do
    answer = %w[green blue blue yellow]
    history = [
      { guess: %w[red red red red], feedback: [] },
      { guess: %w[yellow yellow yellow yellow], feedback: %w[correct] },
      { guess: %w[yellow blue blue blue], feedback: %w[correct correct almost] },
      { guess: %w[blue yellow blue blue], feedback: %w[correct almost almost] },
      { guess: %w[blue blue yellow blue], feedback: %w[correct almost almost] },
      { guess: %w[blue blue blue yellow], feedback: %w[correct correct correct] },
      { guess: %w[green blue blue yellow], feedback: %w[correct correct correct correct] }
    ]
    history.each do |round|
      expect(Gameplay.compare(round[:guess], answer)).to eq round[:feedback]
    end
  end
end
