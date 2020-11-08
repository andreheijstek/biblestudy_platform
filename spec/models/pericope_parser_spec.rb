# frozen_string_literal: true

require 'rspec'
require 'parslet/rig/rspec'
require_relative '../../app/models/pericope_parser'

describe PericopeParser do
  let(:parser) { described_class.new }

  it 'parses strings' do
    expect(parser.string).to parse('Genesis ')
  end

  it 'parses integers' do
    expect(parser.integer).to parse('1 ')
  end

  it 'parses colons' do
    expect(parser.colon).to parse(': ')
  end

  it 'parse dashes' do
    expect(parser.dash).to parse('-')
  end

  it 'parses simple biblebooks' do
    expect(parser.biblebook).to parse('Genesis')
  end

  it 'parses biblebooks with numbers' do
    expect(parser.biblebook).to parse('1 Genesis')
  end

  it 'parses chapters' do
    expect(parser.chapter).to parse('1')
  end

  it 'parses a whole book' do
    expect(parser.whole_book).to parse('Genesis')
  end

  it 'parses a whole chapter' do
    expect(parser.whole_chapter).to parse('Genesis 1')
  end

  it 'parses a single Biblebook' do
    tree = parser.pericope.parse('Genesis')
    expect(tree[:biblebook].to_s).to eq('Genesis')
  end

  it 'parses a single Chapter' do
    tree = parser.pericope.parse('Genesis 1')
  rescue Parslet::ParseFailed => e
    puts e.parse_failure_cause.ascii_tree
    expect(tree[:starting_chapter].to_i).to eq(1)
  end

  it 'parses a single Verse' do
    tree = parser.pericope.parse('Genesis 1:1')
    expect(tree[:starting_verse].to_i).to eq(1)
  end

  it 'parses a full Pericope' do
    tree = parser.pericope.parse('Genesis 1:2 - 3:4')
    expect(tree[:biblebook].to_s.strip).to eq('Genesis')
    expect(tree[:starting_chapter].to_i).to eq(1)
    expect(tree[:starting_verse].to_i).to eq(2)
    expect(tree[:ending_chapter].to_i).to eq(3)
    expect(tree[:ending_verse].to_i).to eq(4)
  end

  it 'parses biblebook like 1 Koningen' do
    tree = parser.pericope.parse('1 Koningen')
    expect(tree[:biblebook].to_s.strip).to eq('1 Koningen')
  end

  it 'parses a Pericope with multiple verses in 1 chapter' do
    tree = parser.pericope.parse('Genesis 1:2 - 3')
    expect(tree[:biblebook].to_s.strip).to eq('Genesis')
    expect(tree[:starting_chapter].to_i).to eq(1)
    expect(tree[:starting_verse].to_i).to eq(2)
    # expect(tree[:ending_chapter].to_i).to eq(1)
    expect(tree[:ending_verse].to_i).to eq(3)
  end

  it 'parses a Pericope with multiple full chapters' do
    tree = parser.pericope.parse('Genesis 1 - 3')
    expect(tree[:biblebook].to_s.strip).to eq('Genesis')
    expect(tree[:starting_chapter].to_i).to eq(1)
    expect(tree[:ending_chapter].to_i).to eq(3)
  end

  it 'parses a Pericope with unicode characters' do
    tree = parser.pericope.parse('1 Korinthiërs')
    expect(tree[:biblebook].to_s.strip).to eq('1 Korinthiërs')
  end

  it 'parses a Pericope with multiple digit chapters' do
    tree = parser.pericope.parse('1 Korinthiërs 22')
    expect(tree[:starting_chapter].to_i).to eq(22)
  end

  # rubocop:disable Style/AsciiComments
  # it 'parses a Pericope with multiple digit verses' do
  #   tree = parser.pericope.parse('1 Korinthiërs 22:12_345')
  #   expect(tree[:starting_verse].to_i).to eq(12_345)
  # end
  # rubocop:enable Style/AsciiComments
end
