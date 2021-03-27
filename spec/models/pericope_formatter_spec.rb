# frozen_string_literal: true

describe PericopeFormatter, type: :model do
  let!(:genesis) { create(:biblebook_with_chapters, name: 'Genesis') }
  let!(:chap) { create(:chapter, chapter_number: 2, nrofverses: 10, biblebook_id: genesis)}

  it 'formats a single verse' do
    p = Pericope.create(name: 'gen 1:1')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1:1')
  end

  it 'formats a single chapter' do
    p = Pericope.create(name: 'gen 1')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1')
  end

  it 'formats a single biblebook' do
    p = Pericope.create(name: 'gen')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis')
  end

  it 'formats a full pericope' do
    p = Pericope.create(name: 'gen 1:2-3:4')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1:2 - 3:4')
  end

  it 'formats a multiple full chapters' do
    p = Pericope.create(name: 'gen 1-2')
    f = PericopeFormatter.new(p).format
    expect(f).to eq('Genesis 1 - 2')
  end
end
