# frozen_string_literal: true

require 'rails_helper'

feature 'Users can create new studynotes and associate them to pericopes', js: true do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)

    NewStudynotesPage.new.tap do |nsp|
      nsp.load
      nsp.title_field.set('Titel')
      nsp.studynote_field.set('Jona is bijzonder.')
      nsp.pericope1_field.set('Jona 1:1 - 1:10')
      nsp.commit_button.click
    end
    submit_form
  end

  scenario 'showing who created', :focus do
    within('#studynote') do
      should_see "#{t('author')} #{user.username}"
    end
  end

  scenario 'confirming creation', :focus do
    should_see t('item_created', item: Studynote.model_name.human)
  end
end
