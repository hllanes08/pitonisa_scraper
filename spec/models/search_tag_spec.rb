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

require 'rails_helper'

RSpec.describe SearchTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
