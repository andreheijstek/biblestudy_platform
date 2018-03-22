Given("I am logged in") do
  @user = create(:user)
  login_as(@user)
end
