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

require 'rails_helper'

RSpec.describe Action, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
