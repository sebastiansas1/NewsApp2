# == Schema Information
#
# Table name: keywords
#
#  id         :integer          not null, primary key
#  name       :string
#  relevance  :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Keyword < ApplicationRecord
    belongs_to :preference
    
    validates :relevance, :inclusion => { :in => 0..100 }
end
