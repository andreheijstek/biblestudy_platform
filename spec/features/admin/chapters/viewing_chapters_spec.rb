# frozen_string_literal: true

feature "Admins can view all chapters within biblebooks" do
  before { login_as(create(:user, :admin)) }

  scenario "for a given biblebook" do
    booktitle = "Handelingen"
    book = create(:biblebook)
    create(
      :chapter,
      biblebook: book,
      chapter_number: "1",
      description: "Inleiding"
    )
    visit admin_biblebook_path(book)

    expect(page).to have_content("1 - Inleiding")
  end
end
