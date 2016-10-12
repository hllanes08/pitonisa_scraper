# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  url        :string
#  name       :string
#  site_type  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

FactoryGirl.define do
  factory :site do
    url "MyString"
name "MyString"
type 1
  end

end
