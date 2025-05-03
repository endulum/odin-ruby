# Enciphers strings using caesarian shift, given an alphabet
class CaesarCipher
  attr_reader :alphabet

  def initialize(alphabet = Array("a".."z"))
    @alphabet = alphabet
  end

  def encipher_string(string, shift)
    chars = string.chars
    enciphered = chars.map do |char|
      encipher_char(char, shift)
    end
    enciphered.join
  end

  private

  def encipher_char(char, shift)
    index = @alphabet.index(char.downcase)
    if index
      new_char_index = normalize_index(index + shift)
      new_char = @alphabet[new_char_index]
      new_char = new_char.upcase if char.upcase == char
      new_char
    else
      char
    end
  end

  def normalize_index(index)
    if index.positive?
      index -= @alphabet.length while index > 25
    else
      index += @alphabet.length while index.negative?
    end
    index
  end
end
