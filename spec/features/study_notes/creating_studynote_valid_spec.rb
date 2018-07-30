=begin
# frozen_string_literal: true

require 'rails_helper'

feature 'Users can create new studynotes and associate them to pericopes' do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path

    click_link t(:new_studynote)

    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    fill_in t('simple_form.labels.studynote.note'), with: 'Jona is bijzonder.'
  end

  scenario 'to multiple pericopes with valid attributes', js: true do
    fill_in 'perikoop 1', with: 'Jona 1:1 - 1:10'
    # button = find_by_id('add_pericope')
    # p button
    # result = button.click
    click_on 'Voeg nog een perikoop toe'
    # sleep(100)
    save_and_open_page
    fill_in 'perikoop 2', with: 'Jona 2:20 - 3:3'

    submit_form

    should_see 'Jona 1:1 - 10 | Jona 2:20 - 3:3'
  end
end
=end
