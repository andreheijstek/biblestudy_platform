require "rails_helper"

feature "Admins can create new chapters within biblebooks" do
  before do
    login_as(create(:user, :admin))
    booktitle = "Handelingen"
    book = create(:biblebook, name: booktitle)

    visit admin_biblebooks_path
    visit admin_biblebook_path(book)
  end

  scenario "with valid attributes" do
    click_link t(:add_chapter)
    fill_in t("simple_form.labels.chapter.chapter_number"), with: "1"
    fill_in t("simple_form.labels.chapter.description"), with: "Inleiding"

    submit_form

    should_see t(:chapter_created)
  end

  scenario "when providing invalid attributes" do
    click_link t(:add_chapter)
    submit_form
    should_see t(:chapter_not_created)
    should_see t("activerecord.models.messages.blank")
  end
end
