# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['Genesis', 'Exodus', 'Leviticus', 'Numeri', 'Deuteronomium', 'Jozua', 'Richteren', 'Ruth',
 '1 Samuël', '2 Samuël', '1 Koningen', '2 Koningen', '1 Kronieken', '2 Kronieken', 'Ezra',
 'Nehemia', 'Esther', 'Job', 'Psalmen', 'Spreuken', 'Prediker', 'Hooglied', 'Jesaja', 'Jeremia',
 'Klaagliederen', 'Ezechiël', 'Daniël', 'Hosea', 'Joël', 'Amos', 'Obadja', 'Jona', 'Micha', 'Nahum',
 'Habakuk', 'Sefanja', 'Haggai', 'Zacharia', 'Maleachi', 'Mattheüs', 'Markus', 'Lukas', 'Johannes',
 'Handelingen', 'Romeinen', '1 Korintiërs', '2 Korintiërs', 'Galaten', 'Efeziërs', 'Filippenzen',
 'Kolossenzen', '1 Tessalonicenzen', '2 Tessalonicenzen', '1 Timotheüs', '2 Timotheüs', 'Titus',
 'Filemon', 'Hebreeën', 'Jakobus', '1 Petrus', '2 Petrus', '1 Johannes', '2 Johannes', '3 Johannes',
 'Judas', 'Openbaring'].each_with_index do |name, index|
  unless Biblebook.exists?(name: name)
    if index < 39
      Biblebook.create!(name: name, booksequence: index, testament: 'oud')
    else
      Biblebook.create!(name: name, booksequence: index, testament: 'nieuw')
    end
  end
end

books = [
  { name: 'Genesis', abbreviation: 'Gen', chapters: 50, verses: [31, 25, 24, 26, 32, 22, 24, 22, 29, 32, 32, 20, 18, 24, 21, 16, 27, 33, 38, 18,
                                                                 34, 24, 20, 67, 34, 35, 46, 22, 35, 43, 55, 32, 20, 31, 29, 43, 36, 30, 23, 23,
                                                                 57, 38, 34, 34, 28, 34, 31, 22, 33, 26] },
  { name: 'Exodus', abbreviation: 'Ex', chapters: 40, verses: [22, 25, 22, 31, 24, 29, 25, 32, 35, 29, 10, 51, 22, 31, 27, 36, 16, 27, 25, 26,
                                                               36, 31, 33, 18, 40, 37, 21, 43, 46, 38, 18, 35, 23, 35, 35, 38, 29, 31, 43, 38] },
  { name: 'Leviticus', abbreviation: 'Lev', chapters: 27, verses: [17, 16, 17, 35, 19, 30, 38, 36, 24, 20, 47, 8, 59, 57, 33, 34, 16, 30, 37, 27,
                                                                   24, 33, 44, 23, 55, 46, 34] },
  { name: 'Numeri', abbreviation: 'Num', chapters: 36, verses: [54, 34, 51, 49, 31, 27, 89, 26, 23, 36, 35, 16, 33, 45, 41, 50, 13, 32, 22, 29,
                                                                35, 41, 30, 25, 18, 65, 23, 31, 40, 16, 54, 42, 56, 29, 34, 13] },
  { name: 'Deuteronomium', abbreviation: 'Deut', chapters: 34, verses: [46, 37, 29, 49, 33, 25, 26, 20, 29, 22, 32, 32, 18, 29, 23, 22, 20, 22, 21, 20,
                                                                        23, 30, 25, 22, 19, 19, 26, 68, 29, 20, 30, 52, 29, 12] },
  { name: 'Jozua', abbreviation: 'Joz', chapters: 24, verses: [18, 24, 17, 24, 15, 27, 26, 35, 27, 43, 23, 24, 33, 15, 63, 10, 18, 28, 51, 9,
                                                               45, 34, 16, 33] },
  { name: 'Richteren', abbreviation: 'Rich', chapters: 21, verses: [36, 23, 31, 24, 31, 40, 25, 35, 57, 18, 40, 15, 25, 20, 20, 31, 13, 31, 30, 48,
                                                                    25] },
  { name: 'Ruth', abbreviation: 'Rut', chapters: 4, verses: [22, 23, 18, 22] },
  { name: '1 Samuël', abbreviation: '1 Sam', chapters: 31, verses: [28, 36, 21, 22, 12, 21, 17, 22, 27, 27, 15, 25, 23, 52, 35, 23, 58, 30, 24, 43,
                                                                    15, 23, 28, 23, 44, 25, 12, 25, 11, 31, 13] },
  { name: '2 Samuël', abbreviation: '2 Sam', chapters: 24, verses: [27, 32, 39, 12, 25, 23, 29, 18, 13, 19, 27, 31, 39, 33, 37, 23, 29, 33, 43, 26,
                                                                    22, 51, 39, 25] },
  { name: '1 Koningen', abbreviation: '1 Kon', chapters: 22, verses: [53, 46, 28, 34, 18, 38, 51, 66, 28, 29, 43, 33, 34, 31, 34, 34, 24, 46, 21, 43,
                                                                      29, 54] },
  { name: '2 Koningen', abbreviation: '2 Kon', chapters: 25, verses: [18, 25, 27, 44, 27, 33, 20, 29, 37, 36, 21, 21, 25, 29, 38, 20, 41, 37, 37, 21,
                                                                      26, 20, 37, 20, 30] },
  { name: '1 Kronieken', abbreviation: '1 Kron', chapters: 29, verses: [54, 55, 24, 43, 26, 81, 40, 40, 44, 14, 47, 40, 14, 17, 29, 43, 27, 17, 19, 8,
                                                                        30, 19, 32, 31, 31, 32, 34, 21, 30] },
  { name: '2 Kronieken', abbreviation: '2 Kron', chapters: 36, verses: [17, 18, 17, 22, 14, 42, 22, 18, 31, 19, 23, 16, 22, 15, 19, 14, 19, 34, 11, 37,
                                                                        20, 12, 21, 27, 28, 23, 9, 27, 36, 27, 21, 33, 25, 33, 27, 23] },
  { name: 'Ezra', abbreviation: 'Ez', chapters: 10, verses: [11, 70, 13, 24, 17, 22, 28, 36, 15, 44] },
  { name: 'Nehemia', abbreviation: 'Neh', chapters: 13, verses: [11, 20, 32, 23, 19, 19, 73, 19, 38, 39, 36, 47, 31] },
  { name: 'Esther', abbreviation: 'Es', chapters: 10, verses: [22, 23, 15, 17, 14, 14, 10, 17, 32, 3] },
  { name: 'Job', abbreviation: 'Job', chapters: 42, verses: [22, 13, 26, 21, 27, 30, 21, 22, 35, 22, 20, 25, 28, 22, 35, 22, 16, 21, 29, 29,
                                                             34, 30, 17, 25, 6, 14, 23, 28, 25, 31, 40, 22, 33, 37, 16, 33, 24, 38, 38, 28,
                                                             25, 17] },
  { name: 'Psalmen', abbreviation: 'Ps', chapters: 150, verses: [6, 12, 9, 9, 13, 11, 18, 10, 21, 18, 7, 9, 6, 7, 5, 11, 15, 51, 15, 10,
                                                                 14, 32, 6, 10, 22, 12, 14, 9, 11, 13, 25, 11, 22, 23, 28, 13, 40, 23, 14, 18,
                                                                 14, 12, 5, 27, 18, 12, 10, 15, 21, 23, 21, 11, 7, 9, 24, 14, 12, 12, 18, 14,
                                                                 9, 13, 12, 11, 14, 20, 8, 36, 37, 6, 24, 20, 28, 23, 11, 13, 21, 72, 13, 20,
                                                                 17, 8, 19, 13, 14, 17, 7, 19, 53, 17, 16, 16, 5, 23, 11, 13, 12, 9, 9, 5,
                                                                 8, 29, 22, 35, 45, 48, 43, 14, 31, 7, 10, 10, 9, 8, 18, 19, 2, 29, 176, 7,
                                                                 8, 9, 4, 8, 5, 6, 5, 6, 8, 8, 3, 18, 3, 3, 21, 26, 9, 8, 24, 14,
                                                                 10, 8, 12, 15, 21, 10, 20, 14, 9, 6] },
  { name: 'Spreuken', abbreviation: 'Spr', chapters: 31, verses: [33, 22, 35, 27, 23, 35, 27, 36, 18, 32, 31, 28, 25, 35, 33, 33, 28, 24, 29, 30,
                                                                  31, 29, 35, 34, 28, 28, 27, 28, 27, 33, 31] },
  { name: 'Prediker', abbreviation: 'Pre', chapters: 12, verses: [18, 26, 22, 17, 19, 12, 29, 17, 18, 20, 10, 14] },
  { name: 'Hooglied', abbreviation: 'Hoo', chapters: 8, verses: [17, 17, 11, 16, 16, 13, 13, 14] },
  { name: 'Jesaja', abbreviation: 'Jes', chapters: 66, verses: [31, 22, 26, 6, 30, 13, 25, 23, 20, 34, 16, 6, 22, 32, 9, 14, 14, 7, 25, 6,
                                                                17, 25, 18, 23, 12, 21, 13, 29, 24, 33, 9, 20, 24, 17, 10, 22, 38, 22, 8, 31,
                                                                29, 25, 28, 28, 25, 13, 15, 22, 26, 11, 23, 15, 12, 17, 13, 12, 21, 14, 21, 22,
                                                                11, 12, 19, 12, 25, 24] },
  { name: 'Jeremia', abbreviation: 'Jer', chapters: 52, verses: [19, 37, 25, 31, 31, 30, 34, 22, 26, 25, 23, 17, 27, 22, 21, 21, 27, 23, 15, 18,
                                                                 14, 30, 40, 10, 38, 24, 22, 17, 32, 24, 40, 44, 26, 22, 19, 32, 21, 28, 18, 16,
                                                                 18, 22, 13, 30, 5, 28, 7, 47, 39, 46, 64, 34] },
  { name: 'Klaagliederen', abbreviation: 'Kla', chapters: 5, verses: [22, 22, 66, 22, 22] },
  { name: 'Ezechiël', abbreviation: 'Ez', chapters: 48, verses: [28, 10, 27, 17, 17, 14, 27, 18, 11, 22, 25, 28, 23, 23, 8, 63, 24, 32, 14, 49,
                                                                 32, 31, 49, 27, 17, 21, 36, 26, 21, 26, 18, 32, 33, 31, 15, 38, 28, 23, 29, 49,
                                                                 26, 20, 27, 31, 25, 24, 23, 35] },
  { name: 'Daniël', abbreviation: 'Dan', chapters: 12, verses: [21, 49, 30, 37, 30, 29, 28, 27, 27, 21, 45, 13] },
  { name: 'Hosea', abbreviation: 'Hos', chapters: 14, verses: [12, 22, 5, 19, 15, 11, 16, 14, 17, 15, 11, 15, 15, 10] },
  { name: 'Joël', abbreviation: 'Joe', chapters: 3, verses: [20, 32, 21] },
  { name: 'Amos', abbreviation: 'Am', chapters: 9, verses: [15, 16, 15, 13, 27, 14, 17] },
  { name: 'Obadja', abbreviation: 'Ob', chapters: 1, verses: [21] },
  { name: 'Jona', abbreviation: 'Jon', chapters: 4, verses: [17, 10, 10, 11] },
  { name: 'Micha', abbreviation: 'Mi', chapters: 7, verses: [16, 13, 12, 14, 14, 16, 20] },
  { name: 'Nahum', abbreviation: 'Na', chapters: 3, verses: [15, 13, 19] },
  { name: 'Habakuk', abbreviation: 'Ha', chapters: 3, verses: [17, 20, 19] },
  { name: 'Sefanja', abbreviation: 'Sef', chapters: 3, verses: [18, 15, 20] },
  { name: 'Haggai', abbreviation: 'Hag', chapters: 2, verses: [14, 24] },
  { name: 'Zacharia', abbreviation: 'Za', chapters: 14, verses: [21, 13, 10, 14, 11, 15, 14, 23, 17, 12, 17, 14, 9, 21] },
  { name: 'Maleachi', abbreviation: 'Mal', chapters: 4, verses: [14, 17, 18, 6] },

  { name: 'Mattheüs', abbreviation: 'Mat', chapters: 28, verses: [25, 23, 17, 25, 48, 34, 29, 34, 38, 42, 30, 50, 58, 36, 39, 28, 27, 35, 30, 34,
                                                                  46, 46, 39, 51, 46, 75, 66, 20] },
  { name: 'Markus', abbreviation: 'Mar', chapters: 16, verses: [45, 28, 35, 41, 43, 56, 37, 38, 50, 52, 33, 44, 37, 72, 47, 20] },
  { name: 'Lukas', abbreviation: 'Luk', chapters: 24, verses: [80, 52, 38, 44, 39, 49, 50, 56, 62, 42, 54, 59, 35, 35, 32, 31, 37, 43, 48, 47,
                                                               38, 71, 56, 53] },
  { name: 'Johannes', abbreviation: 'Joh', chapters: 21, verses: [52, 25, 36, 54, 47, 71, 53, 59, 41, 42, 57, 50, 38, 31, 27, 33, 26, 40, 42, 31,
                                                                  25] },
  { name: 'Handelingen', abbreviation: 'Han', chapters: 28, verses: [26, 47, 26, 37, 42, 15, 60, 40, 43, 48, 30, 25, 52, 28, 41, 40, 34, 28, 40, 38,
                                                                     40, 30, 35, 27, 27, 32, 44, 31] },
  { name: 'Romeinen', abbreviation: 'Rom', chapters: 21, verses: [32, 29, 31, 25, 21, 23, 26, 39, 33, 21, 36, 21, 14, 23, 33, 27] },
  { name: '1 Korintiërs', abbreviation: '1 Kor', chapters: 16, verses: [31, 16, 23, 21, 13, 20, 40, 13, 27, 33, 34, 31, 13, 40, 58, 24] },
  { name: '2 Korintiërs', abbreviation: '2 Kor', chapters: 16, verses: [24, 17, 18, 18, 21, 18, 16, 24, 15, 18, 33, 21, 13] },
  { name: 'Galaten', abbreviation: 'Gal', chapters: 6, verses: [24, 21, 29, 31, 26, 18] },
  { name: 'Efeziërs', abbreviation: 'Ef', chapters: 6, verses: [23, 22, 21, 32, 33, 24] },
  { name: 'Filippenzen', abbreviation: 'Fil', chapters: 4, verses: [30, 30, 21, 23] },
  { name: 'Kolossenzen', abbreviation: 'Kol', chapters: 4, verses: [29, 23, 25, 18] },
  { name: '1 Tessalonicenzen', abbreviation: '1 Tes', chapters: 5, verses: [10, 20, 13, 18, 28] },
  { name: '2 Tessalonicenzen', abbreviation: '2 Tes', chapters: 3, verses: [12, 17, 18] },
  { name: '1 Timotheüs', abbreviation: '1 Tim', chapters: 6, verses: [20, 15, 16, 16, 25, 21] },
  { name: '2 Timotheüs', abbreviation: '2 Tim', chapters: 4, verses: [18, 26, 17, 22] },
  { name: 'Titus', abbreviation: 'Tit', chapters: 3, verses: [16, 15, 15] },
  { name: 'Filemon', abbreviation: 'Fil', chapters: 1, verses: [25] },
  { name: 'Hebreeën', abbreviation: 'Heb', chapters: 13, verses: [14, 18, 19, 16, 14, 20, 28, 13, 28, 39, 40, 29, 25] },
  { name: 'Jakobus', abbreviation: 'Jak', chapters: 5, verses: [27, 26, 18, 17, 20] },
  { name: '1 Petrus', abbreviation: '1 Pet', chapters: 5, verses: [25, 25, 22, 19, 14] },
  { name: '2 Petrus', abbreviation: '2 Pet', chapters: 3, verses: [21, 22, 18] },
  { name: '1 Johannes', abbreviation: '1 Joh', chapters: 5, verses: [10, 29, 24, 21, 21] },
  { name: '2 Johannes', abbreviation: '2 Joh', chapters: 1, verses: [13] },
  { name: '3 Johannes', abbreviation: '3 Joh', chapters: 1, verses: [15] },
  { name: 'Judas', abbreviation: 'Jud', chapters: 1, verses: [25] },
  { name: 'Openbaring', abbreviation: 'Op', chapters: 22, verses: [20, 29, 22, 11, 14, 17, 17, 13, 21, 11, 19, 18, 18, 20, 8, 21, 18, 24, 21, 15,
                                                                   27, 21] }
]

books.each do |book|
  puts book[:name]
  id = Biblebook.find_by(name: book[:name]).id
  (1..book[:chapters]).each_with_index do |chapter, index|
    unless Chapter.exists?(chapter_number: chapter, biblebook_id: id)
      Chapter.create!(chapter_number: chapter, description: '', nrofverses: book[:verses][index], biblebook_id: id)
    end
  end

  bbook = Biblebook.find_by(name: book[:name])
  if bbook.abbreviation.nil?
    bbook.update_attribute(:abbreviation, book[:abbreviation])
  end
end

unless User.exists?(email: 'admin@biblestudy.com')
  User.create!(email: 'admin@biblestudy.com', password: 'bsp4ever', admin: true)
end

unless User.exists?(email: 'viewer@biblestudy.com')
  User.create!(email: 'viewer@biblestudy.com', password: 'bsp4ever')
end

pericopes = Pericope.all
pericopes.each do |p|
  p.biblebook_name = p.biblebook_name if p.biblebook_name.nil?
  p.save
end
