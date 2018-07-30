# Eerste poging tot een page object met SitePrism, als basis voor Cucumber tests

class StudynoteOverview < SitePrism::Page
  set_url 'http://localhost:3000'

  # element :nieuwe_bijbelstudie_button, "link[id='new_studynote']"
  element :nieuwe_bijbelstudie_button, "#new_studynote"
  element :accordion, "iets"
  element :testament_header, "iets"
  element :biblebook_header, "iets"
  element :perikoop, "iets"
end
