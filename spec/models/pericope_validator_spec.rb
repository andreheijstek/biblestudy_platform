# frozen_string_literal: true
require 'rails_helper'

describe 'PericopeValidator' do
  let!(:gen) { create(:biblebook, name: 'Genesis', abbreviation: 'Gen') }

  it 'accepts a pericope of one verse' do
    pericope = Pericope.new(name: 'gen 1:1')
    pericope.name = 'gen 1:1' # TODO: Hier gaat het mis. Als ik een .new doe (of .create)
    # dan gaat het goed, de hele initialize wordt aangeroepen en vermoedelijk ook de validator
    # maar als ik alleen een setter gebruik gebeurt dat natuurlijk niet!

    # validator = PericopeValidator.new
    # validator.validate(pericope)
    # expect(pericope.valid?).to eq(true)
    expect(pericope).to be_valid
  end
end
