# frozen_string_literal: true

def replace_newlines(sn)
  sn.note.gsub!(/\r\n/, '<br>')
  sn.note.gsub!('<br><br>', '<br>')
  # sn.note = '<p>' + sn.note + '</p>'
  sn.save!
end

namespace :biblestudy_platform do
  desc 'Replace \r\n newlines in studynotes by <p> tags'
  task replace_newlines: :environment do
    count = Studynote.count
    log("updating #{count} studynotes")

    Studynote.all.each do |sn|
      replace_newlines(sn)
      print '.'
    end

    log('done')
  end

  def log(msg)
    puts msg
    Rails.logger.info msg
  end
end
