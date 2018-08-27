# frozen_string_literal: true

require 'rails_helper'

feature 'When studynotes are created, there is also an audit trail', js: true do
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

  scenario 'showing the author', :focus do
    within('#studynote') do
      should_see "#{t('author')} #{user.username}"
    end
  end

  scenario 'showing creation date', :focus do
    should_see t('item_created', item: Studynote.model_name.human)
  end
end
