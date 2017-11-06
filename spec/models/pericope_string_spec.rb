require 'rails_helper'
require_relative '../../app/models/pericope_string'

describe PericopeString  do
  it 'should parse into a simple biblebook_name' do
    ps = PericopeString.new('Genesis 1:2-3:4')
    expect(ps.biblebook_name).to eq('Genesis')
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse into a complex biblebook_name' do
    ps = PericopeString.new('1 Samuel 1:2-3:4')
    expect(ps.biblebook_name).to eq('1 Samuel')
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse with unicode characters' do
    ps = PericopeString.new('1 Korintiërs 1:1 - 1:10')
    expect(ps.biblebook_name).to eq('1 Korintiërs')
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse different chapters into its parts when given all elements' do
    ps = PericopeString.new('Genesis 1:2-3:4')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(3)
    expect(ps.ending_verse).to     eq(4)
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse when some contain 2 digits' do
    ps = PericopeString.new('Genesis 2:20-3:4')
    expect(ps.starting_chapter).to eq(2)
    expect(ps.starting_verse).to   eq(20)
    expect(ps.ending_chapter).to   eq(3)
    expect(ps.ending_verse).to     eq(4)
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse when some contain 3 digits' do
    ps = PericopeString.new('Psalm 119:1-176')
    expect(ps.starting_chapter).to eq(119)
    expect(ps.starting_verse).to   eq(1)
    expect(ps.ending_chapter).to   eq(119)
    expect(ps.ending_verse).to     eq(176)
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse when multiple items contain 2 digits' do
    ps = PericopeString.new('Efeze 5:22-33')
    expect(ps.starting_chapter).to eq(5)
    expect(ps.starting_verse).to   eq(22)
    expect(ps.ending_chapter).to   eq(5)
    expect(ps.ending_verse).to     eq(33)
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse same chapter different verses fully spelled-out' do
    ps = PericopeString.new('Genesis 1:2-1:4')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(4)
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse same chanpter different verses shortened' do
    ps = PericopeString.new('Genesis 1:2-4')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(4)
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse verses where the pericope is just a single verse' do
    ps = PericopeString.new('Genesis 1:2')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(2)
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse verses where the pericope is just a single chapter' do
    ps = PericopeString.new('Genesis 1')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(0)  # or set to 1?
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(0)  # or look up the number of verses in this chapter and enter the last one here?
    expect(ps.errors[0]).to be_nil
  end

  it 'should parse verses where the pericope is the whole biblebook' do
    ps = PericopeString.new('Genesis')
    expect(ps.starting_chapter).to eq(0)
    expect(ps.starting_verse).to   eq(0)
    expect(ps.ending_chapter).to   eq(0)
    expect(ps.ending_verse).to     eq(0)
    expect(ps.errors[0]).to be_nil
  end

  it 'should recognize that verses are out of order' do
    ps = PericopeString.new('Genesis 1:4-1:2')
    expect(ps.errors[0]).to eq(I18n.t('starting_verse_chapter_mismatch'))
  end

  it 'should recognize that chapters are out of order' do
    ps = PericopeString.new('Genesis 2:4-1:2')
    expect(ps.errors[0]).to eq(I18n.t('starting_greater_than_ending'))
  end
end
