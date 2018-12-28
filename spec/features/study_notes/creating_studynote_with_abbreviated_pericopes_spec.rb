# frozen_string_literal: true

require 'rails_helper'

feature 'Users can create new studynotes and associate them to pericopes', js: true do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: 'Jona')
    login_as(user)

    @nsp = NewStudynotesPage.new
    @nsp.load
    @nsp.title_field.set('Titel')
  end

  context 'with abbreviated biblebooks' do
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
        @nsp.pericopes[0].set((example[:inputs]).to_s)
        @nsp.studynote_field.set('study')

        submit_form

        should_see t(:item_created, item: Studynote.model_name.human)
        within('#studynote') do
          should_see(example[:expected]).to_s
        end
      end
    end
  end
end
