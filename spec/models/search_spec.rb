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

require 'rails_helper'

RSpec.describe Search, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
