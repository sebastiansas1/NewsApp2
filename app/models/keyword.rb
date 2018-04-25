# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  name               :string
#  relevance          :integer          default(0), not null
#  word_type          :string
#  word_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  tag                :string
#  reader_id          :integer
#  category_id        :integer
#  preferencial_score :float
#

class Keyword < ApplicationRecord
  belongs_to :word, polymorphic: true

  validates_uniqueness_of :name, conditions: -> { where.not(reader_id: nil) }, scope: %i[reader_id category_id]
  validates :relevance, inclusion: { in: 0..100 }
end
