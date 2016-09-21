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

class Trend < ActiveRecord::Base
end
