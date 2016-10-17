# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  url        :string
#  name       :string
#  site_type  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'nokogiri'
require 'restclient'
require 'rubygems'
require 'uri'
require 'thread'

class Site < ActiveRecord::Base
	belongs_to :user, class_name: 'User'
	def popularize
		site =  Nokogiri::HTML(RestClient.get(self.url))
		self.update_attribute(:name,site.css('title').text)
		trends =  Hash.next
		search_general(site, trends, nil)
		sub_search(site, trends, nil)
		return trends.sort_by { |key, value| value}.reverse.to_h
	end

	def popularize_by_key(key,user_id)
		site =  Nokogiri::HTML(RestClient.get(self.url))
		trends =  Hash.new
		ActiveRecord::Base.transaction do
			search_by_tag  = SearchTag.where(" tag = ? and search_tag_date between ? and ? ", key, DateTime.now.beginning_of_day, DateTime.now.end_of_day)	
			if search_by_tag.count == 0
				search_general(site, trends, key)
				sub_search(site, key, trends)
				#trends.merge(result){|k, a_value, b_value| a_value + b_value }
				search = SearchTag.new
				search.tag = key
				search.search_tag_date = Time.now
				search.user_id = user_id
				search.save!
				sorted = trends.sort_by { |key, value| value}.reverse.to_h
				limitless = trends.count > 10 ? 10 : trends.count
				sorted.first(limitless).each do |trend|
					s_p = SearchPopularize.new
					s_p.tag = trend[0]
					s_p.index = trend[1]
					s_p.search_tag_id = search.id
					s_p.save!
				end
				trends = sorted.first(limitless).to_h
			else
				SearchPopularize.where(search_tag_id:search_by_tag.first.id).order(index: :desc).all.each do |tag|
					trends[tag.tag] = tag.index
				end

			end

			search_and_delete(key)
			search = Search.new
			search.tag  = key
			search.search_date = Time.now
			search.user_id = user_id
			search.save
		end
		p trends
		return trends
	end

	private

	def search_and_delete(key)
		searches = Search.where("tag = ? and search_date betweeen ? and ? ", key, DateTime.now.beginning_of_day, DateTime.now.end_of_day)
	end

	def sub_search(site, key, trends)
		threads = []
		semaphore = Mutex.new
		site.css("a").each do |li|
			if !li['href'].nil? and li['href'].start_with? self.url
				#threads << Thread.new do
					url = li['href'].gsub(/\s+/,'')
					sub_result = Hash.new
					begin
						subsite =  Nokogiri::HTML(RestClient.get(url))
						#semaphore.synchronize do	
					     		search_general(subsite, trends, key)
							p trends
						#end
					rescue Exception => e

					end
				#end
			end
		end
		#threads.each(&:join)
		return trends
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
