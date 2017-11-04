# Validates a Pericope
#
# Checks on the order of the components
# - starting chapter < ending_chapter
# - starting_verse < ending_verse
# - contains existing biblebook
# - chapters withing valid range of biblebook
# - verses within valid range of chapter
# And it writes a correctly formatted string for biblebook into the Pericope record
#
class PericopeValidator < ActiveModel::Validator

  def validate(record)
    @record = record
    @name = record.name
    return if empty_record?

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
    begin
      @pericope_to_publish = PericopeString.new(@name)
    rescue
      self.errors.add :name, I18n.t('invalid_pericope')
    end

    return if find_biblebook.nil?
    update_record
    validate_sequence
  end

  # Turns a String into a PericopeString, so the scan method can be used
  # and sets the error message
  # Deze method krijgt @record.name als input, die is al gezet als een Pericope wordt gemaakt
  # Levert dan een @pericope_to_publish op
  # In de nieuwe situatie met Pericope.new dat gaan doen. Dan is er geen @pericope_to_publish
  # meer, maar zijn wel alle Pericope attributen al gezet
  # def create_pericope_from_string
  #   begin
  #     @pericope_to_publish = PericopeString.new(@record.name)
  #       # TODO: Can this dependecy be removed? Pass in the PericopeString in the constructor?
  #   rescue
  #     @record.errors[:name] << I18n.t('invalid_pericope')
  #   end
  # end


  # Checks if the sequence of chapters and verses is correct
  # and sets the error message
  def validate_sequence
    if @record.starting_chapter_nr > @record.ending_chapter_nr
      @record.errors[:name] << I18n.t('starting_greater_than_ending')
      return false
    end

    if (@record.starting_chapter_nr == @record.ending_chapter_nr) &&
        (@record.starting_verse > @record.ending_verse)
      @record.errors[:name] << I18n.t('starting_verse_chapter_mismatch')
      return false
    end
    true
  end

  # TODO: ik weet niet of deze message nodig is. Als een pericope goed gemaakt is, is de
  # afgekorte bijbelboeknaam toch al vervangen door de gehele naam. Je hebt dan deze indirectie
  # niet meer nodig
  def biblebook_name
    Biblebook.find(self.biblebook_id).name
  end

  # Checks if the record is completely empty or contains an empty name string
  # and sets the error message
  def empty_record?
    if @name.nil? || @name.empty?
      @record.errors[:name] << I18n.t('name_not_empty')
      return true
    end
    false
  end

  def find_biblebook
    @biblebook_name = @pericope_to_publish.biblebook_name
    @biblebook = find_by_full_name
    if @biblebook.nil?
      @biblebook = find_by_abbreviation
      @biblebook = find_by_like if @biblebook.nil?
    end
    @pericope_to_publish.biblebook_name = @biblebook.name unless @biblebook.nil?
    # Replace the abbreviation with the full name
    # @biblebook_name = @pericope_to_publish.biblebook_name
    @biblebook
  end

  def find_by_full_name
    @biblebook = Biblebook.find_by(name: @biblebook_name)
  end

  def find_by_abbreviation
    @biblebook = Biblebook.find_by(abbreviation: @biblebook_name)
  end

  def find_by_like
    biblebooks = Biblebook.where('name LIKE (?)',
                                 "%#{@biblebook_name.slice(0, 5)}%")
    if biblebooks.empty?
      @record.errors[:name] << I18n.t('unknown_biblebook')
      @biblebook = nil
    elsif biblebooks.length > 1
      @record.errors[:name] << ambiguous_string(@biblebook_name, biblebooks)
      @biblebook = nil
    else
      @biblebook = biblebooks[0]
    end
  end

  def ambiguous_string(book_name, biblebooks)
    book_list = []
    biblebooks.each do |book|
      book_list << book.name
    end
    "#{I18n.t('ambiguous_abbreviation')}: '#{book_name}' kan #{book_list.join(', ')} zijn"
  end

  def update_record
    @record.biblebook_id = @biblebook.id
    @record.biblebook_name = @biblebook.name
    @record.name = @name

    @record.starting_chapter_nr = @pericope_to_publish.starting_chapter
    @record.starting_verse = @pericope_to_publish.starting_verse
    @record.ending_chapter_nr = @pericope_to_publish.ending_chapter
    @record.ending_verse = @pericope_to_publish.ending_verse

    @record.sequence = @record.starting_chapter_nr * 1000 + @record.starting_verse
  end
end
