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
    @genesis.chapters.create(chapter_number: 1, nrofverses: 4)
    @genesis.chapters.create(chapter_number: 2, nrofverses: 3)
    # create(:chapter, biblebook: @genesis, chapter_number: 1, nrofverses: 4)
    # create(:chapter, biblebook: @genesis, chapter_number: 2)
  end

  it 'can be created with valid parameters' do
    verse = create(:bible_verse, biblebook: @genesis, chapter_nr: 1, verse_nr: 1)
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
    verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 99, verse_nr: 1)
    expect(verse).to_not be_valid
  end

  # it 'rejects verses that are out of range' do
  #   verse = BibleVerse.new(biblebook: @genesis, chapter_nr: 1, verse_nr: 5)
  #   expect(verse).to_not be_valid
  # end
end
