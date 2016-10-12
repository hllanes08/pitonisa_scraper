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

FactoryGirl.define do
  factory :search_tag do
    tag "MyString"
    search_tag_date "2016-10-12"
    created_by 1
  end
end
