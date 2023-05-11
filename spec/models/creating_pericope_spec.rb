# frozen_string_literal: true

describe Pericope do
  let(:user) { create(:user) }

  before { create(:biblebook, name: 'Genesis') }

  it 'with valid and full attributes' do
    pericope = described_class.create(name: 'Genesis 3:4-5:6')
    expect(pericope).to be_valid
    expect(pericope.name).to eq('Genesis 3:4 - 5:6')
    expect(pericope.start_verse.chapter).to be(3)
    expect(pericope.start_verse.verse).to be(4)
    expect(pericope.end_verse.chapter).to be(5)
    expect(pericope.end_verse.verse).to be(6)
    expect(pericope.biblebook.name).to eq('Genesis')
  end

  it 'with valid and abbreviated attributes' do
    pericope = described_class.create(name: 'Gen 3:4-5:6')
    expect(pericope.biblebook.name).to eq('Genesis')
    expect(pericope).to be_valid
  end
end
