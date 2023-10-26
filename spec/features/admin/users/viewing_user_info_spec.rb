# frozen_string_literal: true

describe "Admins can view a list of all users" do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user, username: "Jansen", email: "jan.jansen@tour.fr") }

  before do
    login_as(user)
    login_as(admin)
    visit "/"

    click_link "Admin"
  end

  it "all users are in the list" do
    expect(page).to have_content("jan.jansen")
  end

  it "#logins as user are shown correctly" do
    expect(
      find("tr", text: user).find("td", id: "signin_count")
    ).to have_content("1")
  end
end
