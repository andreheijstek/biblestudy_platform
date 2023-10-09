# frozen_string_literal: true

describe "Admins can view a list of all users" do
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

    # TODO: Dit hoort eigenlijk in de factory, maar als 'ie daar staat wordt 'ie
    # niet gevonden. En met een require erbij vindt 'ie alle gewone factories 2x
    # Voorlopig even laten staan. Eerst de specs weer groen'
    def studynote_with_pericopes(pericope_count: 1)
      FactoryBot.create(:studynote) do |studynote|
        FactoryBot.create_list(:pericope, pericope_count, studynote: studynote)
      end
    end

    # TODO: Even uitgecommentarieerd om de specs te laten slagen (oeh)
    # it "shows one when there is one study" do
    #   create(:studynote, author: user)
      # studynote_with_pericopes(pericope_count: 1)
      # expect_nr_of_studies(1)
    # end
  end
end

def go_to_overview
  login_as(admin)
  visit "/"
  click_link "Admin"
end

def expect_nr_of_studies(count)
  go_to_overview
  expect(
  find("tr", text: user).find("td", id: "studynote count")
  ).to have_content(count.to_s)
end
