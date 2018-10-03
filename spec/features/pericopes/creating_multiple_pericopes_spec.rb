# frozen_string_literal: true

require 'rails_helper'

feature 'Users can add multiple pericopes to a studynote', focus: true do
  let(:user) { create(:user) }

    scenario 'to multiple pericopes with valid attributes', js: true do

    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path # is dit nog nodig als er ook een nsp.load is?

    nsp = NewStudynotesPage.new
    nsp.load
    nsp.title_field.set('Titel')
    nsp.studynote_field.set('Jona is bijzonder.')
    nsp.pericopes[0].add_pericope_button.click
    byebug
    nsp.pericopes[0].pericope_field.set('Jona 1:1 - 1:10')
    nsp.pericopes[0].add_pericope_button.click

    nsp.pericopes[1].pericope_field.set('Jona 2:20 - 3:3')
    nsp.submit_button.click
    # submit_form

    expect(StudynoteShowPage.new.pericope_field.text).to eq('Jona 1:1 - 10 | Jona 2:20 - 3:3')
  end
end
