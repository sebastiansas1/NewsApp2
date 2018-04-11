class KeywordStatistic < ApplicationRecord
    validates_uniqueness_of :created_at, :scope => :keyword_id
end
