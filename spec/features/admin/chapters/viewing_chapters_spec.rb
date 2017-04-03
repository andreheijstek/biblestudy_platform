require "rails_helper"

feature "Admins can view all chapters within biblebooks" do
  before do
    login_as(create(:user, :admin))
  end

  scenario "for a given biblebook" do
    booktitle = "Handelingen"
    book = create(:biblebook, name: booktitle)
    chapter = create(:chapter, biblebook: book, chapter_number: "1", description: "Inleiding")
    visit admin_biblebook_path(book)

    should_see "1 - Inleiding"
  end

end
