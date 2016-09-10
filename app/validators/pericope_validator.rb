class PericopeValidator < ActiveModel::Validator
  def validate(record)
    if record.name.nil? || record.name.empty?
      record.errors[:base] << "Name can't be empty or nil"
      return
    end

    elements = record.name.split(/\b/).delete_if {|e| e == " "}
    # puts "\n\n->->-> name: #{name}, elements: #{elements}"

    # 'Genesis 1:2-3:4' or Gen 1:2-4 or Gen 1:2-3:4 or Gen 1:2 - Gen 3:4
    biblebook_name    = elements[0].dup
    biblebook         = Biblebook.find_by(name: biblebook_name)
    record.biblebook_id = biblebook.id
    # puts "\nbiblebook_id for book #{biblebook_name}: #{biblebook_id.inspect}"

    record.starting_chapter_nr = elements[1].to_i
    record.starting_verse      = elements[3].to_i

    if elements.length == 8 # full description of pericope
      record.ending_chapter_nr   = elements[5].to_i
      record.ending_verse        = elements[7].to_i
    else  # abbreviated description
      record.ending_chapter_nr   = record.starting_chapter_nr
      record.ending_verse        = elements[5].to_i
    end

    if record.starting_chapter_nr > record.ending_chapter_nr
      record.errors[:base] << "Starting chapter can't be greater than ending chapter"
      return
    end

    if (record.starting_chapter_nr == record.ending_chapter_nr) && (record.starting_verse > record.ending_verse)
      record.errors[:base] << "Starting verse can't be greater than ending verse within the same chapter"
      return
    end
    # puts "->->-> Pericope: | #{@biblebook_name} #{starting_chapter_nr} : #{starting_verse} - #{ending_chapter_nr} : #{ending_verse} |"
    # puts self.inspect
    # puts "\n------------------------\n"
  end
end
