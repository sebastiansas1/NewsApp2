# == Schema Information
#
# Table name: articles
#
#  id                      :integer          not null, primary key
#  headline                :string(255)
#  subheading              :text(65535)
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
#  cached_weighted_average :float(24)        default(0.0)
#  img_src                 :string(255)
#  body_text               :text(65535)
#  api_id                  :string(255)
#  publication_date        :datetime
#

class Article < ApplicationRecord
  acts_as_votable

  belongs_to :category
  has_many :orders
  has_many :readers, through: :orders
  has_many :keywords, as: :word

  validates_uniqueness_of :api_id
end
