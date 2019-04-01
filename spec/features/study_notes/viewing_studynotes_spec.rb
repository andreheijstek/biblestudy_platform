# frozen_string_literal: true

require 'rails_helper'

def check_results
  should_see t('item_created', item: Studynote.model_name.human)
  expect(ShowStudynotePage.new.author_field.text).to eq(user.username)
end

feature 'Users can view studynotes', js: true do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    @nsp = NewStudynotesPage.new
    @nsp.load
    @nsp.title_field.set('Titel')
    @nsp.pericopes[0].set('Jona 1:1 - 1:10')
    @nsp.studynote_field.set('Jona is bijzonder.')
  end

  scenario 'with a single pericope with valid attributes' do
    @nsp.submit_button.click

    check_results
  end

  # scenario 'with multiple pericopes with valid attributes' do
  #   @nsp.add_pericope_button.click
  #   @nsp.pericopes[1].set('Jona 2:1 - 2:10')
  #   @nsp.studynote_field.set('Jona is bijzonder.')
  #   @nsp.submit_button.click
  #
  #   check_results
  # end
end
