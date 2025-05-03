require "spec_helper"
require_relative "../lib/basics/caesar_cipher"

describe "caesar cipher" do
  caesar_cipher = CaesarCipher.new
  input = "What a string!"

  it "works" do
    expect(caesar_cipher.encipher_string(input, 5)).to eq("Bmfy f xywnsl!")
  end

  it "works with negative shift" do
    expect(caesar_cipher.encipher_string(input, -5)).to eq("Rcvo v nomdib!")
  end

  it "overflows shift (positive)" do
    output = "Zkdw d vwulqj!"
    expect(caesar_cipher.encipher_string(input, 3)).to eq(output)
    expect(caesar_cipher.encipher_string(input, 3 + (26 * 100))).to eq(output)
  end

  it "overflows shift (negative)" do
    output = "Texq x pqofkd!"
    expect(caesar_cipher.encipher_string(input, -3)).to eq(output)
    expect(caesar_cipher.encipher_string(input, -3 - (26 * 100))).to eq(output)
  end
end
