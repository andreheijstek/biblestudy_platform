# frozen_string_literal: true
# == Schema Information
#
# Table name: pericopes
#
#  id                  :integer          not null, primary key
#  studynote_id        :integer
#  starting_verse      :integer
#  ending_verse        :integer
#  biblebook_id        :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  name                :string
#  ending_chapter_nr   :integer
#  starting_chapter_nr :integer
#  biblebook_name      :string
#  sequence            :integer
#

require 'rails_helper'

describe Pericope, type: :model do
  before do
    # create a biblebook first, so that it can be connected to the pericopes
    @genesis = create(:biblebook, name: 'Genesis')
    create(:biblebook, name: '1 Korintiërs')
  end

  it 'is valid with valid attributes' do
    expect(Pericope.create(name: 'Genesis 1:1 - 1:10')).to be_valid
    expect(Pericope.create(name: '1 Korintiërs 1:1 - 1:10')).to be_valid
  end

  it 'is valid with abbreviated biblebook' do
    expect(Pericope.create(name: 'Gen 1:1 - 1:10')).to be_valid
    expect(Pericope.create(name: '1 Kor 1:1 - 1:10')).to be_valid
  end

  it 'is not valid without a name' do
    expect(Pericope.create(name: '')).not_to be_valid
  end

  it 'name must contain a valid pericopes string, and can include spaces' do
    pericope = Pericope.create(name: 'Genesis 1:2 - 3:4')
    # pericope.save  # trigger the validation and after_validation
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse).to eq(2)
    expect(pericope.ending_chapter_nr).to eq(3)
    expect(pericope.ending_verse).to eq(4)
    expect(pericope.biblebook_id).to eq(@genesis.id)
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'name must contain a valid pericopes string, and may be without spaces' do
    pericope = Pericope.create(name: 'Genesis 1:2-3:4')
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse).to eq(2)
    expect(pericope.ending_chapter_nr).to eq(3)
    expect(pericope.ending_verse).to eq(4)
    expect(pericope.biblebook_id).to eq(@genesis.id)
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'name must contain a valid pericopes string, ending chapter is not required' do
    pericope = Pericope.create(name: 'Genesis 1:2 - 3')
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse).to eq(2)
    expect(pericope.ending_chapter_nr).to eq(1)
    expect(pericope.ending_verse).to eq(3)
    expect(pericope.biblebook_id).to eq(@genesis.id)
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'verse may contain a biblebook abbreviation' do
    pericope = Pericope.create(name: 'Gen 1:2 - 3')
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse).to eq(2)
    expect(pericope.ending_chapter_nr).to eq(1)
    expect(pericope.ending_verse).to eq(3)

    expect(pericope).to be_valid # test makes no sense now, as I don't check on name
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'ending chapter must be greater or equal than starting chapter' do
    pericope = Pericope.create(name: 'Genesis 4:3 - 2:1')
    expect(pericope).not_to be_valid
  end

  it 'within the same chapter ending verse must be greater than starting verse' do
    pericope = Pericope.create(name: 'Genesis 4:3 - 4:1')
    expect(pericope).not_to be_valid
  end

  it 'could just be a single verse' do
    pericope = Pericope.create(name: 'Genesis 4:3')
    expect(pericope).to be_valid
    expect(pericope.name).to eq('Genesis 4:3')
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'parses the biblebook from the name' do
    pericope = Pericope.create(name: 'Genesis 1:2 - 3:4')
    expect(pericope.biblebook.name).to eq('Genesis')
  end

  # TODO: add similar tests for starting/ending chapter/verse
end
