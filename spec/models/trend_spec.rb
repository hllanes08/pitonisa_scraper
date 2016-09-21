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

require 'rails_helper'

RSpec.describe Trend, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
