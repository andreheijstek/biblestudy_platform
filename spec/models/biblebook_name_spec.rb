# frozen_string_literal: true

describe BiblebookName do
  it "creates Names from strings that represent a real biblebook" do
    name = BiblebookName.create("Genesis")
    expect(name.class).to eq(BiblebookName)
    expect(name.name).to eq("Genesis")
  end

  it "creates Names from lowercase strings that represent a real biblebook " do
    name = BiblebookName.create("genesis")
    expect(name.class).to eq(BiblebookName)
    expect(name.name).to eq("Genesis")
  end

  it "creates Names from uppercase strings that represent a real biblebook " do
    name = BiblebookName.create("GENESIS")
    expect(name.class).to eq(BiblebookName)
    expect(name.name).to eq("Genesis")
  end

  it "creates Names from multiple strings that represent a real biblebook" do
    name = BiblebookName.create("1 Johannes")
    expect(name.class).to eq(BiblebookName)
  end

  it "creates Names from multiple lowercase strings that represent a real biblebook" do
    name = BiblebookName.create("1 johannes")
    expect(name.class).to eq(BiblebookName)
    expect(name.name).to eq("1 Johannes")
  end

  it "creates an UnknownBiblebook object for unknown strings" do
    name = BiblebookName.create("nonsense")
    expect(name.class).to eq(UnknownBiblebookName)
    expect(name.name).to eq("Unknown biblebook")
  end

  it "creates Names from official abbreviations" do
    name = BiblebookName.create("gen")
    expect(name.class).to eq(BiblebookName)
    expect(name.name).to eq("Genesis")
  end

  it "creates Names from uppercase official abbreviations" do
    name = BiblebookName.create("GEN")
    expect(name.class).to eq(BiblebookName)
    expect(name.name).to eq("Genesis")
  end

  it "creates Names from inofficial abbreviations" do
    name = BiblebookName.create("genes")
    expect(name.class).to eq(BiblebookName)
    expect(name.name).to eq("Genesis")
  end

  it "rejects Names from ambiguous abbreviations" do
    name = BiblebookName.create("jo")
    expect(name.class).to eq(UnknownBiblebookName)
  end

  it "tells which biblebooks are possible with an ambiguous name" do
    names = BiblebookName.possible_booknames("jo")
    expect(names.length).to eq(8)
    expect(names).to include("Job")
    expect(names).to include("Johannes")
    expect(names).to include("Jona")
  end

  it "tells which biblebook is possible with an unambiguous name" do
    names = BiblebookName.possible_booknames("genesis")
    expect(names.length).to eq(1)
    expect(names).to include("Genesis")
  end
end
