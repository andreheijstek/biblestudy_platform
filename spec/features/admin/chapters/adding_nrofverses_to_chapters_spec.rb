require "rails_helper"

feature "Admins can add the number of verses to a chapter" do
  before do
    login_as(create(:user, :admin))
    booktitle = "Handelingen"
    book = create(:biblebook, name: booktitle)
    chapter = create(:chapter, biblebook: book, chapter_number: "1")

    visit admin_biblebooks_path
    visit admin_biblebook_chapter_path(book, chapter)
  end

  scenario "with valid attributes" do
    click_link t(:edit_chapter)
    fill_in t("simple_form.labels.chapter.nrofverses"), with: "31"

    submit_form

    should_see t(:chapter_updated)
  end
end
