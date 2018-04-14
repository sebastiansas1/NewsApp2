# == Schema Information
#
# Table name: keywords
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  relevance  :integer          default(0), not null
#  word_type  :string(255)
#  word_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag        :string(255)
#

class Keyword < ApplicationRecord
  belongs_to :word, polymorphic: true

  validates_uniqueness_of :name, scope: :word_id
  validates :relevance, inclusion: { in: 0..100 }
end
