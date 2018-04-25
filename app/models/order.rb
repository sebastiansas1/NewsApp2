# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  article_id  :integer
#  reader_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  article_url :string
#

class Order < ApplicationRecord
  belongs_to :reader
  belongs_to :article
end
