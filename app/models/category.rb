# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  relevance  :integer          default(0), not null
#

class Category < ApplicationRecord
  has_many :articles

  validates_uniqueness_of :name
  validates :preferencial_score, inclusion: { in: 0..100 }
end
