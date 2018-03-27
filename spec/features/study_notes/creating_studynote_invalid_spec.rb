# frozen_string_literal: true

require 'rails_helper'

feature 'Users can not create new studynotes' do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path
    click_link t(:new_studynote)
  end

  scenario 'when providing no attributes' do
    submit_form
    should_see t('activerecord.models.messages.blank')
  end

  context 'with incorrect data' do
    before do
      fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    end

    scenario 'except when providing out of sequence chapters and verses' do
      fill_in "#{t('simple_form.labels.pericopes.name')} 1",
              with: 'Jona 3:1 - 1:10'
      fill_in t('simple_form.labels.studynote.note'), with: 'Jona is bijzonder.'
      submit_form
      should_see t('starting_greater_than_ending')
    end

    scenario 'when providing just the title' do
      submit_form
      should_see t('activerecord.models.messages.blank')
    end

    scenario 'when providing an incorrect biblebook' do
      create(:biblebook, name: 'Job')
      create(:biblebook, name: 'Johannes')

      fill_in "#{t('simple_form.labels.pericopes.name')} 1",
              with: 'Jo 1:1 - 1:10'
      fill_in t('simple_form.labels.studynote.note'),
              with: 'Jona of Job of Johannes?'

      submit_form

      should_see "#{t('ambiguous_abbreviation')}: 'Jo' kan "
      should_see 'Jona'
      should_see 'Job'
      should_see 'Johannes'
    end
  end
end
