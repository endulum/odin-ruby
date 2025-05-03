def caesar_cipher(string, shift)
  alphabet = Array("a".."z")
  chars = string.chars
  enciphered = []
  chars.each do |char|
    index = alphabet.index(char.downcase)
    if index
      # get new index
      new_index = index + shift
      if new_index.positive?
        new_index -= 26 while new_index > 25
      else
        new_index += 26 while new_index.negative?
      end

      # get new char using index
      new_char = alphabet[new_index]
      new_char = new_char.upcase if char.upcase == char

      # push!
      enciphered.push(new_char)
    else
      enciphered.push(char)
    end
  end

  enciphered.join
end
