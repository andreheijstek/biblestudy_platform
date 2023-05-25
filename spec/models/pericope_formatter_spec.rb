# frozen_string_literal: true

describe PericopeFormatter, type: :model do
  let!(:genesis) { create(:biblebook, name: "Genesis") }
  let!(:chap1) do
    create(:chapter, chapter_number: 1, nrofverses: 3, biblebook_id: genesis.id)
  end
  let!(:chap2) do
    create(
      :chapter,
      chapter_number: 2,
      nrofverses: 10,
      biblebook_id: genesis.id
    )
  end

  it "formats a single verse" do
    p = Pericope.create(name: "gen 1:1")
    f = described_class.new(p).format
    expect(f).to eq("Genesis 1:1 - 1:1")
  end

  it "formats a single chapter" do
    p = Pericope.create(name: "gen 1")
    f = described_class.new(p).format
    expect(f).to eq("Genesis 1:1 - 1:3")
  end

  it "formats a whole biblebook" do
    p = Pericope.create(name: "gen")
    f = described_class.new(p).format
    expect(f).to eq("Genesis 1:1 - 2:10")
  end

  it "formats a full pericope" do
    p = Pericope.create(name: "gen 1:2-3:4")
    f = described_class.new(p).format
    expect(f).to eq("Genesis 1:2 - 3:4")
  end

  it "formats a multiple full chapters" do
    p = Pericope.create(name: "gen 1-2")
    f = described_class.new(p).format
    expect(f).to eq("Genesis 1:1 - 2:10")
  end
end
