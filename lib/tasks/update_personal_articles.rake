namespace :custom_task do
  desc 'Updates the table of personal articles for each user in the system'
  task :update_personal_articles => :environment do
    api = ApiHelper::GuardianApi.new('guardianapis', 2)
    Reader.all.each do |reader|
      unless reader.preferences.nil?
        reader.preferences.order(relevance: :desc).limit(5).each do |preference|
          unless preference.nil?
            preference.keywords.order(relevance: :desc).limit(4).each do |keyword|
              api.search(keyword.tag, reader.id) unless keyword.nil?
            end
          end
        end
      end
    end
    puts "Personal Articles Updated from API at #{Time.now}"
  end

  desc 'Updates the table of all articles in the system'
  task :get_new_articles => :environment do 
    api = ApiHelper::GuardianApi.new('guardianapis', 1)
    api.all_articles
    puts "Articles Updated from API at #{Time.now}"
  end
end
