# Module containing the GuardianApi class #
module ApiHelper
  require 'httparty'

  # Class to interact with the Guardian API #
  class GuardianApi
    KEY = '92a964bd-ab24-4367-b0e0-863008a6b7f5'.freeze
    PARAMS_KEY = "api-key=#{KEY}".freeze
    PAGE_SIZE = '&page-size=50'.freeze
    TAGS_KEYWORD = '&show-tags=keyword'.freeze
    FIELDS_ARTICLE = '&show-fields=trailText,thumbnail,bodyText'.freeze

    include HTTParty
    base_uri 'content.guardianapis.com'

    def initialize(service, _page)
      @options = { query: { site: service } }
    end

    # Method that returns all new articles (limited to 50)
    # from the Guardian API #
    def all_articles
      json = self.class.get("/search?#{PARAMS_KEY}#{PAGE_SIZE}#{TAGS_KEYWORD}#{FIELDS_ARTICLE}")
      response = json['response']
      articles = response['results']

      articles.each do |article|
        parse_article(article)
      end
    end

    def search(tag_id, reader_id)
      json = self.class.get("/search?#{PARAMS_KEY}#{PAGE_SIZE}#{TAGS_KEYWORD}#{FIELDS_ARTICLE}&tag=#{tag_id}")
      response = json['response']
      articles = response['results']

      articles.each do |article|
        parse_personal_article(article, reader_id)
      end
    end

    private

    def parse_article(article)
      api_article_id = article['id']
      category = article['sectionName'].to_s
      headline = article['webTitle'].to_s
      publication_date = article['webPublicationDate'].to_datetime
      fields = article['fields']
      subheading = fields['trailText'].to_s
      thumbnail = fields['thumbnail'].to_s
      body_text = fields['bodyText'].to_s

      return false if valid_article(subheading, body_text, thumbnail, category.mb_chars.length)

      Category.create(name: category)
      category_id = Category.find_by(name: category).id

      if new_article(api_article_id, headline, subheading,
                     body_text, category_id, thumbnail, publication_date)
        sort_keywords(article['tags'], api_article_id)
      end
    end

    def parse_personal_article(article, reader_id)
      api_article_id = article['id']
      category = article['sectionName'].to_s
      headline = article['webTitle'].to_s
      publication_date = article['webPublicationDate'].to_datetime
      fields = article['fields']
      subheading = fields['trailText'].to_s
      thumbnail = fields['thumbnail'].to_s
      body_text = fields['bodyText'].to_s

      return false if valid_article(subheading, body_text, thumbnail, category.mb_chars.length)

      category_id = Category.find_by(name: category).id

      if new_personal_article(api_article_id, headline, subheading,
                              body_text, category_id, thumbnail, publication_date, reader_id)
        sort_personal_keywords(article['tags'], api_article_id)
      end
    end

    def valid_article(subheading, body_text, thumbnail, category_size)
      unless !subheading['<'] && !body_text.strip.empty? &&
             !thumbnail.strip.empty? && category_size < 15
        true
      end
    end

    def new_article(api_id, headline, subheading, body_text, category_id, img_src, publication_date)
      new_article = Article.new(api_id: api_id, headline: headline,
                                subheading: subheading, body_text: body_text,
                                category_id: category_id, img_src: img_src,
                                created_at: Time.now, updated_at: Time.now,
                                publication_date: publication_date)
      new_article.save ? true : false
    end

    def new_personal_article(api_id, headline, subheading, body_text, category_id, img_src, publication_date, reader_id)
      new_personal_article = Reader.find(reader_id).personal_articles.new(api_id: api_id, headline: headline,
                                                 subheading: subheading, body_text: body_text,
                                                 category_id: category_id, img_src: img_src,
                                                 created_at: Time.now, updated_at: Time.now,
                                                 publication_date: publication_date)
      new_personal_article.save ? true : false
    end

    def sort_keywords(tags, api_article_id)
      tags.each do |tag|
        api_tag_id = tag['id'].to_s
        puts "TAAAAAAGGGGGGG IIIIIS: #{api_tag_id}"
        keyword = tag['webTitle'].to_s
        # Associate keyword with article
        cat = Category.find_by(name: keyword)

        if cat.nil?
          Article.find_by(api_id: api_article_id).keywords.create(name: keyword, tag: api_tag_id, created_at: Time.now, updated_at: Time.now)
        end
      end
    end

    def sort_personal_keywords(tags, api_article_id)
      tags.each do |tag|
        api_tag_id = tag['id'].to_s
        puts "TAAAAAAGGGGGGG IIIIIS: #{api_tag_id}"
        keyword = tag['webTitle'].to_s
        # Associate keyword with article
        cat = Category.find_by(name: keyword)

        if cat.nil?
          PersonalArticle.find_by(api_id: api_article_id).keywords.create(name: keyword, tag: api_tag_id, created_at: Time.now, updated_at: Time.now)
        end
      end
    end
  end
end
