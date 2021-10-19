# frozen_string_literal: true

# Purpose: Value object for biblebook name
# The bb_name is not a String, but a limited set of strings, and it offers not all String messages
# but just a limited set.
#
# It implements a Constructor method to create a BB_Name from a String
# def initialize(name: name)
class BiblebookName
  @@booknames = [
  "Genesis", "Exodus", "Leviticus", "Numeri", "Deuteronomium", "Jozua", "Richteren", "Ruth",
  "1 Samuël", "2 Samuël", "1 Koningen", "2 Koningen", "1 Kronieken", "2 Kronieken", "Ezra",
  "Nehemia", "Esther", "Job", "Psalmen", "Spreuken", "Prediker", "Hooglied", "Jesaja", "Jeremia",
  "Klaagliederen", "Ezechiël", "Daniël", "Hosea", "Joël", "Amos", "Obadja", "Jona", "Micha",
  "Nahum", "Habakuk", "Sefanja", "Haggai", "Zacharia",
  "Maleachi", "Mattheüs", "Markus", "Lukas", "Johannes", "Handelingen", "Romeinen", "1 Korintiërs",
  "2 Korintiërs", "Galaten", "Efeziërs", "Filippenzen", "Kolossenzen", "1 Tessalonicenzen",
  "2 Tessalonicenzen", "1 Timotheüs", "2 Timotheüs", "Titus", "Filemon", "Hebreeën", "Jakobus",
  "1 Petrus", "2 Petrus", "1 Johannes", "2 Johannes", "3 Johannes", "Judas", "Openbaring" ].freeze

  attr_reader :name

  def self.create(name)
    if @@booknames.include?(name)
      self.new(name)
    else
      UnknownBiblebookName.new
    end
  end

  def initialize(name)
    if @@booknames.include?(name)
      @name = name
      freeze
    else
      @name = ""
      UnknownBiblebookName.new
    end
  end
end

class UnknownBiblebookName
  def name
    "Unknown biblebook"
  end
end
