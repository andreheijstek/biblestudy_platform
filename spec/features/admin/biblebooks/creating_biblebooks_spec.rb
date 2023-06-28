# frozen_string_literal: true

feature "Admins can create new bible books" do
  let(:abp) { AdminBiblebooksPage.new }
  let(:abnp) { AdminBiblebooksNewPage.new }

  before do
    login_as(create(:user, :admin))
    abp.load
    abp.new_biblebook_button.click
  end

  scenario "for single bible books" do
    bookname = "Handelingen"
    abnp.load
    abnp.name_field.set bookname
    abnp.order_field.set 0
    abnp.testament_field.set "nieuw"
    abnp.submit_button.click

    expect(page).to have_content bookname
    expect(page).to have_content t(
                   :item_created,
                   item: Biblebook.model_name.human
                 )
  end

  scenario "except when providing invalid attributes" do
    abnp.load
    abnp.submit_button.click

    expect(page).to have_content t(
                   :item_not_created,
                   item: Biblebook.model_name.human
                 )
    expect(page).to have_content t("activerecord.models.messages.blank")
  end
end
