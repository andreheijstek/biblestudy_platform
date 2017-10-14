require 'rails_helper'

describe 'PericopeValidator' do
  let!(:gen) { create(:biblebook, name: 'Genesis') }

  it 'accepts a pericope of one verse' do
    pericope = Pericope.new
    pericope.name = 'gen 1:1'

    validator = PericopeValidator.new
    validator.validate(pericope)
    expect(pericope.valid?).to eq(true)
  end
end
