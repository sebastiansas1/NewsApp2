# == Schema Information
#
# Table name: articles
#
#  id                      :integer          not null, primary key
#  headline                :string
#  subheading              :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  views                   :integer          default(0), not null
#  likes                   :integer          default(0), not null
#  category_id             :integer
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  img_src                 :string
#  body_text               :text
#  api_id                  :string
#  publication_date        :datetime
#  reader_id               :integer
#  rank                    :float            default(0.0), not null
#

class Article < ApplicationRecord
  acts_as_votable

  belongs_to :category
  has_many :orders
  has_many :readers, through: :orders
  has_many :keywords, as: :word

  validates_uniqueness_of :api_id, scope: :reader_id
  validates :rank, inclusion: { in: 0..100 }
end
