# frozen_string_literal: true

require 'rails_helper'

feature 'Users can not create new studynotes', js: true do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)

    @nsp = NewStudynotesPage.new
    @nsp.load
  end

  scenario 'when providing no attributes' do
    @nsp.submit_button.click
    should_see t('activerecord.models.messages.blank')
  end

  context 'with incorrect data' do
    before do
      @nsp.title_field.set 'Titel'
    end

    scenario 'when providing out of sequence chapters and verses' do
      @nsp.pericopes[0].set 'Jona 3:1 - 1:10'
      @nsp.studynote_field.set 'Studie'

      @nsp.submit_button.click

      should_see t('activerecord.errors.models.pericope.attributes.name.verse_chapter_disorder')
    end

    scenario 'when providing just the title' do
      @nsp.studynote_field.set 'Studie'

      @nsp.submit_button.click

      should_see t('.item_not_created', item: Studynote.model_name.human)
    end

    scenario 'when providing an incorrect biblebook' do
      create(:biblebook, name: 'Job')
      create(:biblebook, name: 'Johannes')

      @nsp.pericopes[0].set 'Jo 1:1 - 1:10'
      @nsp.studynote_field.set 'Studie'

      @nsp.submit_button.click

      should_see "#{t('activerecord.errors.models.pericope.attributes.name.ambiguous_abbreviation', given_name: 'Jo', biblebooks: 'Jona, Job, Johannes')}"
    end
  end
end
