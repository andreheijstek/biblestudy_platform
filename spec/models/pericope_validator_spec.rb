# frozen_string_literal: true

describe PericopeValidator do
  before do
    create(:biblebook, name: 'Genesis', abbreviation: 'gen')
    create(:biblebook, name: 'Ezechiel', abbreviation: 'eze')
    create(:biblebook, name: 'Ezra', abbreviation: 'ezr')
  end

  it 'accepts a pericope of one verse' do
    pericope = Pericope.create(name: 'gen 1:1')
    expect(pericope).to be_valid
  end

  it 'finds the right biblebook' do
    pericope = Pericope.create(name: 'gen 1:1')
    expect(pericope.biblebook_name).to eq('Genesis')
  end

  it 'detects ambiguous biblebooks' do
    pericope = Pericope.create(name: 'ez 1:1')
    expect(pericope.errors.messages[:biblebook_name].first).to include(
      'niet duidelijk'
    )
  end
end
