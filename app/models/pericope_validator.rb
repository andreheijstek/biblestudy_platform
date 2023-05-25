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
# :reek:TooManyMethods
# rubocop:disable Metrics/ClassLength:
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
  # rubocop:disable Metrics/MethodLength Metrics/AbcSize
  def parse_and_set_attributes
    name = record.name
    return if name.empty?

    tree = PericopeParser.new.parse(name)

    record.biblebook_name = tree[:biblebook].to_s.strip
    record.start_verse =
      BibleVerse.new(
        {
          chapter: tree[:starting_chapter].to_i,
          verse: tree[:starting_verse].to_i
        }
      )
    record.end_verse =
      BibleVerse.new(
        { chapter: tree[:ending_chapter].to_i, verse: tree[:ending_verse].to_i }
      )

    add_missing_data

    record.populate_bibleverses
  end
  # rubocop:enable Metrics/MethodLength

  def full_pericope_starting_with_full_chapter?
    start_verse = record.start_verse
    start_verse.verse == 1 && record.end_verse.chapter > start_verse.chapter
  end

  def full_pericope_ending_with_full_chapter?
    end_verse = record.end_verse
    end_verse.verse_nr == 1 && end_verse.chapter > record.start_verse.chapter
  end

  # :reek:DuplicateMethodCall - removing more duplicates makes it less readable
  # rubocop:disable Metrics/MethodLength Metrics/AbcSize Metrics/CyclomaticComplexity Metrics/PerceivedComplexity
  def add_missing_data
    start_verse = record.start_verse
    end_verse = record.end_verse
    if whole_biblebook?
      start_verse.chapter = 1
      start_verse.verse = 1
      end_verse.chapter = last_chapter
      end_verse.verse = last_verse(end_verse.chapter)
    elsif single_verse?
      set_ending_to_starting
    elsif single_chapter?
      start_verse.verse = 1
      set_end_chap_to_start_chap(end_verse, start_verse)
      end_verse.verse = last_verse(end_verse.chapter)
    elsif multiple_verses_one_chapter?
      end_verse.chapter = start_verse.chapter
    elsif multiple_full_chapters?
      start_verse.verse = 1
      end_verse.verse = last_verse(end_verse.chapter)
    elsif full_pericope_starting_with_full_chapter?
      start_verse.verse = 1
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

  # :reek:UtilityFunction
  def set_end_chap_to_start_chap(end_verse, start_verse)
    end_verse.chapter = start_verse.chapter
  end

  def last_verse(chapter)
    get_biblebook(record.biblebook_name).chapters[chapter - 1].nrofverses
  end

  def last_chapter
    get_biblebook(record.biblebook_name).nr_of_chapters
  end

  def set_ending_to_starting
    start_verse = record.start_verse
    end_verse = record.end_verse

    end_verse.chapter = start_verse.chapter
    end_verse.verse = start_verse.verse
  end

  def single_verse?
    end_verse = record.end_verse

    record.start_verse.verse.positive? && end_verse.chapter.zero? &&
      end_verse.verse.zero?
  end

  def whole_biblebook?
    start_verse = record.start_verse
    end_verse = record.end_verse

    start_verse.chapter.zero? && start_verse.verse.zero? &&
      end_verse.chapter.zero? && end_verse.verse.zero?
  end

  def single_chapter?
    start_verse = record.start_verse
    end_verse = record.end_verse

    start_verse.chapter.positive? && start_verse.verse.zero? &&
      end_verse.chapter.zero? && end_verse.verse.zero?
  end

  def multiple_full_chapters?
    start_verse = record.start_verse
    end_verse = record.end_verse

    start_verse.verse.zero? && end_verse.verse.zero? &&
      end_verse.chapter > start_verse.chapter
  end

  def multiple_verses_one_chapter?
    start_verse = record.start_verse
    end_verse = record.end_verse
    end_chap = end_verse.chapter

    (end_verse.verse > start_verse.verse) &&
      ((end_chap == start_verse.chapter) || end_chap.zero?)
  end

  def full_pericope?
    start_verse = record.start_verse
    end_verse = record.end_verse
    start_verse.chapter.positive? && start_verse.verse.positive? &&
      end_verse.chapter.positive? && end_verse.verse.positive?
  end

  def validate_pericope_order
    short_pericope =
      record.whole_book? || record.whole_chapter? || record.single_verse?
    return if short_pericope
    return if record.starting_bibleverse <= record.ending_bibleverse

    record.errors.add :base, :verse_chapter_disorder
  end

  # :reek:FeatureEnvy don't know how to solve
  def update_record(biblebook)
    record.tap do |record|
      record.biblebook_id = biblebook.id
      record.biblebook_name = biblebook.name
      start_verse = record.start_verse
      record.sequence = (start_verse.chapter * 1000) + start_verse.verse
    end
  end
end
# rubocop:enable Metrics/ClassLength:
