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
# :reek:NilCheck: maybe solve later with null object
# :reek:TooManyStatements: as well
class PericopeValidator < ActiveModel::Validator
  # Validate method, as required by Rails, see class comment
  attr_accessor :record, :tree
  attr_reader :parsed_pericope
  private :record, :parsed_pericope, :tree

  def validate(record)
    @record = record
    parse_and_set_attributes
    return if record.name.empty?

    validate_pericope_order
    biblebook_name = record.biblebook_name

    biblebook = get_biblebook(biblebook_name)
    update_record(biblebook) unless biblebook.nil?
  end

  private

  def get_biblebook(biblebook_name)
    name, @errors = Biblebook.validate_name(biblebook_name, record.errors)
    Biblebook.find_by_full_name(name)[0]
  end

  def parse_and_set_attributes
    parse_name
    set_attributes
  end

  # Parses the 'name' attribute (something like 'Gen 1:2-3') into the
  # constituent parts of a Pericope
  def parse_name
    name = record.name
    return if name.empty?

    @tree = PericopeParser.new.parse(name)
  end

  def set_attributes
    return if record.name.empty?

    record.basic_attributes = tree
    add_missing_data
    record.populate_bibleverses
  end

  def add_missing_data
    if single_verse?
      set_ending_to_starting
    elsif multiple_verse_one_chapter?
      record.ending_chapter_nr = record.starting_chapter_nr
    end
  end

  def set_ending_to_starting
    record.ending_chapter_nr = record.starting_chapter_nr
    record.ending_verse_nr = record.starting_verse_nr
  end

  def single_verse?
    record.ending_chapter_nr.zero? && record.ending_verse_nr.zero?
  end

  def multiple_verse_one_chapter?
    end_chap = record.ending_chapter_nr
    (record.ending_verse_nr > record.starting_verse_nr) &&
      ((end_chap == record.starting_chapter_nr) || end_chap.zero?)
  end

  def validate_pericope_order
    short_pericope =
      record.whole_book? || record.whole_chapter? || record.single_verse?
    return if short_pericope
    return if record.starting_bibleverse <= record.ending_bibleverse

    record.errors.add :base, :verse_chapter_disorder
  end

  def validate_biblebook_name(given_name)
    name, @errors = Biblebook.validate_name(given_name, record.errors)
    name
  end

  #:reek:FeatureEnvy: don't know how to solve
  def update_record(biblebook)
    record.tap do |record|
      record.biblebook_id = biblebook.id
      record.biblebook_name = biblebook.name
      record.sequence =
        (record.starting_chapter_nr * 1000) + record.starting_verse_nr
    end
  end
end
