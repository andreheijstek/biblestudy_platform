# frozen_string_literal: true

feature 'Admins can view all chapters within biblebooks' do
  before do
    login_as(create(:user, :admin))
  end

  scenario 'for a given biblebook' do
    booktitle = 'Handelingen'
    book      = create(:biblebook, name: booktitle)
    create(:chapter,
           biblebook:      book,
           chapter_number: '1',
           description:    'Inleiding')
    visit admin_biblebook_path(book)

    should_see '1 - Inleiding'
  end
end
