# frozen_string_literal: true

#:reek:UncommunicativeMethodName: very deliberately short
#:reek:UtilityFunction: yes it is!
def t(string, options = {})
  I18n.t(string, options)
end

Capybara.add_selector(:name) do
  xpath { |name| XPath.descendant[XPath.attr(:name).contains(name)] }
end

def ensure_on(path)
  visit(path) unless current_path == path
end

def submit_form
  find(:name, 'commit').click
end

def should_see(text)
  expect(page).to have_content(text)
end

def should_not_see(text)
  expect(page).to have_no_content(text)
end

# Example of usage:
#
# scenario do
#   # ...
#   within_table_row(3) do
#     click_on "Delete"
#   end
#   # ...
# end

def within_table_row(position)
  row = find_all('table tr')[position]
  within(row) do
    yield
  end
end
