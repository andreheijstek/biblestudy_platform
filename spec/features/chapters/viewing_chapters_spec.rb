require 'rails_helper'

RSpec.feature 'Admins can view all chapters within biblebooks' do

  scenario 'for a given biblebook' do
    booktitle = 'Handelingen'
    book = FactoryGirl.create(:biblebook, name: booktitle)
    chapter = FactoryGirl.create(:chapter, biblebook: book,
                                  chapter_number: '1',
                                  description: 'Inleiding')
    visit biblebook_path(book)

    expect(page).to have_content '1 - Inleiding'
  end

end
