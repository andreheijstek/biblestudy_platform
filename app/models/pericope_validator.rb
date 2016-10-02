class PericopeValidator < ActiveModel::Validator
  def validate(record)
    if record.name.nil? || record.name.empty?
      record.errors[:name] << "Name can't be empty or nil"
      return
    end

    pericope = PericopeString.new(record.name)
    biblebook_name = pericope.biblebook_name
    biblebook      = Biblebook.find_by(name: biblebook_name)
    if biblebook.nil?
      record.errors[:name] << "Unknown biblebook"
      return
    end
    record.biblebook_id = biblebook.id

    record.starting_chapter_nr = pericope.starting_chapter
    record.starting_verse      = pericope.starting_verse
    record.ending_chapter_nr   = pericope.ending_chapter
    record.ending_verse        = pericope.ending_verse

    if record.starting_chapter_nr > record.ending_chapter_nr
      record.errors[:name] << "Starting chapter can't be greater than ending chapter"
      return
    end

    if (record.starting_chapter_nr == record.ending_chapter_nr) && (record.starting_verse > record.ending_verse)
      record.errors[:name] << "Starting verse can't be greater than ending verse within the same chapter"
      return
    end
  end
end
