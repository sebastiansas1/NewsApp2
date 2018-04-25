# frozen_string_literal: true

module StatisticsHelper
	class Normalizer
		
    def normalize(objects, max_relevance)
      objects.each do |object|
        rescale(object, max_relevance)
      end
    end

    private

    def rescale(object, max)
      x = object.relevance
      z = (x / max.to_f) * 100
      object.preferencial_score = z.round(2)
      object.save
		end

  end

	class Analyzer
		
		def trending(keyword_name)
			# Get keyword usage over time
      group = KeywordStatistic.where(name: keyword_name)
                              .group(:id)
                              .group_by_day(:created_at)

			# Get keyword hits for today
			x = group.where('created_at > ?', 1.days.ago).count.size
			
			# Get keyword hits for two days ago
      y = group.where(created_at: 2.days.ago..1.days.ago).count.size

      growth_rate(x.to_f, y.to_f) > 20.00
		end

		def compute_similarity(friendships)
			friendships.each do |friendship|
				reader1 = Reader.find(friendship.reader_id)
				reader2 = Reader.find(friendship.friend_id)
				similarity(reader1, reader2)
			end
		end

    private 

    def growth_rate(x, y)
      # Growth died
      if x == 0 || y == 0
        0
      else
        rate = (((x - y) / y) * 100).round(2)
      end
		end
		
		def similarity(reader1, reader2)
      # Get all category-preferences for each reader
      reader1_c = reader1.preferences
			reader2_c = reader2.preferences

			friendship = reader1.friendships.find_by(friend_id: reader2.id)
			
			return false if reader1_c.count == 0 || reader2_c.count == 0

      # Get all keyword-preferences for each reader
      reader1_k = Keyword.where(reader_id: reader1.id)
                         .group(:name)
                         .sum(:preferencial_score)
      reader2_k = Keyword.where(reader_id: reader2.id)
                         .group(:name)
                         .sum(:preferencial_score)

      # Get all global preferences
      all_p = Preference.select(:category).distinct
      all_k = Keyword.where(word_type: 'Preference')
                     .select(:name).distinct

      # Initialize arrays used for categories (a & b) and for keywords (c & d)
      a,b,c,d = [],[],[],[]

      all_p.each_with_index do |p, index|
        p1 = reader1_c.find_by(category: p.category)
        p2 = reader2_c.find_by(category: p.category)
        a[index] = preferencial_score(p1)
        b[index] = preferencial_score(p2)
      end

      all_k.each_with_index do |k, index|
        k1 = reader1_k[k.name]
        k2 = reader2_k[k.name]
        c[index] = valid_score(k1)
        d[index] = valid_score(k2)
			end
			
			friendship.temp_distance = (euclidean_distance(a,b) + euclidean_distance(c,d)) / 2
			friendship.save
			friendship.distance = rescale(friendship.temp_distance, Friendship.maximum(:temp_distance))
			friendship.similarity = (100 - friendship.distance)
			friendship.save
    end

    def euclidean_distance(a, b)
      distance = axis(a, b, 0)
      Math.sqrt(distance)
    end

    def axis(a, b, index)
      return false if a[0].nil? || b[0].nil? || a.size != b.size
      return 0 if a[index].nil?
      axis_distance = (b[index] - a[index])**2
      axis_distance += axis(a, b, index + 1)
    end

    def preferencial_score(p)
      return 0 if p.nil?
      p.preferencial_score
    end

    def valid_score(k)
      return 0 if k.nil?
      k
		end
		
		def rescale(var, max)
      return ((var / max.to_f) * 100).round(2)
		end

  end
end
