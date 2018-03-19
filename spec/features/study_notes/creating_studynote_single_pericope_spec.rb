# frozen_string_literal: true

require 'rails_helper'

describe 'Users can create new studynotes and associate them to pericopes' do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path

    click_link t(:new_studynote)

    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    fill_in t('simple_form.labels.studynote.note'), with: 'Jona is bijzonder.'
  end

  it 'to a single pericopes with valid attributes' do
    fill_and_submit('Jona 1:1 - 1:10')

    should_see 'Jona 1:1 - 10'
  end

  it 'to a single pericopes containing one complete chapter' do
    fill_and_submit('Jona 1')

    should_see 'Jona 1'
    should_not_see 'Jona 1:0'
  end

  it 'to a single pericopes containing one complete biblebook' do
    fill_and_submit('Jona')

    should_see 'Jona'
    should_not_see 'Jona 0'
  end

  it 'to a single pericope with just one single verse' do
    fill_and_submit('Jona 1:1')

    should_see 'Jona 1:1'
  end

  def fill_and_submit(pericope)
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: pericope
    submit_form
  end
end
