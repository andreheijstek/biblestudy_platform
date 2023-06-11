# frozen_string_literal: true

def replace_newlines(sn)
  sn.note.gsub!(/\r\n/, '<br>')
  sn.note.gsub!('<br><br>', '<br>')
  # sn.note = '<p>' + sn.note + '</p>'
  sn.save!
end

namespace :bp do
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

  desc 'run rails in Production environment'
  task :run_prod do
    system "RAILS_ENV=production rails server -p 3010"
  end

  desc 'backup the current database'
  task backup: :environment do
    date = Time.now.strftime("%Y%m%d")
    system "sudo -u andreheijstek pg_dump biblestudy_platform_#{Rails.env} > backup_#{Rails.env}_#{date}.sql"
  end

  def log(msg)
    puts msg
    Rails.logger.info msg
  end
end
