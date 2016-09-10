require 'rails_helper'

RSpec.describe Pericope, type: :model do

  before do
    # create a biblebook first, so that can be connected to the pericope
    book = FactoryGirl.create(:biblebook, name: "Genesis")
    @book_id = book.id
  end

  it "is valid with valid attributes" do
    expect(Pericope.new(name: 'Genesis 1:1 - 1:10')).to be_valid
  end

  it "is not valid without a name" do
    expect(Pericope.new(name: "")).to_not be_valid
    expect(Pericope.new(name: nil)).to_not be_valid
  end

  it "name must contain a valid pericope string, like Genesis 1:1 - 1:10" do
    pericope = Pericope.new(name: 'Genesis 1:2 - 3:4')
    pericope.save  # trigger the validation and after_validation
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse).to      eq(2)
    expect(pericope.ending_chapter_nr).to   eq(3)
    expect(pericope.ending_verse).to        eq(4)
    expect(pericope.biblebook_id).to        eq(@book_id)
  end

  it "name must contain a valid pericope string, like Genesis 1:1-1:10" do
    pericope = Pericope.new(name: 'Genesis 1:2-3:4')
    pericope.save
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse).to      eq(2)
    expect(pericope.ending_chapter_nr).to   eq(3)
    expect(pericope.ending_verse).to        eq(4)
    expect(pericope.biblebook_id).to        eq(@book_id)
  end

  it "name must contain a valid pericope string, like Genesis 1:1 - 10" do
    pericope = Pericope.new(name: 'Genesis 1:2 - 3')
    pericope.save
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse).to      eq(2)
    expect(pericope.ending_chapter_nr).to   eq(1)
    expect(pericope.ending_verse).to        eq(3)
    expect(pericope.biblebook_id).to        eq(@book_id)
  end

=begin
  it "verse may contain a biblebook abbreviation" do
    pericope = Pericope.new(name: 'Gen 1:2 - 3')
    pericope.set
    puts "Pericope: #{pericope.inspect}"
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse).to      eq(2)
    expect(pericope.ending_chapter_nr).to   eq(1)
    expect(pericope.ending_verse).to        eq(3)

    expect(true).to eq(false) # test makes no sense now, as I don't check on name
  end
=end

=begin
  it "ending chapter must be greater or equal than starting chapter" do
    pericope = Pericope.new(name: 'Genesis 4:3 - 2:1')
    pericope.set
    expect(pericope).to_not be_valid
  end

  it "within the same chapter ending verse must be greater than starting verse" do
    pericope = Pericope.new(name: 'Genesis 4:3 - 4:1')
    pericope.set
    expect(pericope).to_not be_valid
  end
=end
end
