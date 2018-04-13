# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  relevance  :integer          default(0), not null
#

class Category < ApplicationRecord
  has_many :articles

  validates_uniqueness_of :name
end
