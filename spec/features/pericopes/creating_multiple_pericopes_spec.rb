# frozen_string_literal: true

require 'rails_helper'

feature 'Users can add multiple pericopes to a studynote' do
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
    # fill_in 'pericoop 1', with: 'Jona 1:1 - 1:10'
    # click_on 'Voeg nog een pericoop toe'
    # fill_in 'pericoop 2', with: 'Jona 2:20 - 3:3'
    #
    # submit_form
    #
    # should_see 'Jona 1:1 - 10 | Jona 2:20 - 3:3'
  end
end
