# == Schema Information
#
# Table name: search_tags
#
#  id              :integer          not null, primary key
#  tag             :string
#  search_tag_date :date
#  created_by      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class SearchTag < ApplicationRecord
    has_many :search_popularize, class_name: 'SearchPopularize'
end
