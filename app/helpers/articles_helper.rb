module ArticlesHelper
    class Ranker

        def rank(article, reader)

            rank = 0.0
            category_rank = 0.0
            keyword_rank = 0.0
            counter = 0

            category = Category.find(article.category_id).name
            keywords = article.keywords

            matched_category = reader.preferences.find_by(category: category)
            preference_keywords = Keyword.where(reader_id: reader.id).group(:name).sum(:preferencial_score)

            unless matched_category.nil?
                # We have a match! Increase Rank!
                category_rank += matched_category.preferencial_score
            end

            preference_keywords.keys.each_with_index do |key, index|

                if keywords.find_by(name: key)
                    # We have a match! Increase Rank!
                    keyword_rank += preference_keywords.values[index]
                    counter += 1
                end

            end

            final_rank = ((category_rank + (keyword_rank / counter)) / 2).round(2)

            if final_rank.nan?
                
                article.rank = 0.0
                article.save

            else

                article.rank = final_rank
                article.save

            end
            
        end

    end
end
