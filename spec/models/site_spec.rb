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
    def site(params = {})
    	defaults = {
	 url: "http://www.google.com",
	 name: "Google",
	 site_type: 0
	}
	Site.new(**defaults.merge(params))
    end
    it 'has a url' do
	#raise unless site(url: "http://www.google.com").url == "http://www.google.com" 
    	expect(site(url: "http://www.google.com").url).to eq ("http://www.google.com")
    end
    it 'has a name' do
        raise unless site(name: "Google").name == "Google" 
    end
    it 'hast a type' do
        raise unless site(site_type: 0).site_type == 0  
    end
end
