# == Schema Information
#
# Table name: trends
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  name       :string
#  trend_date :date
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :trend do
    site_id 1
name "MyString"
trend_date "2016-09-20"
rank 1
  end

end
