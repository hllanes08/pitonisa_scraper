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
require 'nokogiri'
require 'restclient'
require 'rubygems'
require 'uri'

class Site < ActiveRecord::Base
    def popularize
	site =  Nokogiri::HTML(RestClient.get(self.url))
	self.update_attribute(:name,site.css('title').text)
	tags = []
	search(site, "h1", tags)
	search(site, "h2", tags)
	search(site, "h3", tags)
	search(site, "h4", tags)

	return tags
    end

    private

    def search(site, tag, tags)
	site.css(tag).each do |item|
		content =  item.text
		content = content.gsub(/\t/,'')
		content = content.gsub(/\n/,'')
		content = content.gsub(/\r/,'')
		tags.push content
	end
	return tags
    end
end
