module StatisticsHelper

    class Normalizer

        def normalize(data, max_relevance)
            objects = data.all.extend(DescriptiveStatistics)
            objects.each do |object|
                rescale(object, max_relevance)
            end
        end

        # PRIVATE METHODS BELOW
        
        def rescale(object, max)
            x = object.relevance
            z = (x / max.to_f) * 100
            object.preferencial_score = z.round(2) 
            object.save
        end

        def zScore(x, mean, standard_deviation)
            return zScore = ((x - mean) / standard_deviation).round(2)
        end

        def zScore_relevance(object, mean, sd)
            zScore = zScore(object.relevance, mean, sd)
            percentage = getPercent(zScore)
            # object.relevance = rand(1..8)
            object.preferencial_score = percentage.round(2)
            object.save
        end

        def getPercentile(z)
            return 0 if z < -6.5
            return 1 if z > 6.5
          
            factk = 1
            sum = 0
            term = 1
            k = 0
          
            loopStop = Math.exp(-23)
            while term.abs > loopStop do
                term = 0.3989422804 * ((-1)**k) * (z**k) / (2*k+1) / (2**k) * (z**(k+1)) /factk
                sum += term
                k += 1
                factk *= k
            end
          
            sum += 0.5
            1-sum
        end

        def getPercent(zScore)

            if zScore > 0 
                negative = getPercentile(-zScore)
                positive = getPercentile(zScore)
                return percentage = (negative - positive) * 100 
            end

            if zScore < 0 
                negative = getPercentile(zScore)
                positive = getPercentile(-zScore)
                return percentage = (negative - positive) * 100 
            end

            if zScore == 0
                return 0
            end

        end

    end

    class Analyzer 

        def trending(keyword_name)
            group = KeywordStatistic.where(name: keyword_name).group(:id).group_by_day(:created_at)
            x = group.where("created_at > ?", 1.days.ago).count.size
            y = group.where(created_at: 2.days.ago..1.days.ago).count.size
            
            if (growth_rate(x.to_f, y.to_f) > 20.00)
                return true
            else
                return false
            end
        end

        def growth_rate(x,y)
            # Growth died
            if (x == 0 || y == 0)
                return 0
            else
                return rate = (((x - y) / y) * 100).round(2)
            end
        end

    end

    class Euclide 

        def euclidean_distance(a, b)

            distance = axis(a, b, 0)

            return Math.sqrt(distance)

        end

        def axis(a, b, index)

            return false if a[0].nil? || b[0].nil? || a.size != b.size
            
            return 0 if a[index].nil?
                
            axis_distance = (b[index] - a[index])**2
 
            return axis_distance += axis(a, b, index+1)

        end

    end

end
