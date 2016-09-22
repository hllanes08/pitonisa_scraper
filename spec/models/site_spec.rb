# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  url        :string
#  name       :string
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Site, type: :model do
    it 'has a url' do
	raise unless Site.new(url: "http://www.google.com",name:"Google", site_type: 0).url == "http://www.google.com" 
    end
    it 'has a name' do
        raise unless Site.new(url: "http://www.google.com",name:"Google", site_type: 0).name == "Google" 
    end
    it 'hast a type' do
        raise unless Site.new(url: "http://www.google.com",name:"Google", site_type: 0).site_type == 0  
    end
end
