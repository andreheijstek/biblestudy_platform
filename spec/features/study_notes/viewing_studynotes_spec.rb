# frozen_string_literal: true

require 'rails_helper'

feature 'Users can view studynotes' do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path
    click_on t(:new_studynote)
  end

  scenario 'with a single pericope with valid attributes' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jona 1:1 - 1:10'
    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    fill_in t('simple_form.labels.studynote.note'), with: 'Jona is bijzonder.'

    submit_form

    should_see t('item_created', item: Studynote.model_name.human)
    within('#studynote') do
      should_see "#{t('author')} #{user.username}"
    end
  end

  scenario 'with multiple pericopes with valid attributes' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jona 1:1 - 1:10'
    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    fill_in t('simple_form.labels.studynote.note'), with: 'Jona is bijzonder.'

    submit_form

    should_see t('item_created', item: Studynote.model_name.human)
    within('#studynote') do
      should_see "#{t('author')} #{user.username}"
    end
  end
end
