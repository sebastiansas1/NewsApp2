# == Schema Information
#
# Table name: personal_articles
#
#  id                      :integer          not null, primary key
#  api_id                  :string(255)
#  headline                :string(255)
#  subheading              :text(65535)
#  img_src                 :string(255)
#  body_text               :text(65535)
#  category_id             :integer
#  views                   :integer          default(0), not null
#  likes                   :integer          default(0), not null
#  rank                    :integer          default(0), not null
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float(24)        default(0.0)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  publication_date        :datetime
#  reader_id               :integer
#  read_date               :datetime
#

class PersonalArticle < ApplicationRecord
  acts_as_votable

  belongs_to :reader
  has_many :keywords, as: :word

  validates_uniqueness_of :api_id
end
