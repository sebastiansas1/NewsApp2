# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  reader_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  strength   :integer
#  friend_id  :integer
#

class Friend < ApplicationRecord
  belongs_to :reader

  validates :strength, inclusion: { in: 0..100 }
end
