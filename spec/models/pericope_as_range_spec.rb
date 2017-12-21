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
  before do
    @genesis = create(:biblebook, name: 'Genesis')
    create(:chapter, biblebook: @genesis, chapter_number: 1, nrofverses: 4)
    create(:chapter, biblebook: @genesis, chapter_number: 2, nrofverses: 5)
    create(:chapter, biblebook: @genesis, chapter_number: 3, nrofverses: 5)
  end

  it 'can be created with valid parameters' do
    starting_verse = create(:bible_verse, biblebook: @genesis, chapter_nr: 1, verse_nr: 2)
    ending_verse   = create(:bible_verse, biblebook: @genesis, chapter_nr: 3, verse_nr: 4)
    pericope       = PericopeAsRange.create(starting_verse: starting_verse, ending_verse: ending_verse)
    expect(pericope).to be_valid
  end
end

