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
    click_on t(:delete_item, item: Pericope.model_name.human)
    should_not_see 'pericoop 2'
  end
end

