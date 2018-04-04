# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include ApiHelper

Reader.create!([{ id: 1, email: "lorena@gmail.com", password: "SDxDm123", :password_confirmation => "SDxDm123", created_at: Time.now, updated_at: Time.now, name: "Lorena" },
                   { id: 2, email: "mike@gmail.com", password: "SDxDm123", :password_confirmation => "SDxDm123", created_at: Time.now, updated_at: Time.now, name: "Mike" }])

Admin.create!( id: 1, email: "sebastiansasbusiness@gmail.com", password: "SDxDm123", :password_confirmation => "SDxDm123", created_at: Time.now, updated_at: Time.now, name: "Sebastian" )

Category.create!([{name: "Business"}, {name: "Technology"}, {name: "General"}, {name: "Health"}, {name: "Entertainment"}, {name: "Politics"}, {name: "Sports"}, {name: "Lifestyle"}])

api = ApiHelper::GuardianApi.new('guardianapis', 1)
        
@articles = api.all_articles 

@articles.each do |article|
    fields = article['fields']

    headline = article['webTitle'].to_s
    subheading = fields['trailText'].to_s
    thumbnail = fields['thumbnail'].to_s
    bodyText = fields['bodyText'].to_s
    category = article['sectionName'].to_s

    if !subheading.to_s['<'] && !bodyText.to_s.strip.empty? && !thumbnail.to_s.strip.empty?
        
        Article.create!(headline: headline, subheading: subheading, body_text: bodyText, img_src: thumbnail, created_at: Time.now, updated_at: Time.now, category_id: 1)

    end
end


p "Created #{Category.count} things"

