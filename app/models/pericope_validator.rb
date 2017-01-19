class PericopeValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    return if emptyRecord?

    getPericope
    return if @studynote_to_publish.nil?

    findBiblebook
    return if @biblebook.nil?
    updateRecord
    return if incorrectSequence?

    name = reformatName
    @record.name = name
  end

  private

  def getPericope
    begin
      @studynote_to_publish = PericopeString.new(@record.name)
    rescue
      @record.errors[:name] << I18n.t("invalid_pericope")
    end
  end

  def emptyRecord?
    if @record.name.nil? || @record.name.empty?
      @record.errors[:name] << I18n.t("name_not_empty")
      return true
    end
    false
  end

  def incorrectSequence?
    if @record.starting_chapter_nr > @record.ending_chapter_nr
      @record.errors[:name] << I18n.t("starting_greater_than_ending")
      return true
    end

    if (@record.starting_chapter_nr == @record.ending_chapter_nr) && (@record.starting_verse > @record.ending_verse)
      @record.errors[:name] << I18n.t("starting_verse_chapter_mismatch")
      return true
    end
    false
  end

  def findBiblebook
    @biblebook_name = @studynote_to_publish.biblebook_name
    @biblebook = findByFullName
    if @biblebook.nil?
      @biblebook = findByAbbreviation
      if @biblebook.nil?
        @biblebook = findByLike
      end
    end
    @studynote_to_publish.biblebook_name = @biblebook.name unless @biblebook.nil? # Replace the abbreviation with the full name
    @biblebook_name = @studynote_to_publish.biblebook_name
  end

  def findByFullName
    @biblebook = Biblebook.find_by(name: @biblebook_name)
  end

  def findByAbbreviation
    @biblebook = Biblebook.find_by(abbreviation: @biblebook_name)
  end

  def findByLike
    biblebooks = Biblebook.where("name LIKE (?)", "%#{@biblebook_name.slice(0, 5)}%")
    if biblebooks.length == 0
      @record.errors[:name] << I18n.t("unknown_biblebook")
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

  def updateRecord
    @record.biblebook_id = @biblebook.id
    @record.biblebook_name = @biblebook_name

    @record.starting_chapter_nr = @studynote_to_publish.starting_chapter
    @record.starting_verse = @studynote_to_publish.starting_verse
    @record.ending_chapter_nr = @studynote_to_publish.ending_chapter
    @record.ending_verse = @studynote_to_publish.ending_verse

    @record.sequence = @record.starting_chapter_nr * 1000 + @record.starting_verse
  end

  def reformatName
    name = ""
    name << @biblebook_name
    name << " "
    name << @studynote_to_publish.starting_chapter.to_s
    if @studynote_to_publish.ending_chapter > @studynote_to_publish.starting_chapter
      name << ":"
      name << @studynote_to_publish.starting_verse.to_s
      name << " - "
      name << @studynote_to_publish.ending_chapter.to_s
      name << ":"
      name << @studynote_to_publish.ending_verse.to_s
    elsif @studynote_to_publish.ending_verse > @studynote_to_publish.starting_verse
      name << ":"
      name << @studynote_to_publish.starting_verse.to_s
      name << " - "
      name << @studynote_to_publish.ending_verse.to_s
    end
    name
    # "#{@biblebook.name} #{@pericope.starting_chapter}:#{@pericope.starting_verse} - #{@pericope.ending_chapter}:#{@pericope.ending_verse}"
  end
end
