# == Schema Information
#
# Table name: articles
#
#  id                       :integer          not null, primary key
#  headline                 :string
#  subheading               :string
#  keyword                  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  admin_id                 :integer
#  views                    :integer          default(0), not null
#  likes                    :integer          default(0), not null
#  category_id              :integer
#  article_img_file_name    :string
#  article_img_content_type :string
#  article_img_file_size    :integer
#  article_img_updated_at   :datetime
#

class Article < ApplicationRecord
    belongs_to :admin
    belongs_to :category
    has_many :orders
    has_many :readers, through: :orders 

    has_attached_file :article_img, :styles => { :article_index => "220x123>", :article_show => "650x400>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :article_img, :content_type => /\Aimage\/.*\z/
end
