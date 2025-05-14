require_relative "lib/dictionary"

Dictionary.check
10.times do
  p Dictionary.choose_word("hard")
end
