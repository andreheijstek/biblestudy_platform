# frozen_string_literal: true

describe 'Users can view an overview of all studynotes' do
  let!(:user) { create(:user) }

  let(:sno) { StudynotesOverviewPage.new }

  let!(:book_jona) do
    create(:biblebook,
           name:         'Jona',
           testament:    'oud',
           booksequence: 34)
  end

  let!(:book_handelingen) do
    create(:biblebook,
           name:         'Handelingen',
           testament:    'nieuw',
           booksequence: 53)
  end

  let!(:study_jona) do
    create(:studynote,
           title:  'Jona',
           note:   'Jona is bijzonder.',
           author: user)
  end
  let!(:pericope_jona) do
    create(:pericope,
           name:         'Jona 1:1 - 1:10',
           biblebook_id: book_jona.id,
           studynote_id: study_jona.id)
  end

  let!(:study_hand1) do
    create(:studynote,
           title:  'Handelingen later',
           note:   'Handelingen ook.',
           author: user)
  end
  let!(:pericope_hand1) do
    create(:pericope,
           name:         'Handelingen 1:2 - 1:10',
           biblebook_id: book_handelingen.id,
           studynote_id: study_hand1.id)
  end

  let!(:study_hand2) do
    create(:studynote,
           title:  'Handelingen eerst',
           note:   'Handelingen ook.',
           author: user)
  end
  let!(:pericope_hand2) do
    create(:pericope,
           name:         'Handelingen 1:1 - 1:10',
           biblebook_id: book_handelingen.id,
           studynote_id: study_hand2.id)
  end

  let!(:study_hand3) do
    create(:studynote,
           title:  'Handelingen alles',
           note:   'Handelingen ook.',
           author: user)
  end
  let!(:pericope_hand3) do
    create(:pericope,
           name:         'Handelingen',
           biblebook_id: book_handelingen.id,
           studynote_id: study_hand3.id)
  end

  before do
    visit pericopes_path
    sno.load
  end

  scenario 'showing the number of studynotes per biblebook' do
    page.click_on('Oude Testament')
    should_see 'Jona (1)'

    page.click_on('Nieuwe Testament')
    should_see 'Handelingen (3)'
  end

  scenario 'sorted by chapter number' do
    expect('Handelingen eerst').to appear_before('Handelingen later')
    expect('Handelingen alles').to appear_before('Handelingen eerst')
  end

  scenario 'grouped by biblebook' do

    books = sno.biblebooks
    jona = books[0]
    handelingen = books[1]
    sn = sno.studynotes

    expect(handelingen.text).to start_with('Handelingen')
    expect(sn[1].text).to include('Handelingen')

    within(handelingen) do
        should_not_see 'Jona is bijzonder.'
        should_see 'Handelingen'
    end

    within(jona) do
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
