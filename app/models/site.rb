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
	trends =  Hash.new
	tags.each do |tag|
	    tag.split(" ").each do |split_word|
		next unless split_word.length > 4
		if trends.key?(split_word)
		    trends[split_word] += 1
		else
		    trends[split_word] = 1
		end
	    end	   
	end
	return trends.sort_by {|key, value| value}.reverse.to_h
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
