# frozen_string_literal: true

describe "Admins can view a list of all users", js: true do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user, username: "Jansen", email: "jan.jansen@tour.fr") }

  context "when I am logged in as user" do
    before do
      create(:biblebook, name: "Jona")
      login_as(user)
    end

    it "shows zero when there are no studies" do
      expect_nr_of_studies(0)
    end

    it "shows one when there is one study" do
      create(:studynote_with_pericopes, pericope_count: 1, author: user)
      expect_nr_of_studies(1)
    end
  end
end

def expect_nr_of_studies(count)
  go_to_overview
  expect(
    find("tr", text: user).find("td", id: "studynote count")
  ).to have_content(count.to_s)
end

def go_to_overview
  login_as(admin)
  visit "/"
  page.find("button.navbar-toggler").click

  click_link "Admin"
end
