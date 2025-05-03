def substrings string, dictionary
  totals = Hash.new(0)
  dictionary.each do |word|
    total = string.downcase.scan(word.downcase).count
    totals[word] = total unless total <= 0
  end
  totals
end