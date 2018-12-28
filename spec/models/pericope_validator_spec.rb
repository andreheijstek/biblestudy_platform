# frozen_string_literal: true

require 'rails_helper'

describe PericopeValidator do
  let!(:gen) { create(:biblebook, name: 'Genesis', abbreviation: 'gen') }

  it 'accepts a pericope of one verse' do
    pericope = Pericope.new(name: 'gen 1:1')
    expect(pericope).to be_valid
  end
end
