require "faker"
require_relative "../lib/hashmap"

hashmap = HashMap::Map.new

# prepare a sample "Animals" hash for use

ANIMAL_COUNT = 12

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
    hashmap.set("unicorn", "rainbow")
  end

  it "#get: should return a value by key" do
    expect(hashmap.get("unicorn")).to eq "rainbow"
  end

  it "#get: should not get a value for a nonexistent key" do
    expect(hashmap.get("human")).to be_nil
  end

  it "#set: should overwrite a value" do
    hashmap.set("unicorn", "prismatic")
    expect(hashmap.get("unicorn")).to eq "prismatic"
  end

  it "#remove: should remove a value by key" do
    hashmap.remove("unicorn")
    expect(hashmap.get("unicorn")).to eq nil
  end
end

describe "enumerated" do
  it "#each: should enumerate" do
    animals.each { |key, value| hashmap.set(key, value) }
    enumerated_animals = []
    hashmap.each { |bucket| bucket&.each { |node| enumerated_animals.push(node.key) } }
    expect(enumerated_animals).to match_array animals.keys
  end

  it "#length: should get the total of stored keys" do
    expect(hashmap.length).to eq animals.keys.length
  end

  it "#keys: should get all stored keys" do
    expect(hashmap.keys).to match_array animals.keys
  end

  it "#values: should get all stored values" do
    expect(hashmap.values).to match_array animals.values
  end

  it "#entries: should get all stored key-value pairs" do
    pairs = animals.each.map { |pair| pair }
    expect(hashmap.entries).to match_array pairs
  end
end

describe "clear" do
  it "should remove all entries" do
    hashmap.clear
    expect(hashmap.keys).to eq []
  end
end
