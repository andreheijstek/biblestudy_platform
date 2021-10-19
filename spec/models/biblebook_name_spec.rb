# frozen_string_literal: true

describe BiblebookName do

  it 'creates Names from strings that represent a real biblebook' do
    name = BiblebookName.create("Genesis")
    expect(name.class).to eq(BiblebookName)
  end

  it 'creates an UnknownBiblebook object for unknown strings' do
    name = BiblebookName.create("nonsense")
    expect(name.class).to eq(UnknownBiblebookName)
  end
end
