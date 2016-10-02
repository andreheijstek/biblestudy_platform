require "rails_helper"

RSpec.feature "Admins can create new chapters within biblebooks" do

  before do
    booktitle = "Handelingen"
    book = create(:biblebook, name: booktitle)
    visit biblebooks_path
    visit biblebook_path(book)
  end

  scenario "with valid attributes" do
    click_link t(:add_chapter)
    fill_in t("simple_form.labels.chapter.chapter_number"), with: "1"
    fill_in t("simple_form.labels.chapter.description"), with: "Inleiding"

    submit_form

    expect(page).to have_content t(:chapter_created)
  end

  scenario "when providing invalid attributes" do
    click_link t(:add_chapter)
    submit_form
    expect(page).to have_content t(:chapter_not_created)
    expect(page).to have_content t("activerecord.models.messages.blank")
  end
end
