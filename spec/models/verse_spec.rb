require 'rails_helper'

describe Verse do
  it 'can be created' do
    verse = Verse.new(1,1)
    expect(verse.class).to be(Verse)
  end

  it 'can set the values of the attributes' do
    verse = Verse.new(1,1)
    verse.chapter = 2
    expect(verse.chapter).to eq(2)
  end

  it 'can compare verses when chapters differ' do
    verse1 = Verse.new(1,1)
    verse2 = Verse.new(2,1)
    expect(verse2 > verse1).to be(true)
  end

  it 'can compare verses when verses differ' do
    verse1 = Verse.new(1,1)
    verse2 = Verse.new(1,2)
    expect(verse2 > verse1).to be(true)
  end

  it 'can compare verses when chapters and verses differ' do
    verse1 = Verse.new(1,1)
    verse2 = Verse.new(2,2)
    expect(verse2 > verse1).to be(true)
  end

  it 'can compare verses when the are equal' do
    verse1 = Verse.new(1,1)
    verse2 = Verse.new(1,1)
    expect(verse1 == verse2).to be(true)
  end
end

