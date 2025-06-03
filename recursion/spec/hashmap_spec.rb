require "faker"
require_relative "../lib/hashmap"

hashmap = HashMap::Map.new

# prepare a sample "Animals" hash for use

animals = {}
until animals.keys.length >= 50
  name = Faker::Creature::Animal.name
  animals[name] = Faker::Color.color_name
end

describe "hashing" do
  it "should hash keys into valid indices" do
    animals.each_key do |key|
      index = hashmap.hash(key)
      expect(index).to be_instance_of Integer
      expect(index).to be_between(0, 15)
    end
  end
end

describe "methods" do
  it "should place key-value pairs in buckets without error" do
    animals.each do |key, value|
      hashmap.set(key, value)
    end
  end

  it "should iterate through buckets without error" do
    hashmap.each do |bucket|
      puts bucket.nil? ? "nil" : bucket.to_string
    end
  end

  target_animal = animals.keys[0]

  it "should overwrite a value without error" do
    hashmap.set(target_animal, "none")
  end
end
