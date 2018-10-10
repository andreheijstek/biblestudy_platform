# frozen_string_literal: true

require 'rails_helper'

feature 'Users can delete pericopes', js: true do
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

    @nsp = NewStudynotesPage.new
    @nsp.load
    @nsp.title_field.set('Titel')
    @nsp.studynote_field.set('Jona is bijzonder.')
  end

  scenario 'it should be possible to delete a pericope' do
    @nsp.pericopes[0].set('Jona 1:1 - 1:10')
    @nsp.add_pericope_button.click
    @nsp.pericopes[1].set('Jona 2:20 - 3:3')

    @nsp.remove_pericope_button[0].click
    should_not_see 'perikoop 2'
  end
end
