# frozen_string_literal: true

# == Schema Information
#
# Table name: studynotes
#
#  id         :integer          not null, primary key
#  note       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#
# Indexes
#
#  index_studynotes_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#
describe Studynote, type: :model do
  before do
    create(:biblebook, name: 'Genesis', abbreviation: 'Gen')
  end

  it 'creates a studynote with valid and full attributes' do
    expect(described_class.create(title: 'title', note: 'note')).to be_valid
    # TODO: Why is this valid? There should be at least one pericope?
  end

  it 'creates a studynote with associated pericope' do
    sn = described_class.create(title: 'title',
                          note: 'note',
                          pericopes_attributes: [{ name: 'Gen 1:2-3:4' }])
    expect(sn).to be_valid
    expect(sn.pericopes[0].biblebook_name).to eq('Genesis')
  end

  it 'rejects a studynote with without a title' do
    expect(described_class.create(note: 'note')).not_to be_valid
  end

  it 'rejects a studynote with without a note' do
    expect(described_class.create(title: 'title')).not_to be_valid
  end
end
