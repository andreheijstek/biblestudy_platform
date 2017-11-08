# frozen_string_literal: true

require 'rails_helper'

feature 'Users can view an overview of all studynotes' do
  let(:user) { create(:user) }
  let!(:book_jona)         { create(:biblebook, name: 'Jona', testament: 'oud', booksequence: 34) }
  let!(:book_maleachi)     { create(:biblebook, name: 'Maleachi', testament: 'oud', booksequence: 45) }
  let!(:book_mattheus)     { create(:biblebook, name: 'Mattheus', testament: 'nieuw', booksequence: 51) }
  let!(:book_openbaringen) { create(:biblebook, name: 'Openbaringen', testament: 'nieuw', booksequence: 66) }
  let!(:book_handelingen)  { create(:biblebook, name: 'Handelingen', testament: 'nieuw', booksequence: 53) }

  let!(:study_jona)        { create(:studynote, title: 'Jona', note: 'Jona is bijzonder.', author: user) }
  let!(:pericope_jona)     { create(:pericope, name: 'Jona 1:1 - 1:10', biblebook_id: book_jona.id, studynote_id: study_jona.id) }

  let!(:study_hand1)       { create(:studynote, title: 'Handelingen later', note: 'Handelingen ook.', author: user) }
  let!(:pericope_hand1)    { create(:pericope, name: 'Handelingen 1:2 - 1:10', biblebook_id: book_handelingen.id, studynote_id: study_hand1.id) }

  let!(:study_hand2)       { create(:studynote, title: 'Handelingen eerst', note: 'Handelingen ook.', author: user) }
  let!(:pericope_hand2)    { create(:pericope, name: 'Handelingen 1:1 - 1:10', biblebook_id: book_handelingen.id, studynote_id: study_hand2.id) }

  let!(:study_hand3)       { create(:studynote, title: 'Handelingen alles', note: 'Handelingen ook.', author: user) }
  let!(:pericope_hand3)    { create(:pericope, name: 'Handelingen', biblebook_id: book_handelingen.id, studynote_id: study_hand3.id) }

  before do
    visit pericopes_path
  end

  scenario 'Ordered by testament' do
    expect('Oude Testament').to appear_before('Nieuwe Testament')
  end

  scenario 'Grouped by biblebook' do
    page.click_on('Oude Testament')
    should_see 'Jona'
    should_see 'Maleachi'

    click_link 'Nieuwe Testament'
    should_see 'Mattheus'
    should_see 'Openbaringen'
  end

  scenario 'Showing the number of studynotes per testament' do
    should_see 'Oude Testament (1 bijbelstudie)'
    should_see 'Nieuwe Testament (3 bijbelstudies)'
  end

  scenario 'Showing the number of studynotes per biblebook' do
    page.click_on('Oude Testament')
    should_see 'Jona (1)'

    page.click_on('Nieuwe Testament')
    should_see 'Handelingen (3)'
  end

  scenario 'Containing studynotes' do
    page.click_on('Oude Testament')
    page.click_on('Jona')
    should_see 'Jona is bijzonder'
  end

  scenario 'sorted by biblebook name' do
    should_see 'Jona'
    should_see 'Handelingen'

    expect('Jona').to appear_before('Handelingen')
  end

  scenario 'sorted by chapter number' do
    expect('Handelingen eerst').to appear_before('Handelingen later')
    expect('Handelingen alles').to appear_before('Handelingen eerst')
  end

  scenario 'grouped by biblebook' do
    should_see 'Handelingen'
    within("//table[@id='Handelingen']") do
      should_not_see 'Jona is bijzonder.'
      should_see 'Handelingen'
    end

    should_see 'Jona'
    within("//table[@id='Jona']") do
      should_not_see 'Handelingen eerst'
      should_not_see 'Handelingen later'
      should_not_see 'Handelingen alles'
      should_see 'Jona'
    end
  end

  scenario 'and view the details of a studynote' do
    click_link 'Jona'
    should_see 'Jona is bijzonder'
  end

  scenario 'having the accordion open when there is content' do
    should_see 'Jona'
    should_see 'Handelingen eerst'
  end
end
