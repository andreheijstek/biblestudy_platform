# frozen_string_literal: true

describe BiblebookName do

  it 'creates Names from strings that represent a real biblebook' do
    name = BiblebookName.create("Genesis")
    expect(name.class).to eq(BiblebookName)
  end

  it 'creates Names from lowercase strings that represent a real biblebook ' do
    name = BiblebookName.create("genesis")
    expect(name.class).to eq(BiblebookName)
  end

  it 'creates Names from uppercase strings that represent a real biblebook ' do
    name = BiblebookName.create("GENESIS")
    expect(name.class).to eq(BiblebookName)
  end

  it 'creates Names from multiple strings that represent a real biblebook' do
    name = BiblebookName.create("1 Johannes")
    expect(name.class).to eq(BiblebookName)
  end

  it 'creates Names from multiple lowercase strings that represent a real biblebook' do
    name = BiblebookName.create("1 johannes")
    expect(name.class).to eq(BiblebookName)
  end

  it 'creates an UnknownBiblebook object for unknown strings' do
    name = BiblebookName.create("nonsense")
    expect(name.class).to eq(UnknownBiblebookName)
  end

  it 'creates Names from official abbreviations' do
    name = BiblebookName.create("gen")
    expect(name.class).to eq(BiblebookName)
  end

  it 'creates Names from uppercase official abbreviations' do
    name = BiblebookName.create("GEN")
    expect(name.class).to eq(BiblebookName)
  end

  it 'creates Names from inofficial abbreviations' do
    name = BiblebookName.create("genes")
    expect(name.class).to eq(BiblebookName)
  end
end
