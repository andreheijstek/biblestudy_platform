class Pericope < ActiveRecord::Base
  belongs_to :study_note
  has_one :biblebook

  # validates :name, presence: true

  def after_initialize
    parse_name
    self.save!
  end

  # set only exists temporarily to allow testing the parsing method
  # can be removed when the after_initialize is working well

  def set
    parse_name
    self.save!
  end

  private

  def parse_name
    elements = name.split(/\b/).delete_if {|e| e == " "}
    puts "name: #{name}, elements: #{elements}"

    # 'Genesis 1:2-3:4' or Gen 1:2-4 or Gen 1:2-3:4 or Gen 1:2 - Gen 3:4

    biblebook_name           = elements[0].dup
    self.biblebook_id        = Biblebook.find_by(name: biblebook_name)
    # puts "\nbiblebook_id: #{self.biblebook_id.inspect}"

    self.starting_chapter_nr = elements[1].to_i
    self.starting_verse      = elements[3].to_i

    if elements.length == 8 # full description of pericope
      self.ending_chapter_nr   = elements[5].to_i
      self.ending_verse        = elements[7].to_i
    else  # abbreviated description
      self.ending_chapter_nr   = starting_chapter_nr
      self.ending_verse        = elements[5].to_i
    end

    puts "Pericope: | #{@biblebook_name} #{starting_chapter_nr} : #{starting_verse} - #{ending_chapter_nr} : #{ending_verse} |"
  end
end
