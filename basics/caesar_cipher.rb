def correct_index(shift, index)
  new_index = index + shift
  if new_index.positive?
    new_index -= 26 while new_index > 25
  else
    new_index += 26 while new_index.negative?
  end
  new_index
end

def caesar_char(char, shift)
  alphabet = Array("a".."z")
  index = alphabet.index(char.downcase)
  if index
    new_index = correct_index(shift, index)
    new_char = alphabet[new_index]
    new_char = new_char.upcase if char.upcase == char
    new_char
  else
    char
  end
end

def caesar_cipher(string, shift)
  chars = string.chars
  enciphered = chars.map do |char|
    caesar_char(char, shift)
  end
  enciphered.join
end
