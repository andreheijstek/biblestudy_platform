require "rails_helper"

feature "Admins can view a list of all users" do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user, username: "Jansen", email: "jan.jansen@tour.fr") }

  scenario "all users are in the list" do
    login_as(user)
    login_as(admin)
    visit "/"
    click_link "Admin"
    should_see "jan.jansen"
  end

  scenario "#logins are shown correctly" do
    login_as(user)
    login_as(admin)
    visit "/"
    click_link "Admin"
    expect(find('tr', text: user).find('td', id: 'signin_count')).to have_content("1")

    logout(user)
    login_as(user)
    login_as(admin)
    visit "/"
    click_link "Admin"
    expect(find('tr', text: user).find('td', id: 'signin_count')).to have_content("2")
  end

  scenario "#studies is shown correctly" do
    login_as(user)
    login_as(admin)
    visit "/"
    click_link "Admin"
    expect(find('tr', text: user).find('td', id: "studynote count")).to have_content("0")

    login_as(user)
    b1 = create(:biblebook, name: "Jona")
    s1 = create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user)
    create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: b1.id, studynote_id: s1.id)

    login_as(admin)
    visit "/"
    click_link "Admin"
    expect(find('tr', text: user).find('td', id: "studynote count")).to have_content("1")
  end
end
