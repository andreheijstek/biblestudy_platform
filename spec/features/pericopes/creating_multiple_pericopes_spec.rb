# frozen_string_literal: true

require 'rails_helper'

feature 'Users can add multiple pericopes to a studynote', :focus do
  let(:user) { create(:user) }

    scenario 'to multiple pericopes with valid attributes', js: true do

    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path

    NewStudynotesPage.new.tap do |nsp|
      nsp.load
      nsp.title_field.set('Titel')
      nsp.studynote_field.set('Jona is bijzonder.')
      nsp.pericope[0].pericope_field.set('Jona 1:1 - 1:10')
      nsp.add_pericope_button.click
      save_and_open_page

      binding.pry
      nsp.pericope[1].pericope_field.set('Jona 2:20 - 3:3')
      nsp.submit_button.click
    end
    # submit_form

    expect(StudynoteShowPage.new.pericope_field.text).to eq('Jona 1:1 - 10 | Jona 2:20 - 3:3')
  end
end
