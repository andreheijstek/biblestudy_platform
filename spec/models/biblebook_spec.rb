# frozen_string_literal: true
# == Schema Information
#
# Table name: biblebooks
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  booksequence :integer
#  testament    :string
#  abbreviation :string
#

require 'rails_helper'

describe Biblebook do
  let(:genesis) { create(:biblebook, name: 'Genesis', abbreviation: 'Gen') }

  before do
    # @genesis = create(:biblebook, name: 'Genesis')
    create(:chapter, biblebook_id: genesis.id, nrofverses: 5)
    create(:chapter, biblebook_id: genesis.id, nrofverses: 8)
  end

  it 'knows how many chapters it has' do
    expect(genesis.nr_of_chapters).to eq 2
  end

  it 'accepts chapters within range' do
    expect(genesis.chapter_valid?(1)).to eq(true)
  end

  it 'can find which book match a bookname when the full name is given' do
    expect(Biblebook.possible_book_names('Genesis')). to eq(['Genesis'])
  end

  it 'can find which book match a bookname when the official abbreviation is given' do
    expect(Biblebook.possible_book_names('Gen')). to eq(['Genesis'])
  end

  it 'can find which book match a bookname when a decent abbreviation is given' do
    expect(Biblebook.possible_book_names('Genes')). to eq(['Genesis'])
  end

  it 'can find which books match a bookname when a wide abbreviation is given' do
    create(:biblebook, name: 'Job')
    create(:biblebook, name: 'Johannes')
    create(:biblebook, name: 'Jona')

    books = Biblebook.possible_book_names('Jo')

    expect(books). to eq(['Job', 'Johannes', 'Jona'])
  end
end
