# frozen_string_literal: true

require 'rails_helper'

feature 'Users can delete pericopes' do
  let(:user) { create(:user) }
  let(:studynote) do
    create(:studynote,
           pericope: 'Jona 1:1-5',
           title: 'Jona met 1 perikoop',
           note: 'zomaar iets')
  end

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path
    click_link t(:new_studynote)

    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    fill_in t('simple_form.labels.studynote.note'), with: 'Jona is bijzonder.'
  end

  scenario 'it should be possible to delete a pericope', js: true do
    click_on 'Voeg nog een perikoop toe'
    wait_for_ajax
    should_see 'perikoop 2'
    fill_in 'perikoop 2', with: 'Jona 2:20 - 3:3'
    within all('.input-group-btn')[1] do
      click_link 'delete_pericope'
    end
    should_not_see 'perikoop 2'
  end
end
