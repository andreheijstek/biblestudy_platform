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
class PericopeValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @name   = record.name
    if empty_record?
      @record.errors.add :name, I18n.t('name_not_empty')
      return
    end

    validate_name
  end

  private

  # Validates a pericope record
  # To do that, a record is composed from the name
  # Check if
  # - name is a valid pericpe_string
  # - the biblebook in the name exists
  # - the order of chapters/verses
  def validate_name
    @parsed_pericope = parse_pericope(@name)
    @parsed_pericope.errors&.each { |error| @record.errors.add :name, error }
    return unless find_biblebook
    update_record
  end

  def parse_pericope(name)
    @parsed_pericope = PericopeString.new(name)
  end

  # Checks if the record is completely empty or contains an empty name string
  def empty_record?
    @name.nil? || @name.empty?
  end

  def find_biblebook
    biblebook_name                  = @parsed_pericope.biblebook_name
    @biblebook                      = find_by_full_name(biblebook_name) ||
                                      find_by_abbreviation(biblebook_name) ||
                                      find_by_like(biblebook_name)

    @parsed_pericope.biblebook_name = @biblebook.name unless @biblebook.nil?
    @biblebook
  end

  def find_by_full_name(name)
    @biblebook = Biblebook.find_by(name: name)
  end

  def find_by_abbreviation(name)
    @biblebook = Biblebook.find_by(abbreviation: name)
  end

  def find_by_like(name)
    biblebooks = Biblebook.where('name LIKE (?)',
                                 "%#{name.slice(0, 5)}%")
    check_found_biblebooks(biblebooks, name)
  end

  def check_found_biblebooks(biblebooks, name)
    errors = @record.errors
    if biblebooks.empty?
      errors.add :name, I18n.t('unknown_biblebook')
      @biblebook = nil
    elsif biblebooks.length > 1
      errors.add :name, ambiguous_string(name, biblebooks)
      @biblebook = nil
    else
      @biblebook = biblebooks[0]
    end
  end

  def ambiguous_string(book_name, biblebooks)
    book_list = []
    biblebooks.each { |book| book_list << book.name }
    "#{I18n.t('ambiguous_abbreviation')}: '#{book_name}' \
      kan #{book_list.join(', ')} zijn"
  end

  def update_record
    @record.tap do |record|
      record.biblebook_id   = @biblebook.id
      record.biblebook_name = @biblebook.name
      record.name           = @name

      record.starting_chapter_nr = @parsed_pericope.starting_chapter
      record.starting_verse      = @parsed_pericope.starting_verse
      record.ending_chapter_nr   = @parsed_pericope.ending_chapter
      record.ending_verse        = @parsed_pericope.ending_verse

      record.sequence = @record.starting_chapter_nr * 1000 + @record.starting_verse
    end
  end
end
