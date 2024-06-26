# frozen_string_literal: true

feature "Admins can add the number of verses to a chapter" do
  before do
    login_as(create(:user, :admin))
    booktitle = "Handelingen"
    book = create(:biblebook_with_chapters, name: booktitle)
    chapter = create(:chapter, biblebook: book, chapter_number: "1")

    # visit admin_biblebooks_path
    visit admin_biblebook_chapter_path(book, chapter)
  end

  scenario "with valid attributes" do
    click_link t(:edit_item, item: Chapter.model_name.human)
    fill_in t("simple_form.labels.chapter.nrofverses"), with: "31"

    submit_form

    expect(page).to have_content(
      t(:item_updated, item: Chapter.model_name.human)
    )
  end
end
