class Pericope < ActiveRecord::Base
  belongs_to :study_note
  has_one :biblebook
  validates :name, presence: true
  after_validation :parse_name

  protected

  def parse_name
    return if name.nil? || name.empty?
    # TODO Ik begrijp niet waarom ik deze check moet doen. Ik zit in een after_validation
    # dus de validation is al gedaan, daarin zit een precense: op :name, dus eigenlijk had
    # dit al afgevangen moeten zijn.

    elements = name.split(/\b/).delete_if {|e| e == " "}
    # puts "\n\n->->-> name: #{name}, elements: #{elements}"

    # 'Genesis 1:2-3:4' or Gen 1:2-4 or Gen 1:2-3:4 or Gen 1:2 - Gen 3:4
    biblebook_name    = elements[0].dup
    biblebook         = Biblebook.find_by(name: biblebook_name)
    self.biblebook_id = biblebook.id
    # puts "\nbiblebook_id for book #{biblebook_name}: #{biblebook_id.inspect}"

    self.starting_chapter_nr = elements[1].to_i
    self.starting_verse      = elements[3].to_i

    if elements.length == 8 # full description of pericope
      self.ending_chapter_nr   = elements[5].to_i
      self.ending_verse        = elements[7].to_i
    else  # abbreviated description
      self.ending_chapter_nr   = starting_chapter_nr
      self.ending_verse        = elements[5].to_i
    end

    # puts "->->-> Pericope: | #{@biblebook_name} #{starting_chapter_nr} : #{starting_verse} - #{ending_chapter_nr} : #{ending_verse} |"
    # puts self.inspect
    # puts "\n------------------------\n"
  end
end
