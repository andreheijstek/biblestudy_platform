# frozen_string_literal: true

require 'rails_helper'

feature 'Users can create new studynotes and associate them to pericopes' do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path

    click_link t(:new_studynote)

    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    fill_in t('simple_form.labels.studynote.note'), with: 'Jona is bijzonder.'
  end

  scenario 'showing who created' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1",
            with: 'Jona 1:1 - 1:10'

    submit_form

    should_see t('item_created', item: Studynote.model_name.human)
    within('#studynote') do
      should_see "#{t('author')} #{user.username}"
    end
  end

  # TODO: Add test for showing who made the update
end
