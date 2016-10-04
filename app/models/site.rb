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
    belongs_to :user, class_name: 'User'
    def popularize
	site =  Nokogiri::HTML(RestClient.get(self.url))
	self.update_attribute(:name,site.css('title').text)
	trends =  Hash.new
	search_general(site, trends, nil)
	sub_search(site, trends, nil)	
	return trends.sort_by { |key, value| value}.reverse.to_h
    end
    def popularize_by_key(key,user_id)
        site =  Nokogiri::HTML(RestClient.get(self.url)) 
    	trends =  Hash.new
 	search_general(site, trends, key)
	sub_search(site, trends, key)
	search_and_delete(key)
	search = Search.new
	search.tag = key
	search.search_date = Time.now
	search.user_id = user_id
	search.save!
	trends.sort_by { |key, value| value}.reverse.to_h 
	limitless = trends.count > 10 ? 10 : trends.count
   	trends.first(limitless).each do |trend|
	  s_p = SearchPopularize.new
	  s_p.tag = trend[0]
	  s_p.index = trend[1]
	  s_p.search_id = search.id
	  s_p.save!
	end
	return trends.first(limitless)	
    end
    
    private

    def search_and_delete(key)
	    searches = Search.where(tag:key, search_date: Time.now)#"search_date betweeen ? and ? ", key, Time.now.beginning_of_day, Time.now.end_of_day)
	searches.each do |search|
	    SearchPopularize.where(search_id:search.id).delete_all
	    search.delete
	end	
    end
    def sub_search(site, trends, key)
    	site.css("a").each do |li|
	    if !li['href'].nil? and li['href'].start_with? self.url
	       url = li['href'].gsub(/\s+/,'')
	       p url
	       subsite =  Nokogiri::HTML(RestClient.get(url))
	       search_general(subsite, trends, key)  
  	    end
	end	
    end
 
    def search_general(site, trends, key)
	content = []
       	search(site, "h1", content, key)
	search(site, "h2", content, key)
	search(site, "h3", content, key)
	search(site, "h4", content, key)
	search(site, "p", content, key)
	
	content.each do |tag|
	    tag.split(" ").each do |split_word| 
		next unless split_word.length > 4 && !(split_word.downcase.include? key)
		if trends.key?(split_word.downcase)
		    trends[split_word.downcase] += 1
		else
		    trends[split_word.downcase] = 1
		end
	    end	   
	end
    end
    def search(site, tag, tags, key)
	site.css(tag).each do |item|
	   if key.nil?
		tags.push reduce_content(item.text)	
	    else
		next unless item.text.downcase.include? key
		tags.push reduce_content(item.text)
	    end	    
	end
	return tags
    end

    def reduce_content(content)
   	 content = content.gsub(/\t/,'')
 	 content = content.gsub(/\n/,'')
	 content = content.gsub(/\r/,'') 
	 return content
    end
end
