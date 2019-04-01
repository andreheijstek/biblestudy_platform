require 'capybara'
require 'cucumber'
require 'selenium-webdriver'

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new app, browser: :chrome
end


Given("the following dates are planned as cowork dates: {string}, {string}, {string}") do |date1, date2, date3|
  @cowork_dates = []
  @cowork_dates << date1
  @cowork_dates << date2
  @cowork_dates << date3
end

Given(/^"([^"]*)" is a coworkday$/) do |given_date|
  # if @cowork_dates.include?(given_date)
  # end
end

When(/^I go to "([^"]*)"$/) do |site|
  visit site
end

Then(/^the page shows "([^"]*)"$/) do |content|
  expect(page).to have_content content

end

Given(/^"([^"]*)" is not a coworkday$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the page shows the upcoming event$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("{string} is a not coworkday") do |string|
end
