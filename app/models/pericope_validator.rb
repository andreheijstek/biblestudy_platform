# frozen_string_literal: true

# Validates a Pericope
#
# Checks on the order of the components
# - starting chapter < ending_chapter
# - starting_verse < ending_verse
# - contains existing biblebook
# TODO: - chapters within valid range of biblebook
# TODO: - verses within valid range of chapter
# TODO: - give better error messages and show these in views, iso not saved
#
# :reek:InstanceVariableAssumption, can't be fixed here,
# as I can't have an initializer
# :reek:NilCheck maybe solve later with null object
# :reek:TooManyStatements as well
class PericopeValidator < ActiveModel::Validator
  # Validate method, as required by Rails, see class comment
  attr_accessor :record
  attr_reader :parsed_pericope
  private :record, :parsed_pericope

  def validate(record)
    @record = record
    parse_and_set_attributes
    return if record.name.empty?

    validate_pericope_order

    biblebook = get_biblebook(record.biblebook_name)
    update_record(biblebook) unless biblebook.nil?
  end

  private

  def get_biblebook(biblebook_name)
    name, @errors = Biblebook.validate_name(biblebook_name, record.errors)
    Biblebook.find_by_full_name(name)[0]
  end

  # Parses the 'name' attribute (something like 'Gen 1:2-3') into the
  # constituent parts of a Pericope
  def parse_and_set_attributes
    name = record.name
    return if name.empty?

    tree = PericopeParser.new.parse(name)

    record.biblebook_name = tree[:biblebook].to_s.strip
    record.starting_chapter_nr = tree[:starting_chapter].to_i
    record.starting_verse = tree[:starting_verse].to_i
    record.ending_chapter_nr = tree[:ending_chapter].to_i
    record.ending_verse = tree[:ending_verse].to_i

    add_missing_data
    record.populate_bibleverses
  end

  def full_pericope_starting_with_full_chapter?
    record.starting_verse == 1 &&
      record.ending_chapter_nr > record.starting_chapter_nr
  end

  def full_pericope_ending_with_full_chapter?
    record.ending_verse_nr == 1 &&
      record.ending_chapter_nr > record.starting_chapter_nr
  end

  def add_missing_data
    if whole_biblebook?
      record.starting_chapter_nr = 1
      record.starting_verse = 1
      record.ending_chapter_nr = last_chapter
      record.ending_verse = last_verse(record.ending_chapter_nr)
    elsif single_verse?
      set_ending_to_starting
    elsif single_chapter?
      record.starting_verse = 1
      record.ending_chapter_nr = record.starting_chapter_nr
      record.ending_verse = last_verse(record.ending_chapter_nr)
    elsif multiple_verses_one_chapter?
      record.ending_chapter_nr = record.starting_chapter_nr
    elsif multiple_full_chapters?
      record.starting_verse = 1
      record.ending_verse = last_verse(record.ending_chapter_nr)
    elsif full_pericope_starting_with_full_chapter?
      record.starting_verse = 1
    elsif full_pericope?
      # do nothing
    else
      begin
        raise "unknown pericope type"
      rescue => e
        Rails.logger e.message
        Rails.logger e.backtrace.inspect
      end
    end
  end

  def last_verse(chapter)
    get_biblebook(record.biblebook_name).chapters[chapter - 1].nrofverses
  end

  def last_chapter
    get_biblebook(record.biblebook_name).nr_of_chapters
  end

  def set_ending_to_starting
    record.ending_chapter_nr = record.starting_chapter_nr
    record.ending_verse = record.starting_verse
  end

  def single_verse?
    record.starting_verse.positive? &&
      record.ending_chapter_nr.zero? &&
      record.ending_verse.zero?
  end

  def whole_biblebook?
    record.starting_chapter_nr.zero? &&
      record.starting_verse.zero? &&
      record.ending_chapter_nr.zero? &&
      record.ending_verse.zero?
  end

  def single_chapter?
    record.starting_chapter_nr.positive? &&
      record.starting_verse.zero? &&
      record.ending_chapter_nr.zero? &&
      record.ending_verse.zero?
  end

  def multiple_full_chapters?
    record.starting_verse.zero? &&
      record.ending_verse.zero? &&
      record.ending_chapter_nr > record.starting_chapter_nr
  end

  def multiple_verses_one_chapter?
    end_chap = record.ending_chapter_nr
    (record.ending_verse > record.starting_verse) &&
      ((end_chap == record.starting_chapter_nr) || end_chap.zero?)
  end

  def full_pericope?
    record.starting_chapter_nr.positive? && record.starting_verse.positive? && record.ending_chapter_nr.positive? && record.ending_verse.positive?
  end

  def validate_pericope_order
    short_pericope =
      record.whole_book? || record.whole_chapter? || record.single_verse?
    return if short_pericope
    return if record.starting_bibleverse <= record.ending_bibleverse

    record.errors.add :base, :verse_chapter_disorder
  end
  
  #:reek:FeatureEnvy don't know how to solve
  def update_record(biblebook)
    record.tap do |record|
      record.biblebook_id = biblebook.id
      record.biblebook_name = biblebook.name
      record.sequence =
        (record.starting_chapter_nr * 1000) + record.starting_verse
    end
  end
end
