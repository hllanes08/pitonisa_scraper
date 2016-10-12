# == Schema Information
#
# Table name: searches
#
#  id          :integer          not null, primary key
#  tag         :string
#  search_date :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

FactoryGirl.define do
  factory :search do
    tag "MyString"
    search_date "2016-10-03"
  end
end
