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
  end

  private

  def parse_name
    elements = name.split
    puts "elements: #{elements}"

    get_biblebook_name(elements[0])
    get_starting_chapter_and_verse(elements[1])
    get_ending_chapter_and_verse(elements[3])

    puts "Pericope: | #{@biblebook_name} | #{@starting_chapter_nr} | #{@ending_chapter_nr} | #{@starting_verse} | #{@ending_verse} |"
  end

  def get_biblebook_name(str)
    @biblebook_name = str.dup
  end

  def get_starting_chapter_and_verse(str)
    elements = str.split(':')
    @starting_chapter_nr = elements[0]
    @starting_verse      = elements[1]
  end

  def get_ending_chapter_and_verse(str)
    elements = str.split(':')
    @ending_chapter_nr = elements[0]
    @ending_verse      = elements[1]
  end
end
