# Module containing the GuardianApi class #
module ApiHelper
  require 'httparty'

  # Class to interact with the Guardian API #
  class GuardianApi
    # PARAMS
    KEY = '92a964bd-ab24-4367-b0e0-863008a6b7f5'.freeze
    PARAMS_KEY = "api-key=#{KEY}".freeze
    PAGE_SIZE = '&page-size=50'.freeze
    TAGS_KEYWORD = '&show-tags=keyword'.freeze
    FIELDS_ARTICLE = '&show-fields=trailText,thumbnail,bodyText'.freeze
    MOST_VIEWED = '&show-most-viewed=true'.freeze
    QUERY1 = '/search?'.freeze

    PARAMETERS_API = "#{PARAMS_KEY}#{PAGE_SIZE}#{TAGS_KEYWORD}#{FIELDS_ARTICLE}#{MOST_VIEWED}".freeze

    include HTTParty
    base_uri 'content.guardianapis.com'

    def initialize(service, _page)
      @options = { query: { site: service } }
    end

    # Method that creates new articles (limited to 50)
    # from the Guardian API #
    def all_articles
      json = self.class.get("#{QUERY1 + PARAMETERS_API}")
      puts "QUERY IS: #{QUERY1 + PARAMETERS_API}"
      response = json['response']
      articles = response['results']

      articles.each do |article|
        parse_article(article, nil)
      end
    end

    # Method that gathers articles based on the user's preferences #
    def search(tag_id, reader_id)
      json = self.class.get("#{QUERY1 + PARAMETERS_API}&tag=#{tag_id}")
      response = json['response']
      articles = response['results']

      articles.each do |article|
        parse_article(article, reader_id)
      end
    end

    private

    # Method to parse json information from the Guardian API #
    def parse_article(article, reader_id)
      api_article_id = article['id']
      category = article['sectionName'].to_s
      headline = article['webTitle'].to_s
      publication_date = article['webPublicationDate'].to_datetime
      fields = article['fields']
      subheading = fields['trailText'].to_s
      thumbnail = fields['thumbnail'].to_s
      body_text = fields['bodyText'].to_s
      
      return false if !valid_article(subheading, body_text, thumbnail, category.mb_chars.length)

      Category.create(name: category)
      category_id = Category.find_by(name: category).id

      if reader_id.nil?
        if new_article(api_article_id, headline, subheading,
                       body_text, category_id, thumbnail, publication_date)
          sort_keywords(article['tags'], api_article_id)
        end
      else

        if new_personal_article(api_article_id, headline, subheading,
                                body_text, category_id, thumbnail, 
                                publication_date, reader_id)
          sort_personal_keywords(article['tags'], api_article_id, reader_id, category_id)
        end
      end
    end

    # Method that validates the json format is valid  #
    def valid_article(subheading, body_text, thumbnail, category_size)
      if !subheading['<'] && !body_text.strip.empty? && !thumbnail.strip.empty? && category_size < 15
        true
      else
        false
      end
    end

    # Method that adds the new articles to the database  #
    def new_article(api_id, headline, subheading, body_text, category_id, img_src, publication_date)
      # Do not take articles older than 10 days ago
      return false if publication_date < 10.days.ago

      new_article = Article.new(api_id: api_id, headline: headline,
                                subheading: subheading, body_text: body_text,
                                category_id: category_id, img_src: img_src,
                                created_at: Time.now, updated_at: Time.now,
                                publication_date: publication_date)
      new_article.save ? true : false
    end

    # Method that adds the new personal articles to the database  #
    def new_personal_article(api_id, headline, subheading, body_text, category_id, img_src, publication_date, reader_id)
      # Do not take articles older than 10 days ago
      return false if publication_date < 10.days.ago

      # Do not take if user has already read the article
      return false if Reader.find(reader_id).orders.find_by(article_url: api_id)

      new_personal_article = Reader.find(reader_id)
                                   .articles
                                   .new(api_id: api_id, headline: headline,
                                        subheading: subheading, body_text: body_text,
                                        category_id: category_id, img_src: img_src,
                                        created_at: Time.now, updated_at: Time.now,
                                        publication_date: publication_date)
      new_personal_article.save ? true : false
    end

    # Method that associates keywords with the respective
    # article and adds them to the database  #
    def sort_keywords(tags, api_article_id)
      tags.each do |tag|
        api_tag_id = tag['id'].to_s
        keyword = tag['webTitle'].to_s
        # Avoid adding keywords that are also category names
        if Category.find_by(name: keyword).nil?
          # Associate keyword with article
          Article.find_by(api_id: api_article_id)
                 .keywords.create(name: keyword, tag: api_tag_id,
                                  created_at: Time.now, updated_at: Time.now)
        end
      end
    end

    def sort_personal_keywords(tags, api_article_id, reader_id, category_id)
      puts "Suggesting new article for #{Reader.find(reader_id).name}"
      tags.each do |tag|
        api_tag_id = tag['id'].to_s
        keyword = tag['webTitle'].to_s
        # Avoid adding keywords that are also category names
        if Category.find_by(name: keyword).nil?
          # Associate keyword with article
          Reader.find(reader_id)
                .articles.find_by(api_id: api_article_id)
                .keywords.create(name: keyword, tag: api_tag_id,
                                 category_id: category_id,
                                 created_at: Time.now, updated_at: Time.now)
        end
      end
    end

  end
end
