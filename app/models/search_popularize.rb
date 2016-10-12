# == Schema Information
#
# Table name: search_popularizes
#
#  id         :integer          not null, primary key
#  tag        :string
#  search_id  :integer
#  index      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SearchPopularize < ApplicationRecord
   belong_to :search_tag, class_name: 'SearchTag'
end
