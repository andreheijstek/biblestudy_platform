# frozen_string_literal: true

describe PericopeString do
  let(:pericope) { described_class.new("Genesis 1:2-3:4") }

  it 'creates an object based on a pericope string' do
    expect(pericope.class).to eq(PericopeString)
  end

  it 'returns a string version of the pericope object' do
    expect(pericope.to_s).to eq("Genesis 1:2-3:4")
  end

  it 'returns the biblebook part' do

  end

  it 'returns the first chapter'
  it 'returns the first verse'
  it 'returns the last chapter'
  it 'returns the last verse'
  it 'reformats a partial pericope'
end
