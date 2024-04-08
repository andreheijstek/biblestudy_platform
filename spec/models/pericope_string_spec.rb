# frozen_string_literal: true

describe PericopeString do
  let(:pericope) { described_class.new('Genesis 1:2-3:4') }

  it 'creates an object based on a pericope string' do
    expect(pericope.class).to eq(described_class)
  end

  it 'returns a string version of the pericope object' do
    expect(pericope.to_s).to eq('Genesis 1:2-3:4')
  end

  it 'returns the biblebook part' do
    expect(pericope.biblebook).to eq('Genesis')
  end

  it 'returns the first chapter' do
    expect(pericope.first_chapter).to eq(1)
  end

  it 'returns the first verse' do
    expect(pericope.first_verse).to eq(2)
  end

  it 'returns the last chapter' do
    expect(pericope.last_chapter).to eq(3)
  end

  it 'returns the last verse' do
    expect(pericope.last_verse).to eq(4)
  end
end
