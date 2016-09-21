# == Schema Information
#
# Table name: actions
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :action do
    type ""
name "MyString"
user_id 1
  end

end
