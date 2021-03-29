# frozen_string_literal: true

describe PericopeFormatter, type: :model do
  let!(:genesis) { create(:biblebook, name: 'Genesis') }
  let!(:chap1) { create(:chapter, chapter_number: 1, nrofverses: 3, biblebook_id: genesis.id)}
  let!(:chap2) { create(:chapter, chapter_number: 2, nrofverses: 10, biblebook_id: genesis.id)}

  it 'formats a single verse' do
    p = Pericope.create(name: 'gen 1:1')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1:1 - 1:1')
  end

  it 'formats a single chapter' do
    p = Pericope.create(name: 'gen 1')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1:1 - 1:3')
  end

  it 'formats a whole biblebook' do
    p = Pericope.create(name: 'gen')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1:1 - 2:10')
  end

  it 'formats a full pericope' do
    p = Pericope.create(name: 'gen 1:2-3:4')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1:2 - 3:4')
  end

  it 'formats a multiple full chapters' do
    p = Pericope.create(name: 'gen 1-2')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1:1 - 2:10')
  end
end
