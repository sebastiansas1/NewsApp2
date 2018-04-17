namespace :custom_task do
  desc 'Updates the table of personal articles for each user in the system'
  task update_personal_articles: :environment do
    api = ApiHelper::GuardianApi.new('guardianapis', 2)
    Reader.all.each do |reader|
      puts "Doing articles for: #{reader.name}"
      return false if reader.preferences.nil?
      reader.preferences.order(relevance: :desc).limit(5).each do |preference|
        puts "category: #{preference.category}"
        return false if preference.nil?
        preference.keywords.order(relevance: :desc).limit(4).each do |keyword|
          puts "word: #{keyword.name}"
          api.search(keyword.tag, reader.id) unless keyword.nil?
        end
      end
    end
    puts "Personal Articles Updated from API at #{Time.now}"
  end

  desc 'Updates the table of all articles in the system'
  task get_new_articles: :environment do
    api = ApiHelper::GuardianApi.new('guardianapis', 1)
    api.all_articles
    puts "Articles Updated from API at #{Time.now}"
  end

  desc 'Clean the database off all old and unread articles'
  task clean_old_articles: :environment do
    @trash = Article.where(views: 0)
                             .where("created_at > '#{2.days.ago}'")

    puts "#{@trash.count} Articles cleaned from database!"

    @trash.each do |article|
      article.keywords.each do |keyword|
        keyword.delete
      end
      article.delete
    end
  end
end
