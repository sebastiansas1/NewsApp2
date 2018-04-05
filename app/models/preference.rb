# == Schema Information
#
# Table name: preferences
#
#  id         :integer          not null, primary key
#  category   :string
#  relevance  :integer          default(0), not null
#  keyword_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  reader_id  :integer
#

class Preference < ApplicationRecord
    belongs_to :reader
    has_many :keywords
    
    validates :relevance, :inclusion => { :in => 0..100 }
end
