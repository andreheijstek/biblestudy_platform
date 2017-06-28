require "rails_helper"
require_relative "../../app/models/pericope_string"

describe PericopeString  do
  it "should parse a pericope-string into a simple biblebook_name" do
    ps = PericopeString.new("Genesis 1:2-3:4")
    expect(ps.biblebook_name).to eq("Genesis")
  end

  it "should parse a pericope-string into a complex biblebook_name" do
    ps = PericopeString.new("1 Samuel 1:2-3:4")
    expect(ps.biblebook_name).to eq("1 Samuel")
  end

  it "should parse a pericope-string with unicode characters" do
    ps = PericopeString.new("1 Korintiërs 1:1 - 1:10")
    expect(ps.biblebook_name).to eq("1 Korintiërs")
  end

  it "should parse complete verses with different chapters into its parts" do
    ps = PericopeString.new("Genesis 1:2-3:4")
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(3)
    expect(ps.ending_verse).to     eq(4)
  end

  it "should parse complete verses with different chapters into its parts" do
    ps = PericopeString.new("Genesis 2:20-3:4")
    expect(ps.starting_chapter).to eq(2)
    expect(ps.starting_verse).to   eq(20)
    expect(ps.ending_chapter).to   eq(3)
    expect(ps.ending_verse).to     eq(4)
  end

  it "should parse complete verses with same chapters into its parts" do
    ps = PericopeString.new("Genesis 1:2-1:4")
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(4)
  end

  it "should parse verses where the chapter is not repeated into its parts" do
    ps = PericopeString.new("Genesis 1:2-4")
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(4)
  end

  it "should parse verses where the pericope is just a single verse" do
    ps = PericopeString.new("Genesis 1:2")
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(2)
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(2)
  end

  it "should parse verses where the pericope is just a single chapter" do
    ps = PericopeString.new("Genesis 1")
    expect(ps.starting_chapter).to eq(1)
    expect(ps.starting_verse).to   eq(0)  # or set to 1?
    expect(ps.ending_chapter).to   eq(1)
    expect(ps.ending_verse).to     eq(0)  # or look up the number of verses in this chapter and enter the last one here?
  end

  it "should parse verses where the pericope is the whole biblebook" do
    ps = PericopeString.new("Genesis")
    expect(ps.starting_chapter).to eq(0)
    expect(ps.starting_verse).to   eq(0)
    expect(ps.ending_chapter).to   eq(0)
    expect(ps.ending_verse).to     eq(0)
  end
end
