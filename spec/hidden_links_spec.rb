# frozen_string_literal: true
require "rails_helper"

feature "Users can only see the appropriate links" do
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }

  context "anonymous users" do
    scenario "cannot see the Admin link" do
      visit "/"
      expect(page).not_to have_link "Admin"
    end
  end

  context "regular users" do
    before { login_as(user) }

    scenario "cannot see the Admin link" do
      visit "/"
      expect(page).not_to have_link "Admin"
    end
  end

  context "admin users" do
    before { login_as(admin) }

    scenario "can see the Admin link" do
      visit "/"
      expect(page).to have_link "Admin"
    end
  end
end
