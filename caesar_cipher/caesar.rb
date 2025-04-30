$alphabet = Array('a'..'z')

def caesar_cipher string, shift
  chars = string.split('')
  enciphered = []
  chars.each do |char|
    index = $alphabet.index(char.downcase)
    if index
      # get new index
      new_index = index + shift
      if (new_index > 0)
        while (new_index > 25)
          new_index -= 26
        end
      else 
        while (new_index < 0)
          new_index += 26
        end
      end

      # get new char using index
      new_char = $alphabet[new_index]
      new_char = new_char.upcase if (char.upcase == char)
      
      # push!
      enciphered.push(new_char)
    else
      enciphered.push(char)
    end
  end

  return enciphered.join('')
end

p caesar_cipher("What a string!", 5)
# => "Bmfy f xywnsl!"