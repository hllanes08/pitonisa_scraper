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
	search(site, "h1")
    end

    private

    def search(site, tag)
	site.css(tag).each do |item|
		p item.text
	end
    end
end
