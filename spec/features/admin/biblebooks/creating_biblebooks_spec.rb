require "rails_helper"

feature "Admins can create new bible books" do
  before do
    login_as(create(:user, :admin))
    visit admin_biblebooks_path
    click_link t(:new_biblebook)
  end

  scenario "for single bible books" do
    bookname = "Handelingen"
    fill_in t("simple_form.labels.biblebook.name"),  with: bookname
    fill_in t("simple_form.labels.biblebook.booksequence"), with: 0
    fill_in t("simple_form.labels.biblebook.testament"), with: "nieuw"

    submit_form

    expect(page).to have_content t(:biblebook_created)
    book = Biblebook.find_by(name: "Handelingen")
    expect(page.current_url).to eq admin_biblebook_url(book)
  end

  scenario "when providing invalid attributes" do
    submit_form

    expect(page).to have_content t(:biblebook_not_created)
    expect(page).to have_content t("activerecord.models.messages.blank")
  end
end



