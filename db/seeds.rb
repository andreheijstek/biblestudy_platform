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
  {name: "Genesis",           chapters: 50},
  {name: "Exodus",            chapters: 40},
  {name: "Leviticus",         chapters: 27},
  {name: "Numeri",            chapters: 36},
  {name: "Deuteronomium",     chapters: 34},
  {name: "Jozua",             chapters: 24},
  {name: "Richteren",         chapters: 21},
  {name: "Ruth",              chapters: 4},
  {name: "1 Samuël",          chapters: 31},
  {name: "2 Samuël",          chapters: 24},
  {name: "1 Koningen",        chapters: 22},
  {name: "2 Koningen",        chapters: 25},
  {name: "1 Kronieken",       chapters: 29},
  {name: "2 Kronieken",       chapters: 36},
  {name: "Ezra",              chapters: 10},
  {name: "Nehemia",           chapters: 13},
  {name: "Esther",            chapters: 10},
  {name: "Job",               chapters: 42},
  {name: "Psalmen",           chapters: 150},
  {name: "Spreuken",          chapters: 31},
  {name: "Prediker",          chapters: 12},
  {name: "Hooglied",          chapters: 8},
  {name: "Jesaja",            chapters: 66},
  {name: "Jeremia",           chapters: 52},
  {name: "Klaagliederen",     chapters: 5},
  {name: "Ezechiël",          chapters: 48},
  {name: "Daniël",            chapters: 12},
  {name: "Hosea",             chapters: 14},
  {name: "Joël",              chapters: 3},
  {name: "Amos",              chapters: 9},
  {name: "Obadja",            chapters: 1},
  {name: "Jona",              chapters: 4},
  {name: "Micha",             chapters: 7},
  {name: "Nahum",             chapters: 3},
  {name: "Habakuk",           chapters: 3},
  {name: "Sefanja",           chapters: 3},
  {name: "Haggai",            chapters: 2},
  {name: "Zacharia",          chapters: 14},
  {name: "Maleachi",          chapters: 4},

  {name: "Mattheüs",          chapters: 28},
  {name: "Markus",            chapters: 16},
  {name: "Lukas",             chapters: 24},
  {name: "Johannes",          chapters: 21},
  {name: "Handelingen",       chapters: 28},
  {name: "Romeinen",          chapters: 21},
  {name: "1 Korintiërs",      chapters: 16},
  {name: "2 Korintiërs",      chapters: 16},
  {name: "Galaten",           chapters: 6},
  {name: "Efeziërs",          chapters: 6},
  {name: "Filippenzen",       chapters: 4},
  {name: "Kolossenzen",       chapters: 4},
  {name: "1 Tessalonicenzen", chapters: 5},
  {name: "2 Tessalonicenzen", chapters: 3},
  {name: "1 Timotheüs",       chapters: 6},
  {name: "2 Timotheüs",       chapters: 4},
  {name: "Titus",             chapters: 3},
  {name: "Filemon",           chapters: 1},
  {name: "Hebreeën",          chapters: 13},
  {name: "Jakobus",           chapters: 5},
  {name: "1 Petrus",          chapters: 5},
  {name: "2 Petrus",          chapters: 3},
  {name: "1 Johannes",        chapters: 5},
  {name: "2 Johannes",        chapters: 1},
  {name: "3 Johannes",        chapters: 1},
  {name: "Judas",             chapters: 1},
  {name: "Openbaring",        chapters: 22}
]

books.each do |book|
  id = Biblebook.find_by(name: book[:name]).id
  (1..book[:chapters]).each do |chapter|
    unless Chapter.exists?(chapter_number: chapter, biblebook_id: id)
      Chapter.create!(chapter_number: chapter, description: "", biblebook_id: id)
    end
  end
end

book_content = {"Genesis" => [31,25,22],
                "Exodus"  => [10,11]}


book_content.each do |book|
  book_title = book[0]
  book_id    = Biblebook.find_by(name: book[0]).id
  nr_of_chapters = book_content[book[0]].length
  book_content[book[0]].each_with_index do |nr_of_verses, index|
    chapter_id = Chapter.find_by(chapter_number: index+1, biblebook_id: book_id).id
    (1..nr_of_verses).each do |verse|
      unless Verse.exists?(verse_number: verse, chapter_id: chapter_id)
        Verse.create!(verse_number: verse, chapter_id: chapter_id)
      end
    end
  end
end
