# frozen_string_literal: true

# == Schema Information
#
# Table name: biblebooks
#
#  id                    :integer          not null, primary key
#  abbreviation          :string
#  booksequence          :integer
#  name                  :string
#  testament             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  bible_verse_id        :bigint
#  biblebook_category_id :bigint
#
# Indexes
#
#  index_biblebooks_on_biblebook_category_id  (biblebook_category_id)
#

describe Biblebook do
  let(:genesis) { create(:biblebook, name: 'Genesis', abbreviation: 'Gen') }

  before do
    create(:chapter, biblebook_id: genesis.id, nrofverses: 5)
    create(:chapter, biblebook_id: genesis.id, nrofverses: 8)
  end

  it 'knows how many chapters it has' do
    expect(genesis.nr_of_chapters).to eq 2
  end

  it 'accepts chapters within range' do
    expect(genesis.chapter_valid?(1)).to eq(true)
  end

  it 'rejects chapters outside range' do
    expect(genesis.chapter_valid?(3)).to eq(false)
  end

  it 'can find a book when the full name is given' do
    expect(described_class.possible_book_names('Genesis'))
      .to eq(['Genesis'])
  end

  it 'can find a book when the official abbreviation is given' do
    expect(described_class.possible_book_names('Gen'))
      .to eq(['Genesis'])
  end

  it 'can find a book  when a decent abbreviation is given' do
    expect(described_class.possible_book_names('Genes'))
      .to eq(['Genesis'])
  end

  it 'can find  books when a wide abbreviation is given' do
    create(:biblebook, name: 'Job')
    create(:biblebook, name: 'Johannes')
    create(:biblebook, name: 'Jona')

    books = described_class.possible_book_names('Jo')

    expect(books). to eq(%w[Job Johannes Jona])
  end

  it 'finds books by full name' do
    book = described_class.find_by_full_name('Genesis')
    expect(book.first).to eq(genesis)
    # Note, .first is needed, because we can an AREL back, not an Object
  end

  it 'finds books by abbreviation' do
    book = described_class.find_by_abbreviation('gen')
    expect(book.first).to eq(genesis)
  end

  it 'finds single books by fuzzy name' do
    book = described_class.find_names_by_like('Gene')
    expect(book.first).to eq(genesis)
  end

  it 'finds multiple books by fuzzy name' do
    create(:biblebook, name: 'Job')
    create(:biblebook, name: 'Johannes')
    create(:biblebook, name: 'Jona')
    books = described_class.find_names_by_like('Jo')
    expect(books.count).to eq(3)
  end
end
