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
  { name: "Richteren", abbreviation: "rich" },
  { name: "Ruth", abbreviation: "rut" },
  { name: "1 Samuël", abbreviation: "1 sam" },
  { name: "2 Samuël", abbreviation: "2 sam" },
  { name: "1 Koningen", abbreviation: "1 kon" },
  { name: "2 Koningen", abbreviation: "2 kon" },
  { name: "1 Kronieken", abbreviation: "1 kron" },
  { name: "2 Kronieken", abbreviation: "2 kron" },
  { name: "Ezra", abbreviation: "ez" },
  { name: "Nehemia", abbreviation: "neh" },
  { name: "Esther", abbreviation: "es" },
  { name: "Job", abbreviation: "job" },
  { name: "Psalmen", abbreviation: "ps" },
  { name: "Spreuken", abbreviation: "spr" },
  { name: "Prediker", abbreviation: "pre" },
  { name: "Hooglied", abbreviation: "hoo" },
  { name: "Jesaja", abbreviation: "jes" },
  { name: "Jeremia", abbreviation: "jer" },
  { name: "Klaagliederen", abbreviation: "kla" },
  { name: "Ezechiël", abbreviation: "ez" },
  { name: "Daniël", abbreviation: "dan" },
  { name: "Hosea", abbreviation: "hos" },
  { name: "Joël", abbreviation: "joe" },
  { name: "Amos", abbreviation: "am" },
  { name: "Obadja", abbreviation: "ob" },
  { name: "Jona", abbreviation: "jon" },
  { name: "Micha", abbreviation: "mi" },
  { name: "Nahum", abbreviation: "na" },
  { name: "Habakuk", abbreviation: "ha" },
  { name: "Sefanja", abbreviation: "saf" },
  { name: "Haggai", abbreviation: "hag" },
  { name: "Zacharia", abbreviation: "za" },
  { name: "Maleachi", abbreviation: "mal" },
  { name: "Mattheüs", abbreviation: "mat" },
  { name: "Markus", abbreviation: "mar" },
  { name: "Lukas", abbreviation: "luk" },
  { name: "Johannes", abbreviation: "joh" },
  { name: "Handelingen", abbreviation: "han" },
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
  { name: "Filemon", abbreviation: "fil" },
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

  def self.create(name)
    name
    if @@booknames.map { |book| book[:name] }.include?(name.titleize)
      self.new(name)
    else
      UnknownBiblebookName.new
    end
  end

  def initialize(name)
    @name = name.titleize
    freeze
  end
end

class UnknownBiblebookName
  def name
    "Unknown biblebook"
  end
end
