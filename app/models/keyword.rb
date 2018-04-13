# == Schema Information
#
# Table name: keywords
#
#  id         :integer          not null, primary key
#  name       :string
#  relevance  :integer          default(0), not null
#  word_type  :string
#  word_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Keyword < ApplicationRecord
  belongs_to :word, polymorphic: true

  validates_uniqueness_of :name, scope: :word_id
  validates :relevance, inclusion: { in: 0..100 }
end
