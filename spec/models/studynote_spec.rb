require 'rails_helper'

describe 'Studynote', type: :model do

  before do
    create(:biblebook, name: 'Genesis', abbreviation: 'Gen')
  end

  it 'should create a new studynote with valid and full attributes' do
    expect(Studynote.create(title: 'title', note: 'note')).to be_valid
  end

  it 'should create a new studynote with valid and full attributes also with new/save' do
    sn = Studynote.new(title: 'title', note: 'note')
    sn.save
    expect(sn).to be_valid
  end

  it 'should create a studynote with associated pericope' do
    sn = Studynote.new
    sn.pericopes.build
    sn = Studynote.new(title: 'title', note: 'note',
                       pericopes_attributes: [{name: 'Gen 1:2-3:4'}])
    expect(sn).to be_valid
  end

  it 'should reject a new studynote with without a title' do
    expect(Studynote.create(note: 'note')).to_not be_valid
  end

  it 'should reject a new studynote with without a note' do
    expect(Studynote.create(title: 'title')).to_not be_valid
  end

  it 'should create a new studynote and associated pericope with valid and full attributes' do
    sn = Studynote.create(title: 'title', note: 'note')
    pericope = sn.pericopes.create(name: 'Genesis 3:4-5:6')
    expect(sn).to be_valid
    expect(pericope).to be_valid
    expect(pericope.name).to eq('Genesis 3:4 - 5:6')
    expect(pericope.starting_chapter_nr).to be(3)
    expect(pericope.starting_verse).to be(4)
    expect(pericope.ending_chapter_nr).to be(5)
    expect(pericope.ending_verse).to be(6)
    expect(pericope.biblebook.name).to eq('Genesis')
    expect(sn.title).to eq('title')
  end


  it 'should create a new studynote and associated pericope with valid and abbreviated attributes' do
    sn = Studynote.create(title: 'title', note: 'note')
    pericope = sn.pericopes.create(name: 'Gen 3:4-5:6')
    expect(sn).to be_valid
    expect(pericope).to be_valid
  end
end
