class Pericope < ActiveRecord::Base
  belongs_to :study_note
  has_one :biblebook
  has_one :starting_chapter
  has_one :ending_chapter

  @biblebook_name      = ""
  @starting_chapter_nr = 0
  @ending_chapter_nr   = 0
  @starting_verse      = 0
  @ending_verse        = 0

  # validates :name, presence: true
  def set
    parse_name
    self.save!
  end

  private

  def parse_name
    elements = name.split(/\b/).delete_if {|e| e == " "}
    puts "name: #{name}, elements: #{elements}"

    # 'Genesis 1:2-3:4' or Gen 1:2-4 or Gen 1:2-3:4 or Gen 1:2 - Gen 3:4

    @biblebook_name          = elements[0].dup
    self.starting_chapter_nr = elements[1].to_i
    self.starting_verse      = elements[3].to_i
    self.ending_chapter_nr   = elements[5].to_i
    self.ending_verse        = elements[7].to_i

    puts "Pericope: | #{@biblebook_name} #{starting_chapter_nr} : #{starting_verse} - #{ending_chapter_nr} : #{ending_verse} |"
  end
end
