# frozen_string_literal: true

# Purpose: Value object for biblebook name
# The bb_name is not a String, but a limited set of strings, and it offers not all String messages
# but just a limited set.
#
# It implements a Constructor method to create a BB_Name from a String
# def initialize(name: name)
class BiblebookName
  @@booknames = [
  { name: "Genesis", abbreviation: "gen" },
  { name: "Exodus", abbreviation: "ex" },
  { name: "Leviticus", abbreviation: "lev" },
  { name: "Numeri", abbreviation: "num" },
  { name: "Deuteronomium", abbreviation: "deut" },
  { name: "Jozua", abbreviation: "joz" },
  { name: "Richteren", abbreviation: "richt" },
  { name: "Ruth", abbreviation: "ruth" },
  { name: "1 Samuël", abbreviation: "1 sam" },
  { name: "2 Samuël", abbreviation: "2 sam" },
  { name: "1 Koningen", abbreviation: "1 kon" },
  { name: "2 Koningen", abbreviation: "2 kon" },
  { name: "1 Kronieken", abbreviation: "1 kron" },
  { name: "2 Kronieken", abbreviation: "2 kron" },
  { name: "Ezra", abbreviation: "ezra" },
  { name: "Nehemia", abbreviation: "neh" },
  { name: "Esther", abbreviation: "est" },
  { name: "Job", abbreviation: "job" },
  { name: "Psalmen", abbreviation: "ps" },
  { name: "Spreuken", abbreviation: "spr" },
  { name: "Prediker", abbreviation: "pred" },
  { name: "Hooglied", abbreviation: "hoogl" },
  { name: "Jesaja", abbreviation: "jes" },
  { name: "Jeremia", abbreviation: "jer" },
  { name: "Klaagliederen", abbreviation: "klaagl" },
  { name: "Ezechiël", abbreviation: "eze" },
  { name: "Daniël", abbreviation: "dan" },
  { name: "Hosea", abbreviation: "hos" },
  { name: "Joël", abbreviation: "joël" },
  { name: "Amos", abbreviation: "am" },
  { name: "Obadja", abbreviation: "ob" },
  { name: "Jona", abbreviation: "jona" },
  { name: "Micha", abbreviation: "mi" },
  { name: "Nahum", abbreviation: "nah" },
  { name: "Habakuk", abbreviation: "hab" },
  { name: "Sefanja", abbreviation: "sef" },
  { name: "Haggai", abbreviation: "hag" },
  { name: "Zacharia", abbreviation: "zach" },
  { name: "Maleachi", abbreviation: "mal" },
  { name: "Mattheüs", abbreviation: "mat" },
  { name: "Markus", abbreviation: "mar" },
  { name: "Lukas", abbreviation: "luk" },
  { name: "Johannes", abbreviation: "joh" },
  { name: "Handelingen", abbreviation: "hand" },
  { name: "Romeinen", abbreviation: "rom" },
  { name: "1 Korintiërs", abbreviation: "1 kor" },
  { name: "2 Korintiërs", abbreviation: "2 kor" },
  { name: "Galaten", abbreviation: "gal" },
  { name: "Efeziërs", abbreviation: "ef" },
  { name: "Filippenzen", abbreviation: "fil" },
  { name: "Kolossenzen", abbreviation: "kol" },
  { name: "1 Tessalonicenzen", abbreviation: "1 tes" },
  { name: "2 Tessalonicenzen", abbreviation: "2 tes" },
  { name: "1 Timotheüs", abbreviation: "1 tim" },
  { name: "2 Timotheüs", abbreviation: "2 tim" },
  { name: "Titus", abbreviation: "tit" },
  { name: "Filemon", abbreviation: "filem" },
  { name: "Hebreeën", abbreviation: "heb" },
  { name: "Jakobus", abbreviation: "jak" },
  { name: "1 Petrus", abbreviation: "1 pet" },
  { name: "2 Petrus", abbreviation: "2 pet" },
  { name: "1 Johannes", abbreviation: "1 joh" },
  { name: "2 Johannes", abbreviation: "2 joh" },
  { name: "3 Johannes", abbreviation: "3 joh" },
  { name: "Judas", abbreviation: "jud" },
  { name: "Openbaring", abbreviation: "op" }
  ].freeze

  attr_reader :name

  def self.create(given_name)
    if find_by_full_name(given_name)
      new(given_name)
    elsif (books = find_by_abbreviation(given_name))
      new(books[:name])
    elsif (books = find_by_like(given_name))
      if books.length == 1
        new(books[0])
      else
        UnknownBiblebookName.new
      end
    else
      UnknownBiblebookName.new
    end
  end

  def initialize(name)
    @name = name.titleize
    freeze
  end

  private

  def self.find_by_abbreviation(name)
    @@booknames.find { |book| book[:abbreviation] == name.downcase }
  end

  def self.find_by_full_name(name)
    @@booknames.map { |book| book[:name] }.include?(name.titleize)
  end

  def self.find_by_like(name)
    @@booknames.collect { |book| book[:name] }.grep /#{name.titleize}/
  end
end

class UnknownBiblebookName
  def name
    "Unknown biblebook"
  end
end
