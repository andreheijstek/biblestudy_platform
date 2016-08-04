require "rails_helper"

feature "Admins can create new bible sections" do

  before do
    ensure_on ("/")
    click_link t(:new_biblebook)
  end

  scenario "for single bible books" do
    bookname = "Handelingen"
    fill_in t(:name, scope: [:simple_form, :labels, :biblebook]), with: bookname
    fill_in t(:description, scope: [:simple_form, :labels, :biblebook]), with: "De handelingen der apostelen"

    submit

    expect(page).to have_content t(:biblebook_created)
    book = Biblebook.find_by(name: "Handelingen")
    expect(page.current_url).to eq biblebook_url(book)
  end

  scenario "when providing invalid attributes" do
    submit
    expect(page).to have_content t(:biblebook_not_created)
    expect(page).to have_content t(:blank, scope: [:activerecord, :models, :messages])
  end
end



