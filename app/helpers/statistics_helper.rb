module StatisticsHelper

    class Normalizer


        def normalize(keywords)
            words = keywords.all.extend(DescriptiveStatistics)
            max_relevance = Keyword.where(word_type: "Preference").group(:name).sum(:relevance).values.max
            words.each do |word|
                rescale(word, max_relevance)
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

            if zScore = 0
                return 0
            end

        end


    end

end
