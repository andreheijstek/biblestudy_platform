# frozen_string_literal: true
require 'rails_helper'

feature 'Users can delete pericopes' do
  let(:user) {create(:user)}
  let(:studynote) do
    create(:studynote,
           pericope: 'Jona 1:1-5',
           title: 'Jona met 1 pericoop',
           note: 'zomaar iets')
  end

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path
    click_link t(:new_studynote)
  end

  scenario 'it should be possible to delete a pericope', js: true do
    click_on 'Voeg nog een pericoop toe'
    should_see 'pericoop 2'
    fill_in 'pericoop 2', with: 'Jona 2:20 - 3:3'
    save_and_open_page
    # vooraf moet er al een sn met 2 pericopen zijn (let)
    # daar ga ik naartoe, visit :deze_sn
    # daarvan delete ik er 1 (pericoop)
    # dat moet dan goed gaan, dus in de show zie ik nog maar 1 pericoop, message=succes
    # expect(true).to eq(false)
  end
end

