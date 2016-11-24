class PericopeValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    return if emptyRecord?

    getPericope
    return if @pericope.nil?

    findBiblebook
    return if @biblebook.nil?
    updateRecord
    return if incorrectSequence?
  end

  private

  def getPericope
    begin
      @pericope = PericopeString.new(@record.name)
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
      return
    end

    if (@record.starting_chapter_nr == @record.ending_chapter_nr) && (@record.starting_verse > @record.ending_verse)
      @record.errors[:name] << I18n.t("starting_verse_chapter_mismatch")
      return
    end
  end

  def findBiblebook
    @biblebook_name = @pericope.biblebook_name
    @biblebook = findByFullName
    if @biblebook.nil?
      @biblebook = findByAbbreviation
      if @biblebook.nil?
        @biblebook = findByLike
      end
    end
    @pericope.biblebook_name = @biblebook.name unless @biblebook.nil? # Replace the abbreviation with the full name
    @biblebook_name = @pericope.biblebook_name
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

    @record.starting_chapter_nr = @pericope.starting_chapter
    @record.starting_verse = @pericope.starting_verse
    @record.ending_chapter_nr = @pericope.ending_chapter
    @record.ending_verse = @pericope.ending_verse

    name = reformatName
    @record.name = name
  end

  def reformatName
    name = ""
    name << @biblebook_name
    name << " "
    name << @pericope.starting_chapter.to_s
    if @pericope.ending_chapter > @pericope.starting_chapter
      name << ":"
      name << @pericope.starting_verse.to_s
      name << " - "
      name << @pericope.ending_chapter.to_s
      name << ":"
      name << @pericope.ending_verse.to_s
    elsif @pericope.ending_verse > @pericope.starting_verse
      name << ":"
      name << @pericope.starting_verse.to_s
      name << " - "
      name << @pericope.ending_verse.to_s
    end
    name
    # "#{@biblebook.name} #{@pericope.starting_chapter}:#{@pericope.starting_verse} - #{@pericope.ending_chapter}:#{@pericope.ending_verse}"
  end
end
