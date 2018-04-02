# frozen_string_literal: true

# == Schema Information
#
# Table name: biblebooks
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  booksequence   :integer
#  testament      :string
#  abbreviation   :string
#  bible_verse_id :integer
#

require 'rails_helper'

describe Biblebook do
  let(:genesis) { create(:biblebook, name: 'Genesis') }

  before do
    # @genesis = create(:biblebook, name: 'Genesis')
    create(:chapter, biblebook_id: genesis.id, nrofverses: 5)
    create(:chapter, biblebook_id: genesis.id, nrofverses: 8)
  end

  it 'knows how many chapters it has' do
    expect(genesis.nr_of_chapters).to eq 2
  end

  it 'accepts chapters within range' do
    expect(genesis.chapters[1].chapter_valid?(1)).to eq(true)
  end
end
