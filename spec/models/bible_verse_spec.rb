# == Schema Information
#
# Table name: bible_verses
#
#  id           :integer          not null, primary key
#  biblebook_id :integer
#  chapter_nr   :integer
#  verse_nr     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe BibleVerse, type: :model do
  before do
    @genesis = create(:biblebook, name: 'Genesis')
    create(:chapter, biblebook: @genesis, chapter_number: 1, nrofverses: 4)
    create(:chapter, biblebook: @genesis, chapter_number: 2, nrofverses: 3)
  end

  it 'can be created with valid parameters' do
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 1)
    expect(verse).to be_valid
  end

  it 'rejects when the chapter is missing' do
    verse = BibleVerse.new(biblebook: @genesis, verse_nr: 1)
    expect(verse).to_not be_valid
  end

  it 'rejects when the verse is missing' do
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 1)
    expect(verse).to_not be_valid
  end

  it 'rejects chapters that are out of range' do
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 0, verse_nr: 1)
    expect(verse).to_not be_valid
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: -1, verse_nr: 1)
    expect(verse).to_not be_valid
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 1)
    expect(verse).to be_valid
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 2, verse_nr: 1)
    expect(verse).to be_valid
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 3, verse_nr: 1)
    expect(verse).to_not be_valid
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 99, verse_nr: 1)
    expect(verse).to_not be_valid
  end

  it 'rejects verses that are out of range' do
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 5)
    expect(verse).to_not be_valid
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 4)
    expect(verse).to be_valid
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 3)
    expect(verse).to be_valid
  end

  it 'can compare bibleverses within the same chapter' do
    verse1 = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 1)
    verse2 = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 5)
    expect(verse1 == verse1).to be_truthy
    expect(verse1 > verse2).to be_falsey
    expect(verse1 < verse2).to be_truthy
  end

  it 'can compare bibleverses across chapters' do
    verse1 = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 1)
    verse2 = BibleVerse.new(biblebook: @genesis, chapter_nr: 2, verse_nr: 1)
    p verse1
    puts

    expect(verse1 > verse2).to be_falsey
    expect(verse1 < verse2).to be_truthy
  end

  it 'can create a BibleVerse from a Pericope' do
    pericope = Pericope.create(name: 'Gen 1:2-3:4')
    verse    = BibleVerse.create(biblebook:  pericope.biblebook,
                                 chapter_nr: pericope.starting_chapter_nr,
                                 verse_nr:   pericope.starting_verse)
    expect(verse).to be_valid
  end
end
