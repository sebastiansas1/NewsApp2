# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  headline   :string
#  subheading :string
#  topic      :string
#  keyword    :string
#  views      :integer
#  likes      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
end
