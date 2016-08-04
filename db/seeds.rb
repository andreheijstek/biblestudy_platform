# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Genesis", "Exodus", "Leviticus", "Numeri", "Deuteronomium", "Jozua", "Richteren", "Ruth",
 "1 Samuël", "2 Samuël", "1 Koningen", "2 Koningen", "1 Kronieken", "2 Kronieken", "Ezra",
 "Nehemia", "Esther", "Job", "Psalmen", "Spreuken", "Prediker", "Hooglied", "Jesaja", "Jeremia",
 "Klaagliederen", "Ezechiël", "Daniël", "Hosea", "Joël", "Amos", "Obadja", "Jona", "Micha", "Nahum",
 "Habakuk", "Sefanja", "Haggai", "Zacharia", "Maleachi", "Mattheüs", "Markus", "Lukas", "Johannes",
 "Handelingen", "Romeinen", "1 Korintiërs", "2 Korintiërs", "Galaten", "Efeziërs", "Filippenzen",
 "Kolossenzen", "1 Tessalonicenzen", "2 Tessalonicenzen", "1 Timotheüs", "2 Timotheüs", "Titus",
 "Filemon", "Hebreeën", "Jakobus", "1 Petrus", "2 Petrus", "1 Johannes", "2 Johannes", "3 Johannes",
 "Judas", "Openbaring"].each do |name|
  unless Biblebook.exists?(name: name)
    Biblebook.create!(name: name)
  end
end

