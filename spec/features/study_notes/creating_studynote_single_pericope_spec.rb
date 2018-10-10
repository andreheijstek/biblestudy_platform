# frozen_string_literal: true

require 'rails_helper'

describe 'Users can create new studynotes and associate them to a single pericope', js: true do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)

    @nsp = NewStudynotesPage.new
    @nsp.load
  end

  it 'with valid attributes' do
    fill_and_submit('Jona 1:1 - 1:10')
    should_see 'Jona 1:1 - 10'
  end

  it 'containing one complete chapter' do
    fill_and_submit('Jona 1')

    should_see 'Jona 1'
    should_not_see 'Jona 1:0'
  end

  it 'containing one complete biblebook' do
    fill_and_submit('Jona')

    should_see 'Jona'
    should_not_see 'Jona 0'
  end

  it 'containing just one single verse' do
    fill_and_submit('Jona 1:1')

    should_see 'Jona 1:1'
  end

  def fill_and_submit(pericope)
    @nsp.pericopes[0].set pericope
    @nsp.title_field.set 'Titel'
    @nsp.studynote_field.set 'Jona is bijzonder.'
    @nsp.submit_button.click
  end
end
