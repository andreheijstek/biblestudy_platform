# frozen_string_literal: true

# == Schema Information
#
# Table name: pericopes
#
#  id                  :integer          not null, primary key
#  biblebook_name      :string
#  ending_chapter_nr   :integer
#  ending_verse_nr     :integer
#  name                :string
#  sequence            :integer
#  starting_chapter_nr :integer
#  starting_verse_nr   :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  biblebook_id        :integer
#  studynote_id        :integer
#
# Indexes
#
#  index_pericopes_on_biblebook_id  (biblebook_id)
#  index_pericopes_on_studynote_id  (studynote_id)
#
# Foreign Keys
#
#  fk_rails_...  (biblebook_id => biblebooks.id)
#  fk_rails_...  (studynote_id => studynotes.id)
#

describe Pericope, type: :model do
  let!(:genesis) { create(:biblebook, name: 'Genesis') }

  before { create(:biblebook, name: '1 Korintiërs') }

  it 'is valid with ascii biblebooks' do
    expect(described_class.create(name: 'Genesis 1:1 - 1:10')).to be_valid
  end

  it 'is valid with UTF-8 biblebooks' do
    expect(described_class.create(name: '1 Korintiërs 1:1 - 1:10')).to be_valid
  end

  it 'is valid with abbreviated biblebook' do
    expect(described_class.create(name: 'Gen 1:1 - 1:10')).to be_valid
  end

  it 'is not valid without a name' do
    expect(described_class.create(name: '')).not_to be_valid
  end

  it 'name contains a valid pericope string, and can include spaces' do
    pericope = described_class.create(name: 'Genesis 1:2 - 3:4')
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse_nr).to eq(2)
    expect(pericope.ending_chapter_nr).to eq(3)
    expect(pericope.ending_verse_nr).to eq(4)
    expect(pericope.biblebook_id).to eq(genesis.id)
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'name  contains a valid pericope string, ending chapter is not required' do
    pericope = described_class.create(name: 'Genesis 1:2 - 3')
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse_nr).to eq(2)
    expect(pericope.ending_chapter_nr).to eq(1)
    expect(pericope.ending_verse_nr).to eq(3)
    expect(pericope.biblebook_id).to eq(genesis.id)
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'verse may contain a biblebook abbreviation' do
    pericope = described_class.create(name: 'Gen 1:2 - 3')
    expect(pericope.starting_chapter_nr).to eq(1)
    expect(pericope.starting_verse_nr).to eq(2)
    expect(pericope.ending_chapter_nr).to eq(1)
    expect(pericope.ending_verse_nr).to eq(3)
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'ending chapter must be greater or equal than starting chapter' do
    pericope = described_class.create(name: 'Genesis 4:3 - 2:1')
    expect(pericope).not_to be_valid
  end

  it 'within same chapter ending verse to be greater than starting verse' do
    pericope = described_class.create(name: 'Genesis 4:3 - 4:1')
    expect(pericope).not_to be_valid
  end

  it 'could just be a single verse' do
    pericope = described_class.create(name: 'Genesis 4:3')
    expect(pericope).to be_valid
    expect(pericope.name).to eq('Genesis 4:3')
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'parses the biblebook from the name' do
    pericope = described_class.create(name: 'Genesis 1:2 - 3:4')
    expect(pericope.biblebook.name).to eq('Genesis')
  end
  # TODO: add similar tests for starting/ending chapter/verse
end
