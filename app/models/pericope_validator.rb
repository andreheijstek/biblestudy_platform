# frozen_string_literal: true

require_relative "../../lib/pericope_validator_utilities"
include PericopeValidatorUtilities
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
# rubocop:disable Metrics/ClassLength:

class PericopeValidator < ActiveModel::Validator
  # Validate method, as required by Rails, see class comment
  attr_accessor :record

  def validate(record)
    @record = record
    parse_and_set_attributes
    return if record.name.empty?

    validate_pericope_order

    biblebook = get_biblebook(record.biblebook_name)
    update_record(biblebook) unless biblebook.nil?
  end

  private

  attr_reader :start_verse, :end_verse

  def get_biblebook(biblebook_name)
    name, @errors = Biblebook.validate_name(biblebook_name, record.errors)
    Biblebook.find_by_full_name(name)[0]
  end

  # Parses the 'name' attribute (something like 'Gen 1:2-3') into the
  # constituent parts of a Pericope
  # rubocop:disable Metrics/MethodLength Metrics/AbcSize
  def parse_and_set_attributes
    name = record.name
    return if name.empty?

    tree = PericopeParser.new.parse(name)

    record.biblebook_name = get_biblebook_from_tree(tree)
    record.start_verse =
      BibleVerse.new(
        {
          chapter_nr: get_starting_chapter_from_tree(tree),
          verse_nr: get_starting_verse_from_tree(tree)
        }
      )
    record.end_verse =
      BibleVerse.new(
        {
          chapter_nr: get_ending_chapter_from_tree(tree),
          verse_nr: get_ending_verse_from_tree(tree)
        }
      )

    @start_verse = record.start_verse
    @end_verse = record.end_verse

    add_missing_data

    record.populate_bibleverses
  end

  # rubocop:enable Metrics/MethodLength
  # :reek:DuplicateMethodCall - removing more duplicates makes it less readable
  # rubocop:disable Metrics/MethodLength Metrics/AbcSize Metrics/CyclomaticComplexity Metrics/PerceivedComplexity
  def add_missing_data
    if whole_biblebook?
      start_verse.chapter_nr = 1
      start_verse.verse_nr = 1
      end_verse.chapter_nr = last_chapter
      end_verse.verse_nr = last_verse(end_verse.chapter_nr)
    elsif single_verse?
      set_ending_to_starting
    elsif single_chapter?
      start_verse.verse_nr = 1
      set_end_chap_to_start_chap(end_verse, start_verse)
      end_verse.verse_nr = last_verse(end_verse.chapter_nr)
    elsif multiple_verses_one_chapter?
      end_verse.chapter_nr = start_verse.chapter_nr
    elsif multiple_full_chapters?
      start_verse.verse_nr = 1
      end_verse.verse_nr = last_verse(end_verse.chapter_nr)
    elsif full_pericope_starting_with_full_chapter?
      start_verse.verse_nr = 1
    elsif full_pericope?
      # do nothing
    else
      begin
        raise "unknown pericope type"
      rescue StandardError => error
        Rails.logger error.message
        Rails.logger error.backtrace.inspect
      end
    end
  end

  def last_verse(chapter)
    get_biblebook(record.biblebook_name).chapters[chapter - 1].nrofverses
  end

  def validate_pericope_order
    return if short_pericope?
    return if order_ok?

    record.errors.add :base, :verse_chapter_disorder
  end

  # :reek:FeatureEnvy don't know how to solve
  def update_record(biblebook)
    record.tap do |record|
      record.biblebook_id = biblebook.id
      record.biblebook_name = biblebook.name
      record.sequence = (start_verse.chapter_nr * 1000) + start_verse.verse_nr
    end
  end
end
# rubocop:enable Metrics/ClassLength:
