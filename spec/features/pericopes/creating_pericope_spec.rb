# frozen_string_literal: true

require 'rails_helper'

feature 'Users can create pericopes' do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Genesis')
  end

  it 'creates a studynote and pericope with valid and full attributes' do
    pericope = Pericope.create(name: 'Genesis 3:4-5:6')
    expect(pericope).to be_valid
    expect(pericope.name).to eq('Genesis 3:4 - 5:6')
    expect(pericope.starting_chapter_nr).to be(3)
    expect(pericope.starting_verse).to be(4)
    expect(pericope.ending_chapter_nr).to be(5)
    expect(pericope.ending_verse).to be(6)
    expect(pericope.biblebook.name).to eq('Genesis')
  end

  it 'creates a studynote and pericope with valid and abbreviated attributes' do
    pericope = Pericope.create(name: 'Gen 3:4-5:6')
    expect(pericope).to be_valid
  end
end
