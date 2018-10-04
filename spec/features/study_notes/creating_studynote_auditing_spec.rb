# frozen_string_literal: true

require 'rails_helper'

feature 'When studynotes are created, there is an audit trail', js: true, focus: true do
  let(:user) { create(:user) }

  scenario 'showing the author' do
    create(:biblebook, name: 'Jona')
    login_as(user)

    NewStudynotesPage.new.tap do |nsp|
      nsp.load
      nsp.title_field.set('Titel')
      nsp.studynote_field.set('Jona is bijzonder.')
      nsp.pericopes[0].set('Jona 1:1 - 1:10')
      nsp.submit_button.click
    end
    submit_form

    expect(StudynoteShowPage.new.author_field.text).to eq(user.username)
  end
end
