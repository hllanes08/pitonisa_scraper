# == Schema Information
#
# Table name: search_popularizes
#
#  id            :integer          not null, primary key
#  tag           :string
#  search_tag_id :integer
#  index         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :search_popularize do
    tag "MyString"
    search_id 1
    index 1
  end
end
