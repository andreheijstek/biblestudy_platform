# frozen_string_literal: true

feature "Admins can create new bible books" do
  before do
    login_as(create(:user, :admin))
    visit admin_biblebooks_path
    click_link t(:new_biblebook)
  end

  scenario "for single bible books" do
    bookname = "Handelingen"
    fill_in t("simple_form.labels.biblebook.name"), with: bookname
    fill_in t("simple_form.labels.biblebook.booksequence"), with: 0
    fill_in t("simple_form.labels.biblebook.testament"), with: "nieuw"

    submit_form

    should_see t(:item_created, item: Biblebook.model_name.human)
    book = Biblebook.find_by(name: "Handelingen")
    expect(page.current_url).to eq admin_biblebook_url(book)
  end

  scenario "when providing invalid attributes" do
    submit_form

    should_see t(:item_not_created, item: Biblebook.model_name.human)
    should_see t("activerecord.models.messages.blank")
  end
end
