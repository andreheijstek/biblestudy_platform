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

book_content = {
  "Genesis" =>       [31,25,24,26,32,22,24,22,29,32,32,20,18,24,21,16,27,33,38,18,
                      34,24,20,67,34,35,46,22,35,43,55,32,20,31,29,43,36,30,23,23,
                      57,38,34,34,28,34,31,22,33,26],
  "Exodus"  =>       [22,25,22,31,24,29,25,32,35,29,10,51,22,31,27,36,16,27,25,26,
                      36,31,33,18,40,37,21,43,46,38,18,35,23,35,35,38,29,31,43,38],
  "Leviticus" =>     [17,16,17,35,19,30,38,36,24,20,47, 8,59,57,33,34,16,30,37,27,
                      24,33,44,23,55,46,34],
  "Numeri"    =>     [54,34,51,49,31,27,89,26,23,36,35,16,33,45,41,50,13,32,22,29,
                      35,41,30,25,18,65,23,31,40,16,54,42,56,29,34,13],
  "Deuteronomium" => [46,37,29,49,33,25,26,20,29,22,32,32,18,29,23,22,20,22,21,20,
                      23,30,25,22,19,19,26,68,29,20,30,52,29,12],
  "Jozua" =>         [18,24,17,24,15,27,26,35,27,43,23,24,33,15,63,10,18,28,51, 9,
                      45,34,16,33],
  "Richteren" =>     [36,23,31,24,31,40,25,35,57,18,40,15,25,20,20,31,13,31,30,48,
                      25],
  "Ruth" =>          [22,23,18,22],
  "1 Samuël" =>      [28,36,21,22,12,21,17,22,27,27,15,25,23,52,35,23,58,30,24,43,
                      15,23,28,23,44,25,12,25,11,31,13],
  "2 Samuël" =>      [27,32,39,12,25,23,29,18,13,19,27,31,39,33,37,23,29,33,43,26,
                      22,51,39,25],
  "1 Koningen" =>    [53,46,28,34,18,38,51,66,28,29,43,33,34,31,34,34,24,46,21,43,
                      29,54],
  "2 Koningen" =>    [18,25,27,44,27,33,20,29,37,36,21,21,25,29,38,20,41,37,37,21,
                      26,20,37,20,30],
  "1 Kronieken" =>   [54,55,24,43,26,81,40,40,44,14,47,40,14,17,29,43,27,17,19, 8,
                      30,19,32,31,31,32,34,21,30],
  "2 Kronieken" =>   [17,18,17,22,14,42,22,18,31,19,23,16,22,15,19,14,19,34,11,37,
                      20,12,21,27,28,23, 9,27,36,27,21,33,25,33,27,23],
  "Ezra" =>          [11,70,13,24,17,22,28,36,15,44],
  "Nehemia" =>       [11,20,32,23,19,19,73,19,38,39,36,47,31],
  "Esther" =>        [22,23,15,17,14,14,10,17,32, 3],
  "Job" =>           [22,13,26,21,27,30,21,22,35,22,20,25,28,22,35,22,16,21,29,29,
                      34,30,17,25, 6,14,23,28,25,31,40,22,33,37,16,33,24,38,38,28,
                      25,17],
  "Psalmen" =>       [ 6,12, 9, 9,13,11,18,10,21,18, 7, 9, 6, 7, 5,11,15,51,15,10,
                      14,32, 6,10,22,12,14, 9,11,13,25,11,22,23,28,13,40,23,14,18,
                      14,12, 5,27,18,12,10,15,21,23,21,11, 7, 9,24,14,12,12,18,14,
                       9,13,12,11,14,20, 8,36,37, 6,24,20,28,23,11,13,21,72,13,20,
                      17, 8,19,13,14,17, 7,19,53,17,16,16, 5,23,11,13,12, 9, 9, 5,
                       8,29,22,35,45,48,43,14,31, 7,10,10, 9, 8,18,19, 2,29,176,7,
                       8, 9, 4, 8, 5, 6, 5, 6, 8, 8, 3,18, 3, 3,21,26, 9, 8,24,14,
                      10, 8,12,15,21,10,20,14, 9, 6],
  "Spreuken" =>      [33,22,35,27,23,35,27,36,18,32,31,28,25,35,33,33,28,24,29,30,
                      31,29,35,34,28,28,27,28,27,33,31],

  "Prediker" =>      [18,26,22,17,19,12,29,17,18,20,10,14]
  # "Hooglied", "Jesaja", "Jeremia",
#     "Klaagliederen", "Ezechiël", "Daniël", "Hosea", "Joël", "Amos", "Obadja", "Jona", "Micha", "Nahum",
#     "Habakuk", "Sefanja", "Haggai", "Zacharia", "Maleachi", "Mattheüs", "Markus", "Lukas", "Johannes",
#     "Handelingen", "Romeinen", "1 Korintiërs", "2 Korintiërs", "Galaten", "Efeziërs", "Filippenzen",
#     "Kolossenzen", "1 Tessalonicenzen", "2 Tessalonicenzen", "1 Timotheüs", "2 Timotheüs", "Titus",
#     "Filemon", "Hebreeën", "Jakobus", "1 Petrus", "2 Petrus", "1 Johannes", "2 Johannes", "3 Johannes",
#     "Judas", "Openbaring"
  }

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
