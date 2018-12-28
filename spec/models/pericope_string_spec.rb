# frozen_string_literal: true

require 'rails_helper'
require_relative '../../app/models/pericope_string'

describe PericopeString do
  it 'parses into a simple biblebook_name' do
    ps = described_class.new('Genesis 1:2-3:4')
    expect(ps.biblebook_name).to eq('Genesis')
    expect(ps.errors[0]).to be_nil
  end

  it 'parsea into a complex biblebook_name' do
    ps = described_class.new('1 Samuel 1:2-3:4')
    expect(ps.biblebook_name).to eq('1 Samuel')
    expect(ps.errors[0]).to be_nil
  end

  it 'parses with unicode characters' do
    ps = described_class.new('1 Korintiërs 1:1 - 1:10')
    expect(ps.biblebook_name).to eq('1 Korintiërs')
    expect(ps.errors[0]).to be_nil
  end

  it 'parses different chapters into its parts when given all elements' do
    ps = described_class.new('Genesis 1:2-3:4')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(3)
    expect(ps.ending_verse).to     eq(4)
    expect(ps.errors[0]).to be_nil
  end

  it 'parses when some contain 2 digits' do
    ps = described_class.new('Genesis 2:20-3:4')
    expect(ps.starting_chapter).to eq(2)
    expect(ps.starting_verse).to   eq(20)
    expect(ps.ending_chapter).to   eq(3)
    expect(ps.ending_verse).to     eq(4)
    expect(ps.errors[0]).to be_nil
  end

  it 'parses when some contain 3 digits' do
    ps = described_class.new('Psalm 119:1-176')
    expect(ps.starting_chapter).to eq(119)
    expect(ps.starting_verse).to   eq(1)
    expect(ps.ending_chapter).to   eq(119)
    expect(ps.ending_verse).to     eq(176)
    expect(ps.errors[0]).to be_nil
  end

  it 'parses when multiple items contain 2 digits' do
    ps = described_class.new('Efeze 5:22-33')
    expect(ps.starting_chapter).to eq(5)
    expect(ps.starting_verse).to   eq(22)
    expect(ps.ending_chapter).to   eq(5)
    expect(ps.ending_verse).to     eq(33)
    expect(ps.errors[0]).to be_nil
  end

  it 'parses same chapter different verses fully spelled-out' do
    ps = described_class.new('Genesis 1:2-1:4')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(4)
    expect(ps.errors[0]).to be_nil
  end

  it 'parses same chanpter different verses shortened' do
    ps = described_class.new('Genesis 1:2-4')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(4)
    expect(ps.errors[0]).to be_nil
  end

  it 'parses verses where the pericope is just a single verse' do
    ps = described_class.new('Genesis 1:2')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(2)
    expect(ps.errors[0]).to be_nil
  end

  it 'parses verses where the pericope is just a single chapter' do
    ps = described_class.new('Genesis 1')
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(0)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(0)
    expect(ps.errors[0]).to be_nil
  end

  it 'parses verses where the pericope is the whole biblebook' do
    ps = described_class.new('Genesis')
    expect(ps.starting_chapter).to eq(0)
    expect(ps.starting_verse).to   eq(0)
    expect(ps.ending_chapter).to   eq(0)
    expect(ps.ending_verse).to     eq(0)
    expect(ps.errors[0]).to be_nil
  end
end
