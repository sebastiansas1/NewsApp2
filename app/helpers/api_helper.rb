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
            json = self.class.get("/search?#{PARAMS_KEY}&page-size=20&show-fields=trailText,thumbnail,bodyText")
            # json = self.class.get("/search?#{PARAMS_KEY}", @options)
            response = json['response']
            articles = response['results']

            articles.each do |article|
                fields = article['fields']

                headline = article['webTitle'].to_s
                subheading = fields['trailText'].to_s
                thumbnail = fields['thumbnail'].to_s
                bodyText = fields['bodyText'].to_s
                category = article['sectionName'].to_s

                if !subheading.to_s['<'] && !bodyText.to_s.strip.empty? && !thumbnail.to_s.strip.empty?
                    
                    Article.create(headline: headline, subheading: subheading, body_text: bodyText, category_id: 1, img_src: thumbnail, created_at: Time.now, updated_at: Time.now)
                 
                end
            end
        end
    end

end



