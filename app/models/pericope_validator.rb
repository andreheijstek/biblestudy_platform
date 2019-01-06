# frozen_string_literal: true

# Validates a Pericope
#
# Checks on the order of the components
# - starting chapter < ending_chapter
# - starting_verse < ending_verse
# - contains existing biblebook
# - chapters withing valid range of biblebook
# - verses within valid range of chapter
#
# :reek:InstanceVariableAssumption, can't be fixed here, as I can't have an initializer
# :reek:NilCheck: maybe solve later with null object
# :reek:TooManyStatements: as well
class PericopeValidator < ActiveModel::Validator
  def validate(record)
    @record             = record
    given_pericope_name = record.name
    if given_pericope_name.empty?
      @record.errors.add :name, I18n.t('name_not_empty')
    else
      parsed_pericope     = parse_pericope(given_pericope_name)
      validate_pericope_order(parsed_pericope.starting_v, parsed_pericope.ending_v)
      full_biblebook_name = validate_biblebook_name(parsed_pericope.biblebook_name)
      biblebook           = Biblebook.find_by_full_name(full_biblebook_name)[0]
      update_record(parsed_pericope, biblebook) unless biblebook.nil?
    end
  end

  private

  attr_reader :record

  def parse_pericope(pericope_name)
    parsed_pericope = PericopeString.new(pericope_name)
    parsed_pericope.errors&.each { |error| @record.errors.add :name, error }
    parsed_pericope
  end

  def validate_pericope_order(starting_verse, ending_verse)
    record.errors.add :name, t('verse_chapter_disorder') if starting_verse > ending_verse
  end

  def validate_biblebook_name(given_name)
    names = Biblebook.possible_book_names(given_name)
    handle_multiple_names(names, given_name)
  end

  #:reek:TooManyStatements: no idea how to solve
  def handle_multiple_names(names, given_name)
    name             = ''
    errors           = record.errors
    nr_of_biblebooks = names.size
    if nr_of_biblebooks.zero?
      errors.add :name, t('unknown_biblebook')
    elsif nr_of_biblebooks == 1
      name = names[0]
    elsif nr_of_biblebooks > 1
      errors.add :name, t('ambiguous_abbreviation', given_name: given_name, biblebooks: names.join(', '))
    end
    name
  end

  #:reek:FeatureEnvy: don't know how to solve
  #:reek:TooManyStatements: no idea how to solve
  def update_record(pericope, biblebook)
    # Met een null object voor Biblebook, kan ik hier de attributen van het
    # null object lezen, en dus id op 0 zetten, name op ''
    # Ik heb dan ook een null object voor parsed pericope nodig, die alle
    # chapters/verses op 0 zet (en misschien wel meteen het biblebook)
    # De gebruikende modules gaan dat biblebook/pericope toch niet gebruiken
    # want er zijn errors en dus slaan ze al eerder af.
    @record.tap do |record|
      record.biblebook_id   = biblebook.id
      record.biblebook_name = biblebook.name
      record.name           = pericope.pericope_string

      record.starting_chapter_nr = pericope.starting_chapter
      record.starting_verse      = pericope.starting_verse
      record.ending_chapter_nr   = pericope.ending_chapter
      record.ending_verse        = pericope.ending_verse

      record.sequence = record.starting_chapter_nr * 1000 + record.starting_verse
    end
  end
end
