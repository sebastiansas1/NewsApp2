module ApiHelper
    require 'httparty'

    class GuardianApi

        KEY = "92a964bd-ab24-4367-b0e0-863008a6b7f5"
        PARAMS_KEY = "api-key=#{KEY}"

        include HTTParty 
        base_uri "content.guardianapis.com"

        def initialize(service, page)
            @options = { query: {site: service}}
        end

        def all_articles
            json = self.class.get("/search?#{PARAMS_KEY}&page-size=140&show-tags=keyword&show-fields=trailText,thumbnail,bodyText")
            response = json['response']
            articles = response['results']

            articles.each do |article|

                api_article_id = article['id']
                fields = article['fields']
                category = article['sectionName'].to_s
                headline = article['webTitle'].to_s
                subheading = fields['trailText'].to_s
                thumbnail = fields['thumbnail'].to_s
                bodyText = fields['bodyText'].to_s
                date = article['webPublicationDate']

                if !subheading['<'] && !bodyText.strip.empty? && !thumbnail.strip.empty? && category.mb_chars.length < 15
                
                    Category.create(name: category)
                    category_id = Category.find_by(:name => category).id

                    new_article = Article.new(api_id: api_article_id, headline: headline, subheading: subheading, body_text: bodyText, category_id: category_id, img_src: thumbnail, created_at: Time.now, updated_at: Time.now)

                    if new_article.save

                        tags = article['tags']

                        tags.each do |tag|
    
                            keyword = tag['webTitle'].to_s
                            # Associate keyword with article
                            cat = Category.find_by(:name => keyword)

                            if cat.nil?
                                Article.find_by(api_id: api_article_id).keywords.create(name: keyword, created_at: Time.now, updated_at: Time.now)
                            end
                        end
                    end
                end
            end
        end

        def related_articles(article_id)
            json = self.class.get("/#{article_id}?#{PARAMS_KEY}show-tags=keyword&show-fields=trailText,thumbnail,bodyText")



        end

    end

end



