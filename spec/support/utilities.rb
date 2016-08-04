def t(string, options={})
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
