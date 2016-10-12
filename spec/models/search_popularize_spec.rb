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

require 'rails_helper'

RSpec.describe SearchPopularize, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
