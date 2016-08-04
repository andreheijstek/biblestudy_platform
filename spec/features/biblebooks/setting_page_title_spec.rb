require "rails_helper"

feature "Page title is set according to the page content" do
  scenario "when adding a new biblebook" do
    ensure_on ("/")
    click_link t(:new_biblebook)

    bookname = "Handelingen"
    fill_in t(:name, scope: [:simple_form, :labels, :biblebook]), with: bookname
    fill_in t(:description, scope: [:simple_form, :labels, :biblebook]), with: "De handelingen der apostelen"

    submit

    title = "#{bookname} - #{t(:biblebooks)} - #{t(:biblestudy_platform)}"
    expect(page).to have_title title
  end
end
