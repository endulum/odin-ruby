require "faker"
require_relative "../lib/hashmap"

hashmap = HashMap::Map.new

# prepare a sample "Animals" hash for use

ANIMAL_COUNT = 5

animals = {}
until animals.keys.length >= ANIMAL_COUNT
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

describe "basics" do
  it "#set: should place a value as a list node" do
    animals.each { |key, value| hashmap.set(key, value) }
    total = 0
    hashmap.each { |bucket| bucket&.each { total += 1 } }
    expect(total).to eq ANIMAL_COUNT
  end

  target_animal = animals.keys[0]

  it "#get: should get a value by key" do
    expect(hashmap.get(target_animal)).to eq animals[target_animal]
  end

  it "#get: should not get a value for nonexistent key" do
    expect(hashmap.get("human")).to be_nil
  end

  it "#set: should overwrite a value" do
    hashmap.set(target_animal, "none")
    expect(hashmap.get(target_animal)).to eq "none"
  end

  it "#remove: should remove a value by key" do
    hashmap.remove(target_animal)
  end
end
