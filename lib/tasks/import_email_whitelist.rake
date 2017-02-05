require 'csv'    

namespace :importcsv do
  desc 'Import email whitelist from CSV'
  task :whitelist => :environment do
    CSV.foreach(Rails.root + 'app/assets/data/boothhacks_members.csv', :headers => false) do |row|
      Whitelist.create(
        :first_name => row[0],
        :last_name => row[1],
        :email => row[2].downcase,
        :member => row[3]
      )
    end
    Whitelist.where(:member => 'No').destroy_all
  end
end
