# frozen_string_literal: true

# == Schema Information
#
# Table name: pericope_as_ranges
#
#  id                :integer          not null, primary key
#  name              :string
#  starting_verse_id :integer
#  ending_verse_id   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

describe PericopeAsRange, type: :model do
  let(:genesis) { create(:biblebook, name: 'Genesis') }
  let(:exodus) { create(:biblebook, name: 'Exodus') }
  let(:starting_verse) do
    create(:bible_verse,
           biblebook:  genesis,
           chapter_nr: 1,
           verse_nr:   2)
  end

  let(:ending_verse) do
    create(:bible_verse,
           biblebook:  genesis,
           chapter_nr: 3,
           verse_nr:   4)
  end

  before do
    create(:chapter, biblebook: genesis, chapter_number: 1, nrofverses: 4)
    create(:chapter, biblebook: genesis, chapter_number: 2, nrofverses: 5)
    create(:chapter, biblebook: genesis, chapter_number: 3, nrofverses: 5)

    create(:chapter, biblebook: exodus, chapter_number: 1, nrofverses: 4)
    create(:chapter, biblebook: exodus, chapter_number: 2, nrofverses: 5)
    create(:chapter, biblebook: exodus, chapter_number: 3, nrofverses: 5)
  end

  it 'can be created with valid parameters' do
    pericope = PericopeAsRange.create(starting_verse: starting_verse,
                                      ending_verse:   ending_verse)
    expect(pericope).to be_valid
  end

  it 'is confined to a single biblebook' do
    ending_verse = create(:bible_verse,
                          biblebook:  exodus,
                          chapter_nr: 3,
                          verse_nr:   4)
    pericope     = PericopeAsRange.create(starting_verse: starting_verse,
                                          ending_verse:   ending_verse)
    expect(pericope).not_to be_valid
  end

  it 'is able to identify if a verse is within a range' do
    pericope = starting_verse..ending_verse
    verse    = create(:bible_verse,
                      biblebook:  genesis,
                      chapter_nr: 1,
                      verse_nr:   3)
    expect(pericope).to include(verse)
  end

  it 'can step through the verses in a pericope' do
    pericope = starting_verse..ending_verse
    verse1   = pericope.first
    expect(verse1).to eq(starting_verse)
  end
end
