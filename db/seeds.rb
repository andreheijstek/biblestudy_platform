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
 "Judas", "Openbaring"].each_with_index do |name, index|
  unless Biblebook.exists?(name: name)
    if index < 39
      Biblebook.create!(name: name, booksequence: index, testament: 'oud')
    else
      Biblebook.create!(name: name, booksequence: index, testament: 'nieuw')
    end
  end
end

books = [
  {name: "Genesis",         chapters: 50},
  {name: "Exodus",          chapters: 40},
  {name: "Leviticus",       chapters: 27},
  {name: "Numeri",          chapters: 36},
  {name: "Deuteronomium",   chapters: 34},
  {name: "Jozua",           chapters: 24},
  {name: "Richteren",       chapters: 21},
  {name: "Ruth",            chapters: 4}
]

books.each do |book|
  id = Biblebook.find_by(name: book[:name]).id
  (1..book[:chapters]).each do |chapter|
    unless Chapter.exists?(chapter_number: chapter, biblebook_id: id)
      Chapter.create(chapter_number: chapter, description: "", biblebook_id: id)
    end
  end
end
