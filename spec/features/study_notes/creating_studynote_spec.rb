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

  scenario 'showing who did the update' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jona 1:1 - 1:10'

    submit_form

    should_see t('item_created', item: Studynote.model_name.human)
    within('#studynote') do
      should_see "#{t('author')}: #{user.username}"
    end
  end

  scenario 'to a single pericopes with valid attributes' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jona 1:1 - 1:10'

    submit_form

    should_see 'Jona 1:1 - 10'
  end

  scenario 'to a single pericopes with valid attributes, containing one complete chapter' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jona 1'

    submit_form

    should_see 'Jona 1'
    should_not_see 'Jona 1:0'
  end

  scenario 'to a single pericopes with valid attributes, containing one complete biblebook' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jona'

    submit_form

    should_see 'Jona'
    should_not_see 'Jona 0'
  end

  scenario 'to a single pericope with just one single verse' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jona 1:1'

    submit_form

    should_see 'Jona 1:1'
  end

  context 'abbreviated biblebooks' do
    before do
      create(:biblebook, name: 'Genesis',      abbreviation: 'Gen')
      create(:biblebook, name: 'Exodus',       abbreviation: 'Ex')
      create(:biblebook, name: '1 Koningen',   abbreviation: '1 Kon')
      create(:biblebook, name: '1 Kronieken',  abbreviation: '1 Kron')
      create(:biblebook, name: '1 Korintiërs', abbreviation: '1 Kor')
      create(:biblebook, name: '2 Korintiërs', abbreviation: '2 Kor')
    end

    examples = [
      # [pericope, title, studynote] => method_result
      { inputs: 'Gen 1:1 - 1:10',           expected: 'Genesis 1:1 - 10' },
      { inputs: 'gen 1:1 - 1:10',           expected: 'Genesis 1:1 - 10' },
      { inputs: 'Ex 1:1 - 1:10',            expected: 'Exodus 1:1 - 10' },
      { inputs: '1 Kon 1:1 - 1:10',         expected: '1 Koningen 1:1 - 10' },
      { inputs: '1 Kron 1:1 - 1:10',        expected: '1 Kronieken 1:1 - 10' },
      { inputs: '1 Kor 1:1 - 1:10',         expected: '1 Korintiërs 1:1 - 10' },
      { inputs: '1 kor 1:1 - 1:10',         expected: '1 Korintiërs 1:1 - 10' },
      { inputs: '1 Korintiërs 1:1 - 1:10',  expected: '1 Korintiërs 1:1 - 10' },
      { inputs: '1 Korintiers 1:1 - 1:10',  expected: '1 Korintiërs 1:1 - 10' },
      { inputs: '1 Korinthiërs 1:1 - 1:10', expected: '1 Korintiërs 1:1 - 10' },
      { inputs: '1 Korinthiers 1:1 - 1:10', expected: '1 Korintiërs 1:1 - 10' },
      { inputs: '2 Kor 1:1 - 1:10',         expected: '2 Korintiërs 1:1 - 10' }
    ]
    examples.each do |example|
      it "should add a studynote with a correctly abbreviated biblebook #{example[:inputs]} as #{example[:expected]}" do
        fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: (example[:inputs]).to_s

        submit_form

        should_see t(:item_created, item: Studynote.model_name.human)
        within('#studynote') do
          should_see (example[:expected]).to_s
        end
      end
    end
  end

  #   scenario 'to multiple pericopes with valid attributes', js: true do
  #     fill_in 'pericoop 1', with: 'Jona 1:1 - 1:10'
  #     click_on 'Voeg nog een pericoop toe'
  #     should_see 'pericoop 2'
  #     fill_in 'pericoop 2', with: 'Jona 2:20 - 3:3'
  #
  #     submit_form
  #
  #     should_see 'Jona 1:1 - 10 | Jona 2:20 - 3:3 |'
  #   end
end

feature 'Users can not create new studynotes and associate them to pericopes' do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)
    visit studynotes_path
    click_link t(:new_studynote)
  end

  scenario 'when providing no attributes' do
    submit_form
    should_see t(:item_not_created, item: Studynote.model_name.human)
    should_see t('activerecord.models.messages.blank')
  end

  scenario 'when providing out of sequence chapters and verses' do
    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jona 3:1 - 1:10'
    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    fill_in t('simple_form.labels.studynote.note'), with: 'Jona is bijzonder.'
    submit_form
    should_see t(:item_not_created, item: Studynote.model_name.human)
    should_see t('starting_greater_than_ending')
  end

  scenario 'when providing just the title' do
    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    submit_form
    should_see t(:item_not_created, item: Studynote.model_name.human)
    should_see t('activerecord.models.messages.blank')
  end

  scenario 'except when providing an incorrect biblebook' do
    create(:biblebook, name: 'Job')
    create(:biblebook, name: 'Johannes')

    fill_in "#{t('simple_form.labels.pericopes.name')} 1", with: 'Jo 1:1 - 1:10'
    fill_in t('simple_form.labels.studynote.title'), with: 'Titel'
    fill_in t('simple_form.labels.studynote.note'), with: 'Jona of Job of Johannes?'

    submit_form

    should_see t(:item_not_created, item: Studynote.model_name.human)
    should_see "#{t('ambiguous_abbreviation')}: 'Jo' kan "
    should_see 'Jona'
    should_see 'Job'
    should_see 'Johannes'
  end
end
