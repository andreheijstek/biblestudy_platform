# frozen_string_literal: true

# == Schema Information
#
# Table name: pericopes
#
#  id             :integer          not null, primary key
#  biblebook_name :string
#  name           :string
#  sequence       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  biblebook_id   :integer
#  end_verse_id   :bigint
#  start_verse_id :bigint
#  studynote_id   :integer
#
# Indexes
#
#  index_pericopes_on_biblebook_id    (biblebook_id)
#  index_pericopes_on_end_verse_id    (end_verse_id)
#  index_pericopes_on_start_verse_id  (start_verse_id)
#  index_pericopes_on_studynote_id    (studynote_id)
#
# Foreign Keys
#
#  fk_rails_...  (biblebook_id => biblebooks.id)
#  fk_rails_...  (end_verse_id => bible_verses.id)
#  fk_rails_...  (start_verse_id => bible_verses.id)
#  fk_rails_...  (studynote_id => studynotes.id)
#

describe Pericope, type: :model do
  let!(:genesis) { create(:biblebook_with_chapters, name: 'Genesis') }

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
    expect(pericope.start_verse.chapter).to eq(1)
    expect(pericope.start_verse.verse).to eq(2)
    expect(pericope.end_verse.chapter).to eq(3)
    expect(pericope.end_verse.verse).to eq(4)
    expect(pericope.biblebook_id).to eq(genesis.id)
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'name  contains a valid pericope string, ending chapter is not required' do
    pericope = described_class.create(name: 'Genesis 1:2 - 3')
    expect(pericope.start_verse.chapter).to eq(1)
    expect(pericope.start_verse.verse).to eq(2)
    expect(pericope.end_verse.chapter).to eq(1)
    expect(pericope.end_verse.verse).to eq(3)
    expect(pericope.biblebook_id).to eq(genesis.id)
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'verse may contain a biblebook abbreviation' do
    pericope = described_class.create(name: 'Gen 1:2 - 3')
    expect(pericope.start_verse.chapter).to eq(1)
    expect(pericope.start_verse.verse).to eq(2)
    expect(pericope.end_verse.chapter).to eq(1)
    expect(pericope.end_verse.verse).to eq(3)
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

  # it 'validates verses in scope of the chapter' do
  #   pericope = described_class.create(name: 'Genesis 1:1')
  #   expect(pericope).to be_valid
  #
  #   pericope = described_class.create(name: 'Genesis 1:2')
  #   expect(pericope).not_to be_valid
  # end

  it 'could just be a single verse' do
    pericope = described_class.create(name: 'Genesis 4:3')
    expect(pericope).to be_valid
    expect(pericope.name).to eq('Genesis 4:3 - 4:3')
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'parses the biblebook from the name' do
    pericope = described_class.create(name: 'Genesis 1:2 - 3:4')
    expect(pericope.biblebook.name).to eq('Genesis')
  end
  # TODO: add similar tests for starting/ending chapter/verse
end
