require 'rails_helper'

RSpec.describe Pericope, type: :model do
  it "is valid with valid attributes" do
    expect(Pericope.new(name: 'Genesis 1:1 - 1:10')).to be_valid
  end

  # it "is not valid without a name" do
  #   expect(Pericope.new(name: nil)).to_not be_valid
  # end

  it "name must contain a valid pericope string, like Genesis 1:1 - 1:10" do
    pericope = Pericope.new(name: 'Genesis 1:2 - 3:4')
    pericope.set
    puts "Pericope: #{pericope.inspect}"
  end

=begin
  it "name must contain a valid pericope string, like Genesis 1:1-1:10" do
    pericope = Pericope.new(name: 'Genesis 1:2-3:4')
    pericope.set
    expect(pericope).to_not be_valid
  end
=end

=begin
  it "name must contain a valid pericope string, like Genesis 1:1 - 10" do
    pericope = Pericope.new(name: 'Genesis 1:1 - 10')
    pericope.set
    expect(pericope).to_not be_valid
  end
=end

  # it "verse may contain a biblebook abbreviation"
  # it "ending chapter must be greater or equal than starting chapter"
  # it "within the same chapter ending verse must be greater than starting verse"
end
