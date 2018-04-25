# == Schema Information
#
# Table name: keyword_statistics
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  keyword_id :integer
#

class KeywordStatistic < ApplicationRecord
  validates_uniqueness_of :created_at, scope: :keyword_id
end
