require 'rails_helper'

RSpec.feature 'Page title is set according to the page content' do
  scenario 'when adding a new biblebook' do
    visit biblebooks_path
    click_link t(:new_biblebook)

    bookname = 'Handelingen'
    fill_in t(:name, scope: [:simple_form, :labels, :biblebook]), with: bookname

    submit_form

    title = "#{bookname} - #{t(:biblebooks)} - #{t(:biblestudy_platform)}"
    expect(page).to have_title title
  end
end
