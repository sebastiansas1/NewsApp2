# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  reader_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  strength   :integer
#  friend_id  :integer
#

class Friendship < ApplicationRecord
  belongs_to :reader

  validates :similarity, inclusion: { in: 0..100 }
end
