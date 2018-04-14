# require 'rufus-scheduler'

# scheduler = Rufus::Scheduler.singleton

# scheduler.every '6h' do
#   api = ApiHelper::GuardianApi.new('guardianapis', 1)
#   api.all_articles
#   puts "Articles Updated from API at #{Time.now}"
# end

# scheduler.every '10m' do
#   api = ApiHelper::GuardianApi.new('guardianapis', 2)

#   Reader.all.each do |reader|
#     unless reader.preferences.nil?
#       reader.preferences.order(relevance: :desc).limit(5).each do |preference|
#         unless preference.nil?
#           preference.keywords.order(relevance: :desc).limit(4).each do |keyword|
#             api.search(keyword.tag, reader.id) unless keyword.nil?
#           end
#         end
#       end
#     end
#   end

#   puts "Personal Articles Updated from API at #{Time.now}"
# end
