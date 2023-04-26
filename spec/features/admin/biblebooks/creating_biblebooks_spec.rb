# frozen_string_literal: true

# TODO: Commented. Spec currently not working. It does not visit my
# website but www.example.com.
# Probably needs to be refactored using the page object model,
# but for the admin pages I don't want to invest that time right now.

=begin
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
    puts page.current_url
    puts admin_biblebook_url(book)
    expect(page.current_url).to eq admin_biblebook_url(book)
  end

  scenario "when providing invalid attributes" do
    submit_form

    should_see t(:item_not_created, item: Biblebook.model_name.human)
    should_see t("activerecord.models.messages.blank")
  end
end
=end
