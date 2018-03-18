# frozen_string_literal: true

# == Schema Information
#
# Table name: studynotes
#
#  id         :integer          not null, primary key
#  note       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  author_id  :integer
#
require 'rails_helper'

describe 'Studynote', type: :model do
  before do
    create(:biblebook, name: 'Genesis', abbreviation: 'Gen')
  end

  it 'creates a studynote with valid and full attributes' do
    expect(Studynote.create(title: 'title', note: 'note')).to be_valid
    # TODO: Why is this valid? There should be at least one pericope?
  end

  it 'creates a studynote with associated pericope' do
    sn = Studynote.create(title: 'title',
                          note: 'note',
                          pericopes_attributes: [{ name: 'Gen 1:2-3:4' }])
    expect(sn).to be_valid
    expect(sn.pericopes[0].biblebook_name).to eq('Genesis')
  end

  it 'rejects a studynote with without a title' do
    expect(Studynote.create(note: 'note')).to_not be_valid
  end

  it 'rejects a studynote with without a note' do
    expect(Studynote.create(title: 'title')).to_not be_valid
  end
end
