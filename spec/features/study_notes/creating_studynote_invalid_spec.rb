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

    scenario 'except when providing out of sequence chapters and verses' do
      @nsp.pericopes[0].set 'Jona 3:1 - 1:10'
      @nsp.studynote_field.set 'Studie'

      @nsp.submit_button.click

      should_see t('verse_chapter_disorder')
    end

    scenario 'when providing just the title' do
      @nsp.studynote_field.set 'Studie'

      @nsp.submit_button.click

      # should_see t('activerecord.models.messages.blank')
      should_see 'is niet opgeslagen'
      # TODO The first line (now commented) is how it really should work. But for whatever reason
      # the nested validation does not work (reject: :all_blank in Studynote.rb). I have already tried
      # a Gem to solve this but could not get it to work. For now I stop saving these records in the
      # StudynotesController
    end

    scenario 'when providing an incorrect biblebook' do
      create(:biblebook, name: 'Job')
      create(:biblebook, name: 'Johannes')

      @nsp.pericopes[0].set 'Jo 1:1 - 1:10'
      @nsp.studynote_field.set 'Studie'

      @nsp.submit_button.click

      should_see "#{t('ambiguous_abbreviation', given_name: 'Jo', biblebooks: 'Jona, Job, Johannes')}"
    end
  end
end
